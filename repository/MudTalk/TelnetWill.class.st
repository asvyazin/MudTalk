Class {
	#name : #TelnetWill,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetWill class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #accessing }
TelnetWill >> option [
	^ option
]

{ #category : #initialization }
TelnetWill >> option: anOption [ 
	option := anOption
]

{ #category : #events }
TelnetWill >> triggerOn: aEventSource [
	aEventSource triggerEvent: #will: with: self option
]
