Class {
	#name : #TelnetDoToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetDoToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #do: with: (self value at: 1) asInteger.
]
