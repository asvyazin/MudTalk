Class {
	#name : #TelnetWontToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetWontToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #wont: with: (self value first) asInteger.
]
