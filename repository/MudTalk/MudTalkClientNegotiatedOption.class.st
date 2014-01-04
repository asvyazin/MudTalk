Class {
	#name : #MudTalkClientNegotiatedOption,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'serverSide'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientNegotiatedOption >> enabled [
	^ enabled
]

{ #category : #accessing }
MudTalkClientNegotiatedOption >> enabled: anObject [
	enabled := anObject
]

{ #category : #accessing }
MudTalkClientNegotiatedOption >> serverSide [
	^ serverSide
]

{ #category : #accessing }
MudTalkClientNegotiatedOption >> serverSide: anObject [
	serverSide := anObject
]
