Class {
	#name : #TelnetWont,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #'instance creation' }
TelnetWont class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #accesing }
TelnetWont >> option [
	^ option
]

{ #category : #initialization }
TelnetWont >> option: anOption [ 
	option := anOption
]

{ #category : #events }
TelnetWont >> triggerOn: aEventSource [
	aEventSource triggerEvent: #wont: with: self option
]
