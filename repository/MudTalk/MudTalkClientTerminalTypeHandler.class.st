Class {
	#name : #MudTalkClientTerminalTypeHandler,
	#superclass : #Object,
	#instVars : [
		'server'
	],
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
MudTalkClientTerminalTypeHandler >> do: option [ 
	(option = TelnetOption terminalType) ifTrue: [ self server will: TelnetOption terminalType ]
]

{ #category : #accessing }
MudTalkClientTerminalTypeHandler >> server [
	^ server
]

{ #category : #accessing }
MudTalkClientTerminalTypeHandler >> server: aConnection [
	server := aConnection
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> subnego: option data: aByteString [
	(option = TelnetOption terminalType) ifTrue: [
		self server subnegoStream: [ :stream |
			stream nextPut: TelnetOption terminalType;
				nextPut: TelnetTerminalType is;
				nextPutAll: self clientTerminalType ] ]
]

{ #category : #telnet }
MudTalkClientTerminalTypeHandler >> will: option [
	option = TelnetOption terminalType
		ifTrue: [ 
			self server do: TelnetOption terminalType.
			self server subnego: self bytesForSend option: TelnetOption terminalType ]
]
