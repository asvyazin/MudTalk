Class {
	#name : #MudTalkGmcpCoreHello,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'client',
		'version'
	],
	#category : #'MudTalk-Client'
}

{ #category : #json }
MudTalkGmcpCoreHello class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(client version) ]
]

{ #category : #accessing }
MudTalkGmcpCoreHello >> client: clientName version: clientVersion [
	client := clientName.
	version := clientVersion
]

{ #category : #accessing }
MudTalkGmcpCoreHello >> name [
	^ 'Core.Hello'
]
