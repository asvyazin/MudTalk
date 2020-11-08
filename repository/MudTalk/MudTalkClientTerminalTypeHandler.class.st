Class {
	#name : #MudTalkClientTerminalTypeHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#instVars : [
		'requestSequenceNumber'
	],
	#category : #'MudTalk-Client'
}

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> bytesForSend [
	^ {(TelnetTerminalType send)} asByteArray
]

{ #category : #initialization }
MudTalkClientTerminalTypeHandler >> initialize [
	super initialize.
	requestSequenceNumber := 0
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> subnego: option data: aByteString from: server [
	server subnegoStream: [ :stream |
		stream
			nextPut: TelnetOption terminalType;
			nextPut: TelnetTerminalType is;
			nextPutAll: self terminalTypeResponse ]
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> terminalTypeResponse [
	requestSequenceNumber := requestSequenceNumber + 1.
	(requestSequenceNumber = 1) ifTrue: [ ^ 'MUDTALK' ].
	(requestSequenceNumber = 2) ifTrue: [ ^ 'ANSI' ].
	^ 'MTTS 5'
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> will: option from: server [
	super will: option from: server.
	server
		subnego: self bytesForSend
		option: TelnetOption terminalType
]
