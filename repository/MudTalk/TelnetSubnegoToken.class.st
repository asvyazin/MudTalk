Class {
	#name : #TelnetSubnegoToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetSubnegoToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #subnego: with: self value.
]
