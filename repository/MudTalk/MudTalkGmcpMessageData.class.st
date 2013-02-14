Class {
	#name : #MudTalkGmcpMessageData,
	#superclass : #Object,
	#instVars : [
		'messageName',
		'messageData'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkGmcpMessageData class >> name: messageName data: messageData [ 
	^ self new name: messageName data: messageData
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
