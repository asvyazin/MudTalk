Class {
	#name : #TelnetEorToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetEorToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #eor
]
