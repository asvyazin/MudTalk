Class {
	#name : #TelnetElToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetElToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #el
]
