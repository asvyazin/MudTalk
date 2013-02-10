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

{ #category : #debugging }
MudTalkGmcpMessage >> debugTrace [
	self trace: 'received GMCP message: ', self class messageName, ' '.
	(NeoJSONWriter on: Transcript) nextPut: self.
	Transcript cr.
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
