Class {
	#name : #MudTalkGmcpCharVitals,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'hp',
		'mana'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpCharVitals class >> messageName [
	^ 'char.vitals'
]

{ #category : #json }
MudTalkGmcpCharVitals class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(hp mana)]
]
