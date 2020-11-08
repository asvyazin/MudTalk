Class {
	#name : #MudTalkClientIgnoredOptionHandler,
	#superclass : #MudTalkClientTelnetOptionHandler,
	#category : #'MudTalk-Client'
}

{ #category : #'telnet options' }
MudTalkClientIgnoredOptionHandler >> isIgnored [
	^ true
]
