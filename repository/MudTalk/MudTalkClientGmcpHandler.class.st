Class {
	#name : #MudTalkClientGmcpHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#instVars : [
		'gmcpDataParser'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientGmcpHandler >> clientName [
	^ 'MudTalk'
]

{ #category : #accessing }
MudTalkClientGmcpHandler >> clientVersion [
	^ '0.1'
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> do: anOption from: server [
	super do: anOption from: server.
	self sendCoreHelloTo: server.
	self sendCoreSupportsSetTo: server
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> gmcpDataParser [
	^ gmcpDataParser ifNil: [ gmcpDataParser := self newGmcpDataParser ]
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> messageName [
	^ #space asParser negate star flatten
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> newGmcpDataParser [
	^ self messageName, #space asParser, (#any asParser star flatten) ==> [ :tokens |
		MudTalkGmcpMessageData name: (tokens at: 1) data: (tokens at: 3) ]
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> sendCoreHelloTo: server [
	(MudTalkGmcpCoreHello new client: self clientName version: self clientVersion) sendTo: server
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> sendCoreSupportsSetTo: server [
	MudTalkGmcpCoreSupportsSet new
		package: 'Core' version: '1';
		package: 'Char' version: '1';
		package: 'Comm' version: '1';
		package: 'Room' version: '1';
		package: 'Redirect' version: '1';
		package: 'Char.Skills' version: '1';
		package: 'Char.Items' version: '1';
		package: 'Debug' version: '1';
		package: 'IRE.Composer' version: '1';
		sendTo: server
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> subnego: anOption data: gmcpData from: server [
	| parsedGmcp gmcpMessage |
	gmcpData ifEmpty: [ ^self ].
	parsedGmcp := self gmcpDataParser parse: gmcpData.
	gmcpMessage := parsedGmcp asMessage.
	self trace: 'received GMCP: ';
		traceCr: gmcpData
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> will: anOption from: server [
	super will: anOption from: server.
	self sendCoreHelloTo: server.
	self sendCoreSupportsSetTo: server
]
