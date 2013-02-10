Class {
	#name : #MudTalkClient,
	#superclass : #Object,
	#instVars : [
		'window',
		'server',
		'commandHandlers',
		'escapeParser',
		'keyBindings',
		'msspParams',
		'telnetSettings',
		'gmcpSettings'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'instance creation' }
MudTalkClient class >> openWindowOnHost: aByteString port: aSmallInteger [ 
	self new openWindowOnHost: aByteString port: aSmallInteger.
]

{ #category : #keybinding }
MudTalkClient >> actionForEvent: evt ifPresent: anAction [ 
	self keyBindings do: [ :keyBinding |
		(keyBinding matchEvent: evt) ifTrue: [ anAction value: (keyBinding action) ] ]
]

{ #category : #keybinding }
MudTalkClient >> bindKey: aKey to: anAction [ 
	self keyBindings add: (MudTalkClientKeyBinding new key: aKey action: anAction)
]

{ #category : #initialization }
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

{ #category : #telnet }
MudTalkClient >> command: aTelnetCommand [
	self commandHandlers
		at: aTelnetCommand
		ifPresent: [ :handler | handler value: aTelnetCommand ]
		ifAbsent: [ self unknownCommand: aTelnetCommand ]
]

{ #category : #accessing }
MudTalkClient >> commandHandlers [
	^ commandHandlers ifNil: [ commandHandlers := Dictionary new ]
]

{ #category : #connection }
MudTalkClient >> connectTo: aHost port: aPort [
	server := MudTalkConnectionToServer new.
	server events
		when: #disconnected send: #disconnected to: self;
		when: #do: send: #do: to: self;
		when: #dont: send: #dont: to: self;
		when: #will: send: #will: to: self;
		when: #wont: send: #wont: to: self;
		when: #subnego:data: send: #subnego:data: to: self;
		when: #command: send: #command: to: self;
		when: #text: send: #text: to: self.
	server connectTo: aHost port: aPort
]

{ #category : #connection }
MudTalkClient >> connectionClosedText [
	^ '******* CONNECTION CLOSED *******' asText addAttribute: (TextColor color: Color red)
]

{ #category : #connection }
MudTalkClient >> disconnect [
	server ifNotNil: [ server terminate ].
]

{ #category : #connection }
MudTalkClient >> disconnected [
	self window outputText: self connectionClosedText
]

{ #category : #telnet }
MudTalkClient >> do: anOption [
	telnetSettings ifOption: anOption
		unknown: [self unknownDo: anOption]
		disabled: [server wont: anOption]
		ignored: [^self]
		enabled: [:handler | handler do: anOption from: server]
]

{ #category : #telnet }
MudTalkClient >> dont: anOption [
	telnetSettings ifOption: anOption
		unknown: [self unknownDont: anOption]
		disabled: [server wont: anOption]
		ignored: [^self]
		enabled: [:handler | handler dont: anOption from: server]
]

{ #category : #private }
MudTalkClient >> escapeParser [
	^ escapeParser ifNil: [ escapeParser := MudTalkClientEscapeParser new ]
]

{ #category : #input }
MudTalkClient >> getInput [
	^nil.
]

{ #category : #output }
MudTalkClient >> getOutput [
	^ nil
]

{ #category : #accessing }
MudTalkClient >> gmcpSettings [
	^ gmcpSettings ifNil: [ gmcpSettings := MudTalkClientGmcpSettings new ]
]

{ #category : #input }
MudTalkClient >> initialize [
	super initialize.
	self initializeTelnetSettings.
	self initializeGmcpSettings.
	self initializeKeybindings
]

{ #category : #initialization }
MudTalkClient >> initializeGmcpSettings [
	self gmcpSettings
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
		registerMessage: MudTalkGmcpCoreGoodbye
]

{ #category : #initialization }
MudTalkClient >> initializeKeybindings [
	self window on: #keyStroke send: #keyStroke: to: self.
	self bindStandardKeys
]

{ #category : #input }
MudTalkClient >> initializeTelnetSettings [
	telnetSettings := MudTalkClientTelnetSettings new.
	telnetSettings
		disableOption: TelnetOption naws;
		disableOption: TelnetOption compress;
		disableOption: TelnetOption compress2;
		disableOption: TelnetOption echo;
		disableOption: TelnetOption suppressGoAhead;
		enableOption: TelnetOption terminalType
			withHandler: MudTalkClientTerminalTypeHandler new;
		enableOption: TelnetOption gmcp
			withHandler: (MudTalkClientGmcpHandler new gmcpSettings: self gmcpSettings)
]

{ #category : #private }
MudTalkClient >> inputAttributes [
	^ { TextColor color: Color lightBrown }
]

{ #category : #keybinding }
MudTalkClient >> keyBindings [
	^ keyBindings ifNil: [ keyBindings := OrderedCollection new ]
]

{ #category : #keybinding }
MudTalkClient >> keyStroke: evt [
	self actionForEvent: evt ifPresent: [ :handler | handler value. ^true ].
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
	self window openInWorld
]

{ #category : #accessing }
MudTalkClient >> server [
	^ server
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
	self changed: #getInput
]

{ #category : #output }
MudTalkClient >> setOutput: aModel [
]

{ #category : #telnet }
MudTalkClient >> subnego: anOption data: aByteString [
	telnetSettings ifOption: anOption
		unknown: [self unknownSubnego: anOption]
		disabled: [^self]
		ignored: [^self]
		enabled: [:handler | handler subnego: anOption data: aByteString from: server]
]

{ #category : #telnet }
MudTalkClient >> text: aText [
	self window outputText: (self escapeParser parse: aText)
]

{ #category : #telnet }
MudTalkClient >> unknownCommand: aTelnetCommand [
	self
		trace: 'unknown telnet command: ';
		traceCr: aTelnetCommand
]

{ #category : #telnet }
MudTalkClient >> unknownDo: anOption [
	self trace: 'unknown DO: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownDont: anOption [
	self trace: 'unknown DONT: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownSubnego: anOption [
	self trace: 'unknown SUBNEGO: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownWill: anOption [
	self trace: 'unknown WILL: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> unknownWont: anOption [
	self trace: 'unknown WONT: ';
		traceCr: anOption
]

{ #category : #telnet }
MudTalkClient >> will: anOption [
	telnetSettings ifOption: anOption
		unknown: [self unknownWill: anOption]
		disabled: [server dont: anOption]
		ignored: [^self]
		enabled: [:handler | handler will: anOption from: server]
]

{ #category : #accessing }
MudTalkClient >> window [
	^ window ifNil: [ window := MudTalkClientWindow new on: self ]
]

{ #category : #telnet }
MudTalkClient >> wont: anOption [
	telnetSettings ifOption: anOption
		unknown: [self unknownWont: anOption]
		disabled: [server dont: anOption]
		ignored: [^self]
		enabled: [:handler | handler wont: anOption from: server]
]
