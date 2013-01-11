Class {
	#name : #TelnetIpToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Obsolete'
}

{ #category : #events }
TelnetIpToken >> triggerOn: aEventManager [
	aEventManager triggerEvent: #ip
]
