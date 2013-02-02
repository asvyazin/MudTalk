Class {
	#name : #TelnetDont,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

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
