Class {
	#name : #MudTalkGmcpRoomWrongdir,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'wrongdir'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpRoomWrongdir class >> messageName [
	^ 'room.wrongdir'
]

{ #category : #json }
MudTalkGmcpRoomWrongdir class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVar: #wrongdir ]
]
