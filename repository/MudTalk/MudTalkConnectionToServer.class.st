Class {
	#name : #MudTalkConnectionToServer,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'telnetStream',
		'stream',
		'telnetParser'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkConnectionToServer >> announcer: anAnnouncer [ 
	announcer := anAnnouncer
]

{ #category : #initialization }
MudTalkConnectionToServer >> connectTo: aHost port: aPort [
	stream := SocketStream openConnectionToHost: aHost port: aPort.
	stream noTimeout.
	telnetParser := TelnetParser new.
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
		nextPut: TelnetParser iac;
		nextPut: TelnetParser do;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> dont: option [ 
	stream
		nextPut: TelnetParser iac;
		nextPut: TelnetParser dont;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> gmcp: message [
	self debugOutputGmcpMessage: message.
	self
		subnego: TelnetOption gmcp
		block: [:strm | message writeTo: strm]
]

{ #category : #private }
MudTalkConnectionToServer >> networkReadLoop [
	[[self processTelnetTokens] repeat]
		on: NetworkError
		do: [:error |
			error printOn: Transcript.
			announcer announce: ServerDisconnectedEvent new]
]

{ #category : #private }
MudTalkConnectionToServer >> processTelnetTokens [
	| buffer tokens |
	buffer := stream nextAvailable.
	tokens := telnetParser parse: buffer.
	tokens do: [:each | announcer announce: each]
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
		nextPut: TelnetParser iac;
		nextPut: TelnetParser sb.
	aBlock value: stream.
	stream
		nextPut: TelnetParser iac;
		nextPut: TelnetParser se;
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> text: aText [
	stream nextPutAll: aText; crlf; flush
]

{ #category : #server }
MudTalkConnectionToServer >> will: option [ 
	stream
		nextPut: TelnetParser iac;
		nextPut: TelnetParser will;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> wont: option [
	stream
		nextPut: TelnetParser iac;
		nextPut: TelnetParser wont;
		nextPut: (Character value: option);
		flush.
]
