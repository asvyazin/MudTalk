Class {
	#name : #MudTalkClientEnabledOptionHandler,
	#superclass : #MudTalkClientTelnetOptionHandler,
	#category : #'MudTalk-Client'
}

{ #category : #telnet }
MudTalkClientEnabledOptionHandler >> do: anOption from: server [
	server will: anOption
]

{ #category : #'telnet options' }
MudTalkClientEnabledOptionHandler >> isEnabled [
	^ true
]

{ #category : #telnet }
MudTalkClientEnabledOptionHandler >> subnego: anOption data: aByteString from: server [
	self subclassResponsibility
]

{ #category : #telnet }
MudTalkClientEnabledOptionHandler >> will: anOption from: server [
	server do: anOption
]
