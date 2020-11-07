Class {
	#name : #MudTalkGmcpCoreHello,
	#superclass : #MudTalkGmcpMessage,
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpCoreHello class >> messageName [
	^ 'Core.Hello'
]

{ #category : #accessing }
MudTalkGmcpCoreHello >> client: clientName version: clientVersion [
	jsonMap
		at: 'client' put: clientName;
		at: 'version' put: clientVersion
]
