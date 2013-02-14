Class {
	#name : #MudTalkClientTelnetCommandSetting,
	#superclass : #Object,
	#category : #'MudTalk-Client'
}

{ #category : #'telnet options' }
MudTalkClientTelnetCommandSetting >> ifEnabled: enabledAction [
	self isEnabled ifTrue: [enabledAction value: self]
]

{ #category : #accessing }
MudTalkClientTelnetCommandSetting >> isEnabled [
	^ false
]
