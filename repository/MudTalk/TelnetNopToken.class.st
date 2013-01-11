Class {
	#name : #TelnetNopToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetNopToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #nop
]
