Class {
	#name : #TelnetDont,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetDont class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #accessing }
TelnetDont >> option [
	^ option
]

{ #category : #accessing }
TelnetDont >> option: anOption [
	option := anOption
]

{ #category : #events }
TelnetDont >> triggerOn: aEventSource [
	aEventSource triggerEvent: #dont: with: self option
]
