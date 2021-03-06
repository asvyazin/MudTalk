Class {
	#name : #MudTalkConnectionToServer,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'stream',
		'baseStream'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkConnectionToServer >> connectTo: aHost port: aPort [
	stream := SocketStream openConnectionToHost: aHost port: aPort.
	stream noTimeout.
	baseStream := TelnetStream on: stream
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
		nextPut: TelnetStream iac;
		nextPut: TelnetStream do;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> dont: option [ 
	stream
		nextPut: TelnetStream iac;
		nextPut: TelnetStream dont;
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
MudTalkConnectionToServer >> next [
	^ baseStream next
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
		nextPut: TelnetStream iac;
		nextPut: TelnetStream sb.
	aBlock value: stream.
	stream
		nextPut: TelnetStream iac;
		nextPut: TelnetStream se;
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> text: aText [
	stream nextPutAll: aText; crlf; flush
]

{ #category : #server }
MudTalkConnectionToServer >> will: option [ 
	stream
		nextPut: TelnetStream iac;
		nextPut: TelnetStream will;
		nextPut: (Character value: option);
		flush.
]

{ #category : #server }
MudTalkConnectionToServer >> wont: option [
	stream
		nextPut: TelnetStream iac;
		nextPut: TelnetStream wont;
		nextPut: (Character value: option);
		flush.
]
