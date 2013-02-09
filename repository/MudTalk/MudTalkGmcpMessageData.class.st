Class {
	#name : #MudTalkGmcpMessageData,
	#superclass : #Object,
	#instVars : [
		'messageName',
		'messageData'
	],
	#classInstVars : [
		'messageClasses'
	],
	#category : #'MudTalk-Client'
}

{ #category : #messages }
MudTalkGmcpMessageData class >> messageClasses [
	^ messageClasses ifNil: [ messageClasses := Dictionary new ]
]

{ #category : #initialization }
MudTalkGmcpMessageData class >> name: messageName data: messageData [ 
	^ self new name: messageName data: messageData
]

{ #category : #accessing }
MudTalkGmcpMessageData class >> registerMessage: messageName class: messageClass [ 
	self messageClasses at: messageName put: messageClass
]

{ #category : #accessing }
MudTalkGmcpMessageData >> asMessage [
	^ (self class messageClasses at: self messageName) data: self
]

{ #category : #accessing }
MudTalkGmcpMessageData >> messageData [
	^ messageData
]

{ #category : #accessing }
MudTalkGmcpMessageData >> messageName [
	^ messageName
]

{ #category : #gmcp }
MudTalkGmcpMessageData >> name: aMessageName data: aMessageData [ 
	messageName := aMessageName.
	messageData := aMessageData
]
