Class {
	#name : #MudTalkClientTelnetOptionHandler,
	#superclass : #Object,
	#category : #'MudTalk-Client'
}

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> ifDisabled: aBlock [
	self isDisabled ifTrue: aBlock
]

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> ifEnabled: aBlock [
	self isEnabled ifTrue: [aBlock value: self]
]

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> ifIgnored: aBlock [
	self isIgnored ifTrue: aBlock
]

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> isDisabled [
	^ false
]

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> isEnabled [
	^ false
]

{ #category : #'telnet options' }
MudTalkClientTelnetOptionHandler >> isIgnored [
	^ false
]
