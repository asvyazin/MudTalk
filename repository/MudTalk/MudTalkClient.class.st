Class {
	#name : #MudTalkClient,
	#superclass : #Model,
	#instVars : [
		'window',
		'server',
		'escapeParser',
		'keyBindings',
		'telnetSettings',
		'gmcpSettings',
		'inputHistory',
		'negotiatedOptions',
		'triggers',
		'aliases',
		'inputModel',
		'outputModel'
	],
	#classInstVars : [
		'window'
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

{ #category : #private }
MudTalkClient >> addAlias: anAlias [ 
	aliases add: anAlias
]

{ #category : #telnet }
MudTalkClient >> addNegotiatedOption: anOption enabled: enabled serverSide: serverSide [
	negotiatedOptions
		at: anOption
		put: (MudTalkClientNegotiatedOption new enabled: enabled; serverSide: serverSide; yourself)
]

{ #category : #private }
MudTalkClient >> addTrigger: aTrigger [
	triggers add: aTrigger
]

{ #category : #api }
MudTalkClient >> aliasParser: aParser do: aBlock [
	| newAlias |
	newAlias := MudTalkParserAlias new parser: aParser do: aBlock.
	self addAlias: newAlias.
	^ newAlias
]

{ #category : #api }
MudTalkClient >> aliasRegex: rxString do: aBlock [
	| newAlias |
	newAlias := MudTalkRegexAlias new regex: rxString do: aBlock.
	self addAlias: newAlias.
	^ newAlias
]

{ #category : #keybinding }
MudTalkClient >> bindKey: aKey to: anAction [ 
	window inputPane bindKeyCombination: aKey toAction: anAction
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
	self setInput: ''
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

{ #category : #initialization }
MudTalkClient >> initialize [
	super initialize.
	triggers := OrderedCollection new.
	aliases := OrderedCollection new.
	negotiatedOptions := Dictionary new.
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
	self aliasRegex: '/showNegotiatedOptions' do: [ self showNegotiatedOptions ]
]

{ #category : #initialization }
MudTalkClient >> initializeGmcpSettings [
	gmcpSettings := MudTalkClientGmcpSettings new.
	self announcer when: MudTalkGmcpMessage send: #debugGmcp: to: self.
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
		disableOption: TelnetOption newEnviron;
		disableOption: TelnetOption msdp;
		disableOption: TelnetOption mssp;
		enableOption: TelnetOption terminalType
			withHandler: MudTalkClientTerminalTypeHandler new;
		enableOption: TelnetOption gmcp
			withHandler:
				(MudTalkClientGmcpHandler new
					gmcpSettings: gmcpSettings;
					announcer: self announcer;
					yourself);
		yourself
]

{ #category : #input }
MudTalkClient >> inputAttributes [
	^ { TextColor color: Color lightBrown }
]

{ #category : #input }
MudTalkClient >> inputGetTextSelector [
	^ #value
]

{ #category : #'input history' }
MudTalkClient >> inputHistoryNext [
	self setInput: (inputHistory nextCommand)
]

{ #category : #'input history' }
MudTalkClient >> inputHistoryPrevious [
	self setInput: (inputHistory previousCommand)
]

{ #category : #input }
MudTalkClient >> inputModel [
	^ inputModel ifNil: [ inputModel := NewValueHolder new ]
]

{ #category : #input }
MudTalkClient >> inputSetTextSelector [
	^ #value:
]

{ #category : #keybinding }
MudTalkClient >> keyStroke: evt [
	self
		actionForEvent: evt
		ifPresent: [:handler | handler value. ^true].
	^ false
]

{ #category : #initialization }
MudTalkClient >> openWindowOnHost: aHost port: aPort [
	self connectTo: (NetNameResolver addressForName: aHost) port: aPort.
	window openInWorld
]

{ #category : #output }
MudTalkClient >> outputGetTextSelector [
	^ #value
]

{ #category : #output }
MudTalkClient >> outputModel [
	^ outputModel ifNil: [ outputModel := NewValueHolder new ]
]

{ #category : #output }
MudTalkClient >> outputSetTextSelector [
	^ #value:
]

{ #category : #input }
MudTalkClient >> processCurrentInput [
	self processInput: (self inputModel value)
]

{ #category : #input }
MudTalkClient >> processInput: aText [
	| str |
	str := aText asString shallowCopy.
	(self runAliases: str) ifFalse: [ self serverText: str ].
	inputHistory appendCommand: str.
	self clearInputPane
]

{ #category : #private }
MudTalkClient >> readLoop [
	[ [ server next processWith: self ] repeat ]
		on: NetworkError 
		do: [ :error |
			error printOn: Transcript.
			self disconnected ]
]

{ #category : #private }
MudTalkClient >> runAliases: aText [
	| aliasesCopy result |
	result := false.
	aliasesCopy := aliases copy.
	aliasesCopy do: [ :alias | result := (alias run: aText) or: [ result ] ].
	^ result
]

{ #category : #private }
MudTalkClient >> runTriggers: aText [
	| triggersCopy |
	"self traceCr: 'run triggers on: ', aText."
	triggersCopy := triggers copy.
	triggersCopy do: [ :trigger |
		((trigger run: aText) and: [trigger oneTime]) ifTrue: [ triggers remove: trigger ] ]
]

{ #category : #api }
MudTalkClient >> send: aText [
	self serverText: aText
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
MudTalkClient >> setInput: aString [ 
	self inputModel value: aString.
	self inputModel changed: self inputGetTextSelector.
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
	| str cleanStr |
	str := anEvent text.
	self runTriggers: str.
	cleanStr := self escapeParser cleanEscapesFrom: str.
	self runTriggers: cleanStr.
	window outputText: (self escapeParser parse: str)
]

{ #category : #api }
MudTalkClient >> triggerParser: aParser do: aBlock [
	| newTrigger |
	newTrigger := MudTalkParserTrigger new parser: aParser do: aBlock.
	self addTrigger: newTrigger.
	^ newTrigger
]

{ #category : #api }
MudTalkClient >> triggerRegex: rxString do: aBlock [
	| newTrigger |
	newTrigger := MudTalkRegexTrigger new regex: rxString do: aBlock.
	self addTrigger: newTrigger.
	^ newTrigger
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
