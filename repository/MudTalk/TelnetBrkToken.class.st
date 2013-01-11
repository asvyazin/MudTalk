Class {
	#name : #TelnetBrkToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetBrkToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #brk
]
