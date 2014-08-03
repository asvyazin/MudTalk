Class {
	#name : #MudTalkGmcpMessage,
	#superclass : #Announcement,
	#instVars : [
		'jsonMap'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'as yet unclassified' }
MudTalkGmcpMessage >> at: aSymbol [
	^ self jsonMap at: aSymbol
]

{ #category : #accessing }
MudTalkGmcpMessage >> bodyOn: jsonWriter [
	jsonWriter nextPut: self jsonMap
]

{ #category : #accessing }
MudTalkGmcpMessage >> data: aMessageData [
	| reader data |
	data := aMessageData messageData.
	data ifNotEmpty: [
		reader := NeoJSONReader on: data readStream.
		reader propertyNamesAsSymbols: true.
		self jsonMap: reader next ]
]

{ #category : #initialization }
MudTalkGmcpMessage >> initialize [
	jsonMap := Dictionary new
]

{ #category : #accessing }
MudTalkGmcpMessage >> jsonMap [
	^ jsonMap
]

{ #category : #accessing }
MudTalkGmcpMessage >> jsonMap: aMap [
	jsonMap := aMap
]

{ #category : #printing }
MudTalkGmcpMessage >> printString [
	| stream |
	stream := WriteStream with: ''.
	self writeTo: stream.
	^ stream contents asString
]

{ #category : #gmcp }
MudTalkGmcpMessage >> sendTo: server [
	server gmcp: self
]

{ #category : #gmcp }
MudTalkGmcpMessage >> writeTo: stream [
	stream nextPutAll: self class messageName, ' '.
	self bodyOn: (NeoJSONWriter on: stream)
]
