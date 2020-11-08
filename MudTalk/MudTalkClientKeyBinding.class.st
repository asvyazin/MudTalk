Class {
	#name : #MudTalkClientKeyBinding,
	#superclass : #Object,
	#instVars : [
		'key',
		'action'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientKeyBinding >> action [
	^ action
]

{ #category : #accessing }
MudTalkClientKeyBinding >> key [
	^ key
]

{ #category : #initialization }
MudTalkClientKeyBinding >> key: aKey action: anAction [
	key := aKey.
	action := anAction
]

{ #category : #matching }
MudTalkClientKeyBinding >> matchEvent: evt [ 
	^ self key matchEvent: evt
]
