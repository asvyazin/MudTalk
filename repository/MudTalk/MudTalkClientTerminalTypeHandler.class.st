Class {
	#name : #MudTalkClientTerminalTypeHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#category : #'MudTalk-Client'
}

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> bytesForSend [
	^ {(TelnetTerminalType send)} asByteArray
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> clientTerminalType [
	^ 'MudTalk v0.1'
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> subnego: option data: aByteString from: server [
	server subnegoStream: [:stream |
		stream
			nextPut: TelnetOption terminalType;
			nextPut: TelnetTerminalType is;
			nextPutAll: self clientTerminalType]
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> will: option from: server [
	super will: option from: server.
	server
		subnego: self bytesForSend
		option: TelnetOption terminalType
]
