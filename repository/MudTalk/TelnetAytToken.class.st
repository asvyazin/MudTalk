Class {
	#name : #TelnetAytToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetAytToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #ayt
]
