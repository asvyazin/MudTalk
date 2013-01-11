Class {
	#name : #MudTalkClient,
	#superclass : #Object,
	#instVars : [
		'window',
		'inputPane',
		'outputPane',
		'doHandlers',
		'willHandlers',
		'font',
		'telnetOptionHandlers',
		'server',
		'commandHandlers',
		'escapeParser',
		'escapeHandlers',
		'escapeTextAttributes',
		'textAttributes'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'instance creation' }
MudTalkClient class >> openWindowOnHost: aByteString port: aSmallInteger [ 
	self new openWindowOnHost: aByteString port: aSmallInteger.
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
	server := MudTalkConnectionToServer new connectTo: aHost port: aPort.
]

{ #category : #connection }
MudTalkClient >> connectionClosedText [
	^ '******* CONNECTION CLOSED *******' asText addAttribute: (TextColor color: Color red)
]

{ #category : #initialization }
MudTalkClient >> defaultTextAttribute [
	^ TextColor color: Color white
]

{ #category : #connection }
MudTalkClient >> disconnect [
	server ifNotNil: [ server terminate ].
]

{ #category : #connection }
MudTalkClient >> disconnected [
	self outputText: self connectionClosedText
]

{ #category : #telnet }
MudTalkClient >> do: cmd [
	telnetOptionHandlers at: cmd
		ifPresent: [ :handler | handler do: cmd ]
		ifAbsent: [ self unknownDoOption: cmd ]
]

{ #category : #'escape parsing' }
MudTalkClient >> escape: aByteString [
	| attributes |
	attributes := self escapeParser textAttributeParser parse: aByteString.
	attributes isPetitFailure
		ifTrue: [ self trace: 'unknown escape: '; traceCr: aByteString ]
		ifFalse: [ self textAttributes: attributes ]
]

{ #category : #'escape parsing' }
MudTalkClient >> escapeParser [
	^ escapeParser ifNil: [ escapeParser := MudTalkEscapeParser new ]
]

{ #category : #accessing }
MudTalkClient >> getInput [
	^nil.
]

{ #category : #initialization }
MudTalkClient >> initialize [
	super initialize.
	self initializeEscapeTextAttributes.
	self initializeTextAttributes.
	self installInputPane.
	self installOutputPane.
]

{ #category : #initialization }
MudTalkClient >> initializeEscapeTextAttributes [
	escapeTextAttributes := Dictionary new.
	escapeTextAttributes
		at: 0 put: self defaultTextAttribute;
		at: 1 put: TextEmphasis bold;
		at: 30 put: (TextColor color: Color black);
		at: 31 put: (TextColor color: Color red);
		at: 32 put: (TextColor color: Color green);
		at: 33 put: (TextColor color: Color yellow);
		at: 34 put: (TextColor color: Color blue);
		at: 35 put: (TextColor color: Color magenta);
		at: 36 put: (TextColor color: Color cyan);
		at: 37 put: (TextColor color: Color white)
]

{ #category : #initialization }
MudTalkClient >> initializeTelnetOptionHandlers [
	telnetOptionHandlers := Dictionary new.
	telnetOptionHandlers
		at: TelnetOption suppressGoAhead
		put: (MudTalkClientSuppressGoAheadHandler new server: self server client: self);
		at: TelnetOption terminalType
		put: (MudTalkClientTerminalTypeHandler new server: self server)
]

{ #category : #initialization }
MudTalkClient >> initializeTextAttributes [
	textAttributes := { self defaultTextAttribute }
]

{ #category : #private }
MudTalkClient >> inputAttributes [
	^ { TextColor color: Color lightBrown }
]

{ #category : #accessing }
MudTalkClient >> inputPane [
	^ inputPane ifNil: [
		inputPane := self window newTextEditorFor: self getText: #getInput setText: #sendCommand:.
		inputPane textColor: Color white;
			acceptOnCR: true;
			alwaysAccept: true]
]

{ #category : #initialization }
MudTalkClient >> installInputPane [
	self window
		addMorph: self inputPane
		fullFrame: (LayoutFrame fractions: (0@0.75 extent: 1@1)).
]

{ #category : #initialization }
MudTalkClient >> installOutputPane [
	self window
		addMorph: self outputPane
		fullFrame: (LayoutFrame fractions: (0@0 extent: 1@0.75)).
]

{ #category : #initialization }
MudTalkClient >> openConnectionOn: aHost port: aPort [
	self connectTo: aHost port: aPort.
	server events
		when: #disconnected send: #disconnected to: self;
		when: #do: send: #do: to: self;
		when: #dont: send: #dont: to: self;
		when: #will: send: #will: to: self;
		when: #wont: send: #wont: to: self;
		when: #subnego:data: send: #subnego:data: to: self;
		when: #command: send: #command: to: self;
		when: #text: send: #text: to: self
]

{ #category : #initialization }
MudTalkClient >> openWindowOnHost: aHost port: aPort [
	self openConnectionOn: (NetNameResolver addressForName: aHost) port: aPort.
	self initializeTelnetOptionHandlers.
	self window openInWorld.
	self inputPane takeKeyboardFocus.
]

{ #category : #accessing }
MudTalkClient >> outputPane [
	^ outputPane ifNil: [
		outputPane := self window newTextEditorFor: self getText: nil setText: nil.
		outputPane textColor: Color white]
]

{ #category : #outputting }
MudTalkClient >> outputText: aText [
	self outputPane appendText: aText
]

{ #category : #outputting }
MudTalkClient >> outputText: aText withAttributes: attributes [
	| textCopy |
	textCopy := aText copy.
	attributes do: [ :attr | textCopy addAttribute: attr ].
	self outputText: textCopy
]

{ #category : #connection }
MudTalkClient >> sendCommand: aText [
	| textForOutput |
	textForOutput := aText copy.
	textForOutput append: String cr.
	self outputText: textForOutput withAttributes: self inputAttributes.
	server text: aText.
	self changed: #getInput.
]

{ #category : #accessing }
MudTalkClient >> server [
	^ server
]

{ #category : #telnet }
MudTalkClient >> subnego: anOption data: aByteString [
	telnetOptionHandlers at: anOption
		ifPresent: [ :handler | handler subnego: anOption data: aByteString ]
		ifAbsent: [ self unknownSubnego: anOption data: aByteString ]
]

{ #category : #telnet }
MudTalkClient >> text: line [
	| tokens |
	tokens := self escapeParser parse: line.
	tokens do: [ :token | token triggerOn: self ].
]

{ #category : #'escape parsing' }
MudTalkClient >> textAttributes: newAttributeCodes [
	| newAttributes |
	newAttributes := OrderedCollection new.
	newAttributeCodes do: [ :each | escapeTextAttributes
		at: each
		ifPresent: [ :attr | newAttributes add: attr ] ].
	textAttributes := newAttributes asArray
]

{ #category : #'escape parsing' }
MudTalkClient >> unescapedText: aString [
	self outputText: aString asText withAttributes: textAttributes
]

{ #category : #telnet }
MudTalkClient >> unknownCommand: aTelnetCommand [
	^ self
		trace: 'unknown telnet command: ';
		traceCr: aTelnetCommand
]

{ #category : #telnet }
MudTalkClient >> unknownDoOption: cmd [
	self trace: 'unknown DO option: ';
		traceCr: cmd.
]

{ #category : #telnet }
MudTalkClient >> unknownSubnego: option data: aByteString [ 
	self trace: 'unknown SUBNEGO option: ';
		trace: option;
		trace: ', data size: ';
		traceCr: aByteString size.
]

{ #category : #telnet }
MudTalkClient >> unknownWillOption: cmd [
	self trace: 'unknown WILL option: ';
		traceCr: cmd.
]

{ #category : #telnet }
MudTalkClient >> unknownWontOption: anOption [ 
	self trace: 'unknown WONT option: ';
		traceCr: anOption.
]

{ #category : #telnet }
MudTalkClient >> will: cmd [
	telnetOptionHandlers at: cmd
		ifPresent: [ :handler | handler will: cmd ]
		ifAbsent: [ self unknownWillOption: cmd ]
]

{ #category : #accessing }
MudTalkClient >> window [
	^ window ifNil: [
		window := StandardWindow labelled: 'MUD client'.
		window theme: MudTalkClientTheme new]
]

{ #category : #telnet }
MudTalkClient >> wont: anOption [ 
	telnetOptionHandlers at: anOption
		ifPresent: [ :handler | handler value: anOption ]
		ifAbsent: [ self unknownWontOption: anOption ]
]
