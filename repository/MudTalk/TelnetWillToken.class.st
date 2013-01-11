Class {
	#name : #TelnetWillToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetWillToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #will: with: (self value at: 1) asInteger.
]
