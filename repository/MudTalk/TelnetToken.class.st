Class {
	#name : #TelnetToken,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetToken class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #accessing }
TelnetToken >> option [
	^ option
]

{ #category : #accessing }
TelnetToken >> option: anOption [
	option := anOption
]
