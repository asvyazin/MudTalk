Class {
	#name : #MudTalkGmcpRoomInfo,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'num',
		'name',
		'zone',
		'flags',
		'coord',
		'exits'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpRoomInfo class >> messageName [
	^ 'room.info'
]

{ #category : #json }
MudTalkGmcpRoomInfo class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVar: #num;
			mapInstVar: #name;
			mapInstVar: #zone;
			mapInstVar: #exits;
			mapInstVar: #flags.
		(mapping mapInstVar: #coord) valueSchema: MudTalkGmcpCoord ]
]
