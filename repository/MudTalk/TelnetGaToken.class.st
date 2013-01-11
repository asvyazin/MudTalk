Class {
	#name : #TelnetGaToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetGaToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #ga
]
