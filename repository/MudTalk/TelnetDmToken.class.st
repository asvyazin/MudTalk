Class {
	#name : #TelnetDmToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetDmToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #dm
]
