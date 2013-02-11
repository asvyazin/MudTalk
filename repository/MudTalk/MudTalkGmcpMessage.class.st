Class {
	#name : #MudTalkGmcpMessage,
	#superclass : #Announcement,
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkGmcpMessage class >> data: aMessageData [ 
	^ (NeoJSONReader on: aMessageData messageData readStream) nextAs: self
]

{ #category : #accessing }
MudTalkGmcpMessage class >> initialize [
	(self respondsTo: #messageName) ifTrue: [
		MudTalkGmcpMessageData registerMessage: self messageName class: self ]
]

{ #category : #accessing }
MudTalkGmcpMessage >> bodyOn: jsonWriter [
	jsonWriter nextPut: self
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
