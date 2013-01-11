Class {
	#name : #TelnetDo,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #'instance creation' }
TelnetDo class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #accessing }
TelnetDo >> option [
	^ option
]

{ #category : #initialization }
TelnetDo >> option: anOption [ 
	option := anOption
]

{ #category : #events }
TelnetDo >> triggerOn: aEventSource [
	aEventSource triggerEvent: #do: with: self option
]
