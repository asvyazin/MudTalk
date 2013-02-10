Class {
	#name : #MudTalkClientGmcpHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#instVars : [
		'gmcpDataParser',
		'gmcpSettings'
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

{ #category : #accessing }
MudTalkClientGmcpHandler >> gmcpSettings: settings [
	gmcpSettings := settings
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> messageBody [
	^ #any asParser star flatten trim
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> messageName [
	^ #space asParser negate star flatten
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> newGmcpDataParser [
	^ (self messageName , self messageBody)
		==> [ :tokens | MudTalkGmcpMessageData name: (tokens at: 1) data: (tokens at: 2) ]
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> sendCoreHelloTo: server [
	(MudTalkGmcpCoreHello new client: self clientName version: self clientVersion) sendTo: server
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> sendCoreSupportsSetTo: server [
	MudTalkGmcpCoreSupportsSet new
		packages: gmcpSettings enabledPackages;
		sendTo: server
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> subnego: anOption data: gmcpData from: server [
	| parsedGmcp gmcpMessage |
	gmcpData ifEmpty: [ ^self ].
	parsedGmcp := self gmcpDataParser parse: gmcpData.
	gmcpMessage := gmcpSettings messageFromData: parsedGmcp.
	self trace: 'received GMCP: ';
		traceCr: gmcpData
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> will: anOption from: server [
	super will: anOption from: server.
	self sendCoreHelloTo: server.
	self sendCoreSupportsSetTo: server
]
