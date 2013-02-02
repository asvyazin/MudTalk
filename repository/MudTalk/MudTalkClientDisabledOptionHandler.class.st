Class {
	#name : #MudTalkClientDisabledOptionHandler,
	#superclass : #MudTalkClientTelnetOptionHandler,
	#category : #'MudTalk-Client'
}

{ #category : #'telnet options' }
MudTalkClientDisabledOptionHandler >> isDisabled [
	^ true
]
