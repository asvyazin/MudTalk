Class {
	#name : #MudTalkGmcpExits,
	#superclass : #Object,
	#instVars : [
		'door',
		'e',
		'w',
		's',
		'n'
	],
	#category : #'MudTalk-Client'
}

{ #category : #json }
MudTalkGmcpExits class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVar: #e;
			mapInstVar: #s;
			mapInstVar: #n;
			mapInstVar: #w;
			mapInstVar: #door ]
]
