Class {
	#name : #MudTalkClient,
	#superclass : #Object,
	#instVars : [
		'window',
		'server',
		'escapeParser',
		'keyBindings',
		'telnetSettings',
		'gmcpSettings',
		'announcer',
		'currentInput',
		'inputHistory',
		'negotiatedOptions',
		'clientCommands'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'instance creation' }
MudTalkClient class >> openWindowOnHost: aByteString port: aSmallInteger [ 
	self new openWindowOnHost: aByteString port: aSmallInteger.
]

{ #category : #keybinding }
MudTalkClient >> actionForEvent: evt ifPresent: anAction [ 
	keyBindings
		do: [:keyBinding | (keyBinding matchEvent: evt)
			ifTrue: [anAction value: (keyBinding action)]]
]

{ #category : #telnet }
MudTalkClient >> addNegotiatedOption: anOption enabled: enabled serverSide: serverSide [
	negotiatedOptions
		at: anOption
		put: (MudTalkClientNegotiatedOption new enabled: enabled; serverSide: serverSide; yourself)
]

{ #category : #keybinding }
MudTalkClient >> bindKey: aKey to: anAction [ 
	keyBindings
		add: (MudTalkClientKeyBinding new key: aKey action: anAction)
]

{ #category : #keybinding }
MudTalkClient >> bindStandardKeys [
	self
		bindKey: #num2 asKey to: [ self serverText: 'south' ];
		bindKey: #num8 asKey to: [ self serverText: 'north' ];
		bindKey: #num4 asKey to: [ self serverText: 'west' ];
		bindKey: #num6 asKey to: [ self serverText: 'east' ];
		bindKey: #num7 asKey to: [ self serverText: 'northwest' ];
		bindKey: #num9 asKey to: [ self serverText: 'northeast' ];
		bindKey: #num1 asKey to: [ self serverText: 'southwest' ];
		bindKey: #num3 asKey to: [ self serverText: 'southeast' ]
]

{ #category : #input }
MudTalkClient >> clearInputPane [
	currentInput := nil.
	self changed: #getInput
]

{ #category : #output }
MudTalkClient >> clientOutput: aText [
	| textForOutput |
	textForOutput := aText copy asText.
	textForOutput append: String cr.
	window outputText: textForOutput withAttributes: self clientOutputAttributes
]

{ #category : #output }
MudTalkClient >> clientOutputAttributes [
	^ { TextColor color: Color orange }
]

{ #category : #telnet }
MudTalkClient >> command: anEvent [
	| code |
	code := anEvent code.
	self trace: 'COMMAND: '; traceCr: code.
	telnetSettings
		commandHandlerFor: code
		ifEnabled: [:handler | handler value: code]
		ifAbsent: [self unknownCommand: code]
]

{ #category : #connection }
MudTalkClient >> connectTo: aHost port: aPort [
	server := MudTalkConnectionToServer new.
	server connectTo: aHost port: aPort.
	[ self readLoop ]
		forkNamed: 'MUD client network reading process'
]

{ #category : #connection }
MudTalkClient >> connectionClosedText [
	^ '******* CONNECTION CLOSED *******' asText addAttribute: (TextColor color: Color red)
]

{ #category : #gmcp }
MudTalkClient >> debugGmcp: gmcpMessage [
	self traceCr: gmcpMessage printString
]

{ #category : #connection }
MudTalkClient >> disconnect [
	server ifNotNil: [server disconnect]
]

{ #category : #connection }
MudTalkClient >> disconnected [
	window outputText: self connectionClosedText
]

{ #category : #telnet }
MudTalkClient >> do: anEvent [
	| option |
	option := anEvent option.
	self trace: 'DO: '; traceCr: option.
	telnetSettings
		ifOption: option
		unknown: [self unknownDo: option]
		disabled: [
			self addNegotiatedOption: option enabled: false serverSide: false.
			server wont: option]
		ignored: [^self]
		enabled: [:handler | 
			self addNegotiatedOption: option enabled: true serverSide: false.
			handler do: option from: server]
]

{ #category : #telnet }
MudTalkClient >> dont: anEvent [
	| option |
	option := anEvent option.
	self trace: 'DONT: '; traceCr: option.
	telnetSettings
		ifOption: option
		unknown: [self unknownDont: option]
		disabled: [
			self addNegotiatedOption: option enabled: false serverSide: false.
			server wont: option]
		ignored: [^self]
		enabled: [:handler |
			self addNegotiatedOption: option enabled: false serverSide: false.
			server wont: option]
]

{ #category : #'escape parsing' }
MudTalkClient >> escapeParser [
	^ escapeParser
]

{ #category : #input }
MudTalkClient >> getInput [
	^ currentInput
]

{ #category : #output }
MudTalkClient >> getOutput [
	^ nil
]

{ #category : #initialization }
MudTalkClient >> initialize [
	super initialize.
	clientCommands := Dictionary new.
	negotiatedOptions := Dictionary new.
	announcer := Announcer new.
	escapeParser := MudTalkClientEscapeParser new.
	inputHistory := MudTalkClientInputHistory new.
	window := MudTalkClientWindow labelled: 'MUD client'.
	window model: self.
	self initializeGmcpSettings.
	self initializeTelnetSettings.
	self initializeClientCommands.
	self initializeKeybindings
]

{ #category : #initialization }
MudTalkClient >> initializeClientCommands [
	self onClientCommand: '/showNegotiatedOptions' do: [ self showNegotiatedOptions ]
]

{ #category : #initialization }
MudTalkClient >> initializeGmcpSettings [
	gmcpSettings := MudTalkClientGmcpSettings new
		enablePackage: 'Core';
		enablePackage: 'Char';
		enablePackage: 'Char.Skills';
		enablePackage: 'Char.Items';
		enablePackage: 'Room';
		enablePackage: 'Redirect';
		enablePackage: 'Debug';
		enablePackage: 'IRE.Composer';
		registerMessage: MudTalkGmcpRoomInfo;
		registerMessage: MudTalkGmcpRoomWrongdir;
		registerMessage: MudTalkGmcpCoreGoodbye;
		yourself.
	announcer on: MudTalkGmcpMessage send: #debugGmcp: to: self.
]

{ #category : #initialization }
MudTalkClient >> initializeKeybindings [
	keyBindings := OrderedCollection new.
	self bindStandardKeys.
	window on: #keyStroke send: #keyStroke: to: self
	
]

{ #category : #initialization }
MudTalkClient >> initializeTelnetSettings [
	telnetSettings := MudTalkClientTelnetSettings new
		disableCommand: TelnetOption ga;
		disableCommand: TelnetOption eor;
		disableOption: TelnetOption naws;
		disableOption: TelnetOption compress;
		disableOption: TelnetOption compress2;
		disableOption: TelnetOption echo;
		disableOption: TelnetOption suppressGoAhead;
		enableOption: TelnetOption terminalType
			withHandler: MudTalkClientTerminalTypeHandler new;
		enableOption: TelnetOption gmcp
			withHandler:
				(MudTalkClientGmcpHandler new
					gmcpSettings: gmcpSettings;
					announcer: announcer;
					yourself);
		yourself
]

{ #category : #input }
MudTalkClient >> inputAttributes [
	^ { TextColor color: Color lightBrown }
]

{ #category : #'input history' }
MudTalkClient >> inputHistoryNext [
	currentInput := inputHistory nextCommand.
	self changed: #getInput
]

{ #category : #'input history' }
MudTalkClient >> inputHistoryPrevious [
	currentInput := inputHistory previousCommand.
	self changed: #getInput
]

{ #category : #keybinding }
MudTalkClient >> keyStroke: evt [
	self
		actionForEvent: evt
		ifPresent: [:handler | handler value. ^true].
	^ false
]

{ #category : #'client commands' }
MudTalkClient >> onClientCommand: command do: aBlock [
	clientCommands at: command put: aBlock
]

{ #category : #initialization }
MudTalkClient >> openWindowOnHost: aHost port: aPort [
	self connectTo: (NetNameResolver addressForName: aHost) port: aPort.
	window openInWorld
]

{ #category : #private }
MudTalkClient >> readLoop [
	[ [ server next processWith: self ] repeat ]
		on: NetworkError 
		do: [ :error |
			error printOn: Transcript.
			self disconnected ]
]

{ #category : #connection }
MudTalkClient >> serverText: aText [
	| textForOutput |
	textForOutput := aText copy asText.
	textForOutput append: String cr.
	window outputText: textForOutput withAttributes: self inputAttributes.
	server text: aText
]

{ #category : #input }
MudTalkClient >> setInput: aText [
	(aText asString isClientSideCommand)
		ifTrue: [ 
			clientCommands
				at: (aText asString)
				ifPresent: [ :block | block value ]
				ifAbsent: [ self clientOutput: ('unknown client command: ', aText) ] ]
		ifFalse: [ self serverText: aText ].
	inputHistory appendCommand: aText.
	self clearInputPane
]

{ #category : #output }
MudTalkClient >> setOutput: aModel [
]

{ #category : #'client commands' }
MudTalkClient >> showNegotiatedOptions [
	| text telnetOption |
	negotiatedOptions keysAndValuesDo: [ :option :data |
		telnetOption := TelnetOption on: option.
		text := 'option: ', telnetOption asString, ', server: ', data serverSide asString, ', client: ', data serverSide not asString, ', enabled: ', data enabled asString.
		self clientOutput: text ]
]

{ #category : #telnet }
MudTalkClient >> subnego: anEvent [
	| option |
	option := anEvent option.
	self trace: 'SUBNEGO: '; traceCr: option.
	telnetSettings
		ifOption: option
		unknown: [self unknownSubnego: option]
		disabled: [^self]
		ignored: [^self]
		enabled: [:handler | handler subnego: option data: anEvent data from: server]
]

{ #category : #telnet }
MudTalkClient >> text: anEvent [
	window outputText: (self escapeParser parse: anEvent text)
]

{ #category : #telnet }
MudTalkClient >> unknownCommand: aTelnetCommand [
	self
		trace: 'unknown telnet command: ';
		traceCr: aTelnetCommand
]

{ #category : #telnet }
MudTalkClient >> unknownDo: anOption [
	self
		trace: 'unknown DO: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownDont: anOption [
	self
		trace: 'unknown DONT: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownSubnego: anOption [
	self
		trace: 'unknown SUBNEGO: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownWill: anOption [
	self
		trace: 'unknown WILL: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownWont: anOption [
	self
		trace: 'unknown WONT: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> will: anEvent [
	| option |
	option := anEvent option.
	self trace: 'WILL: '; traceCr: option.
	telnetSettings
		ifOption: option
		unknown: [self unknownWill: option]
		disabled: [
			self addNegotiatedOption: option enabled: false serverSide: true.
			server dont: option]
		ignored: [^self]
		enabled: [:handler | 
			self addNegotiatedOption: option enabled: true serverSide: true.
			handler will: option from: server]
]

{ #category : #updating }
MudTalkClient >> windowIsClosing [
	super windowIsClosing.
	self disconnect
]

{ #category : #telnet }
MudTalkClient >> wont: anEvent [
	| option |
	option := anEvent option.
	self trace: 'WONT: '; traceCr: option.
	telnetSettings
		ifOption: option
		unknown: [self unknownWont: option]
		disabled: [
			self addNegotiatedOption: option enabled: false serverSide: true.
			server dont: option]
		ignored: [^self]
		enabled: [:handler | 
			self addNegotiatedOption: option enabled: false serverSide: true.
			handler wont: option from: server]
]
