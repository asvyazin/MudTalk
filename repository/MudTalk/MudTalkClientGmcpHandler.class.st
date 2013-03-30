Class {
	#name : #MudTalkClientGmcpHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#instVars : [
		'gmcpDataParser',
		'gmcpSettings',
		'announcer'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientGmcpHandler >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

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

{ #category : #accessing }
MudTalkClientGmcpHandler >> gmcpSettings: settings [
	gmcpSettings := settings
]

{ #category : #initialization }
MudTalkClientGmcpHandler >> initialize [
	super initialize.
	gmcpDataParser := self newGmcpDataParser
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> messageBody [
	^ #any asParser star ==> [:chars | String withAll: chars]
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> messageName [
	^ #space asParser negate star ==> [:chars | String withAll: chars]
]

{ #category : #parsing }
MudTalkClientGmcpHandler >> newGmcpDataParser [
	^ (self messageName, #space asParser plus, self messageBody)
		==> [:tokens | MudTalkGmcpMessageData name: tokens first data: tokens third]
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> sendCoreHelloTo: server [
	MudTalkGmcpCoreHello new
		client: self clientName
		version: self clientVersion;
		sendTo: server
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
	parsedGmcp := gmcpDataParser parse: gmcpData.
	gmcpMessage := gmcpSettings messageFromData: parsedGmcp.
	announcer announce: gmcpMessage
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> will: anOption from: server [
	super will: anOption from: server.
	self sendCoreHelloTo: server.
	self sendCoreSupportsSetTo: server
]
