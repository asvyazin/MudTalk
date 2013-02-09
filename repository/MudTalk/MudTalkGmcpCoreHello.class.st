Class {
	#name : #MudTalkGmcpCoreHello,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'client',
		'version'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpCoreHello class >> messageName [
	^ 'Core.Hello'
]

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
