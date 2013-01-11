Class {
	#name : #TelnetAoToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetAoToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #ao
]
