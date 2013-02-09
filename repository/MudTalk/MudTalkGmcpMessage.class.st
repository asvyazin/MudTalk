Class {
	#name : #MudTalkGmcpMessage,
	#superclass : #Object,
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpMessage >> bodyOn: jsonWriter [
	jsonWriter nextPut: self
]

{ #category : #accessing }
MudTalkGmcpMessage >> name [
	self subclassResponsibility
]

{ #category : #gmcp }
MudTalkGmcpMessage >> sendTo: server [
	server gmcp: self
]

{ #category : #gmcp }
MudTalkGmcpMessage >> writeTo: stream [
	stream nextPutAll: self name, ' '.
	self bodyOn: (NeoJSONWriter on: stream)
]
