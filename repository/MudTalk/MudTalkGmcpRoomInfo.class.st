Class {
	#name : #MudTalkGmcpRoomInfo,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'num',
		'name',
		'zone',
		'terrain',
		'terraininfo',
		'size',
		'shape',
		'plane',
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
			mapInstVar: #terrain;
			mapInstVar: #terraininfo;
			mapInstVar: #size;
			mapInstVar: #shape;
			mapInstVar: #plane;
			mapInstVar: #flags.
		(mapping mapInstVar: #coord) valueSchema: MudTalkGmcpCoord.
		(mapping mapInstVar: #exits) valueSchema: MudTalkGmcpExits ]
]
