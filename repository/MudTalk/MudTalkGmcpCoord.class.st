Class {
	#name : #MudTalkGmcpCoord,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'x',
		'y'
	],
	#category : #'MudTalk-Client'
}

{ #category : #json }
MudTalkGmcpCoord class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVar: #id;
			mapInstVar: #name;
			mapInstVar: #x;
			mapInstVar: #y ]
]
