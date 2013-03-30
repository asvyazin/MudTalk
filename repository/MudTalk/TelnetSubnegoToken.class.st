Class {
	#name : #TelnetSubnegoToken,
	#superclass : #TelnetToken,
	#instVars : [
		'data'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetSubnegoToken class >> option: anOption data: aData [
	^ self new option: anOption; data: aData; yourself
]

{ #category : #comparing }
TelnetSubnegoToken >> = anObject [
	^ (anObject option = option) and: [anObject data = data]
]

{ #category : #accessing }
TelnetSubnegoToken >> data [
	^ data
]

{ #category : #accessing }
TelnetSubnegoToken >> data: aData [
	data := aData
]

{ #category : #comparing }
TelnetSubnegoToken >> hash [
	^ option hash bitXor: data hash
]

{ #category : #testing }
TelnetSubnegoToken >> isTelnetSubnego [
	^ true
]
