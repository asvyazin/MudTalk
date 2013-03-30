Class {
	#name : #TelnetSubnegoEvent,
	#superclass : #TelnetOptionEvent,
	#instVars : [
		'data'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetSubnegoEvent class >> option: anOption data: aData [
	^ self new option: anOption; data: aData; yourself
]

{ #category : #comparing }
TelnetSubnegoEvent >> = anObject [
	^ (anObject option = option) and: [anObject data = data]
]

{ #category : #accessing }
TelnetSubnegoEvent >> data [
	^ data
]

{ #category : #accessing }
TelnetSubnegoEvent >> data: aData [
	data := aData
]

{ #category : #comparing }
TelnetSubnegoEvent >> hash [
	^ option hash bitXor: data hash
]

{ #category : #testing }
TelnetSubnegoEvent >> isTelnetSubnego [
	^ true
]
