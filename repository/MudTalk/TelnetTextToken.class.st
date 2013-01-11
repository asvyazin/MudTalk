Class {
	#name : #TelnetTextToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetTextToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #text: with: self value.
]
