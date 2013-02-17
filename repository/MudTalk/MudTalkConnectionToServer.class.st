Class {
	#name : #MudTalkConnectionToServer,
	#superclass : #Object,
	#instVars : [
		'events',
		'telnetStream',
		'stream'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkConnectionToServer >> connectTo: aHost port: aPort [
	stream := SocketStream openConnectionToHost: aHost port: aPort.
	stream noTimeout.
	telnetStream := TelnetStream on: stream.
	[self networkReadLoop]
		forkNamed: 'MUD client network reading process'
]

{ #category : #private }
MudTalkConnectionToServer >> debugOutputGmcpMessage: message [
	self trace: 'sending GMCP: '.
	message writeTo: Transcript.
	Transcript cr.
]

{ #category : #server }
MudTalkConnectionToServer >> disconnect [
	self traceCr: 'will disconnecting...'.
	stream close
]

{ #category : #server }
MudTalkConnectionToServer >> do: option [
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser doChar;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> dont: option [ 
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser dontChar;
		nextPut: (Character value: option);
		flush.
]

{ #category : #accessing }
MudTalkConnectionToServer >> events [
	^ events
]

{ #category : #server }
MudTalkConnectionToServer >> gmcp: message [
	self debugOutputGmcpMessage: message.
	self
		subnego: TelnetOption gmcp
		block: [:strm | message writeTo: strm]
]

{ #category : #initialization }
MudTalkConnectionToServer >> initialize [
	super initialize.
	events := EventManager new
]

{ #category : #private }
MudTalkConnectionToServer >> networkReadLoop [
	[[self processTelnetToken] repeat]
		on: NetworkError
		do: [self events triggerEvent: #disconnected]
]

{ #category : #private }
MudTalkConnectionToServer >> processTelnetToken [
	| token |
	token := telnetStream next.
	token triggerOn: self events.
]

{ #category : #server }
MudTalkConnectionToServer >> subnego: aByteArray [
	self subnegoStream: [:strm | strm nextPutAll: aByteArray]
]

{ #category : #server }
MudTalkConnectionToServer >> subnego: anOption block: aBlock [
	self subnegoStream: [:strm |
		strm nextPut: anOption.
		aBlock value: strm]
]

{ #category : #server }
MudTalkConnectionToServer >> subnego: aByteArray option: anOption [
	self subnegoStream: [:strm | strm nextPut: anOption; nextPutAll: aByteArray]
]

{ #category : #server }
MudTalkConnectionToServer >> subnegoStream: aBlock [
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser sbChar.
	aBlock value: stream.
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser seChar;
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> text: aText [
	stream nextPutAll: aText; crlf; flush
]

{ #category : #server }
MudTalkConnectionToServer >> will: option [ 
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser willChar;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> wont: option [
	stream
		nextPut: TelnetParser iacChar;
		nextPut: TelnetParser wontChar;
		nextPut: (Character value: option);
		flush.
]
