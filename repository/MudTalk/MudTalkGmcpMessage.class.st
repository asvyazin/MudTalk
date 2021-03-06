Class {
	#name : #MudTalkGmcpMessage,
	#superclass : #Announcement,
	#instVars : [
		'jsonMap',
		'messageName'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpMessage class >> messageName [
	^ 'unknown'
]

{ #category : #'as yet unclassified' }
MudTalkGmcpMessage >> at: aSymbol [
	^ self jsonMap at: aSymbol
]

{ #category : #'as yet unclassified' }
MudTalkGmcpMessage >> at: aKey ifPresent: aBlock [
	jsonMap at: aKey ifPresent: aBlock
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
	jsonMap := Dictionary new.
	messageName := self class messageName
]

{ #category : #accessing }
MudTalkGmcpMessage >> jsonMap [
	^ jsonMap
]

{ #category : #accessing }
MudTalkGmcpMessage >> jsonMap: aMap [
	jsonMap := aMap
]

{ #category : #accessing }
MudTalkGmcpMessage >> messageName [
	^ messageName
]

{ #category : #accessing }
MudTalkGmcpMessage >> messageName: aString [
	messageName := aString
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
	stream nextPutAll: self messageName, ' '.
	self bodyOn: (NeoJSONWriter on: stream)
]
