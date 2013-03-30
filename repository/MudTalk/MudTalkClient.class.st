Class {
	#name : #MudTalkClient,
	#superclass : #Object,
	#instVars : [
		'window',
		'server',
		'escapeParser',
		'keyBindings',
		'msspParams',
		'telnetSettings',
		'gmcpSettings',
		'announcer',
		'currentInput',
		'inputHistory'
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

{ #category : #telnet }
MudTalkClient >> command: anEvent [
	| option |
	option := anEvent option.
	telnetSettings
		commandHandlerFor: option
		ifEnabled: [:handler | handler value: option]
		ifAbsent: [self unknownCommand: option]
]

{ #category : #connection }
MudTalkClient >> connectTo: aHost port: aPort [
	server := MudTalkConnectionToServer new.
	server announcer: announcer.
	announcer
		on: TelnetDoEvent send: #do: to: self;
		on: TelnetDontEvent send: #dont: to:self;
		on: TelnetWillEvent send: #will: to: self;
		on: TelnetWontEvent send: #wont: to: self;
		on: TelnetSubnegoEvent send: #subnego: to: self;
		on: TelnetCommandEvent send: #command: to: self;
		on: TelnetTextEvent send: #text: to: self;
		on: ServerDisconnectedEvent send: #disconnected to: self.
	server connectTo: aHost port: aPort
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
	telnetSettings
		ifOption: option
		unknown: [self unknownDo: option]
		disabled: [server wont: option]
		ignored: [^self]
		enabled: [:handler | handler do: option from: server]
]

{ #category : #telnet }
MudTalkClient >> dont: anEvent [
	| option |
	option := anEvent option.
	telnetSettings
		ifOption: option
		unknown: [self unknownDont: option]
		disabled: [server wont: option]
		ignored: [^self]
		enabled: [:handler | handler dont: option from: server]
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
	announcer := Announcer new.
	escapeParser := MudTalkClientEscapeParser new.
	inputHistory := MudTalkClientInputHistory new.
	window := MudTalkClientWindow labelled: 'MUD client'.
	window model: self.
	self initializeGmcpSettings.
	self initializeTelnetSettings.
	self initializeKeybindings
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
		disableCommand: TelnetCommand GA;
		disableCommand: TelnetCommand EOR;
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

{ #category : #mssp }
MudTalkClient >> msspParamsReceived: msspParamsCollection [
	msspParams := msspParamsCollection.
	msspParams do: [ :param |
		self trace: param name;
			trace: ' = ';
			traceCr: param values ]
]

{ #category : #initialization }
MudTalkClient >> openWindowOnHost: aHost port: aPort [
	self connectTo: (NetNameResolver addressForName: aHost) port: aPort.
	window openInWorld
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
	self serverText: aText.
	inputHistory appendCommand: aText.
	self clearInputPane
]

{ #category : #output }
MudTalkClient >> setOutput: aModel [
]

{ #category : #telnet }
MudTalkClient >> subnego: anEvent [
	| option |
	option := anEvent option.
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
	telnetSettings
		ifOption: option
		unknown: [self unknownWill: option]
		disabled: [server dont: option]
		ignored: [^self]
		enabled: [:handler | handler will: option from: server]
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
	telnetSettings
		ifOption: option
		unknown: [self unknownWont: option]
		disabled: [server dont: option]
		ignored: [^self]
		enabled: [:handler | handler wont: option from: server]
]
