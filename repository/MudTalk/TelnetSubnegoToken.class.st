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

{ #category : #accessing }
TelnetSubnegoToken >> data [
	^ data
]

{ #category : #accessing }
TelnetSubnegoToken >> data: aData [
	data := aData
]

{ #category : #testing }
TelnetSubnegoToken >> isTelnetSubnego [
	^ true
]
