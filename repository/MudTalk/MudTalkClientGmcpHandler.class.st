Class {
	#name : #MudTalkClientGmcpHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
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
	self trace: 'GMCP: ';
		traceCr: gmcpData
	
]

{ #category : #telnet }
MudTalkClientGmcpHandler >> will: anOption from: server [
	super will: anOption from: server.
	self sendCoreHelloTo: server.
	self sendCoreSupportsSetTo: server
]
