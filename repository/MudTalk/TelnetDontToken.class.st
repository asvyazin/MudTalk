Class {
	#name : #TelnetDontToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetDontToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #dont: with: (self value first) asInteger.
]
