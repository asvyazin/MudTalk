Class {
	#name : #TelnetEcToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetEcToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #ec
]
