Class {
	#name : #MudTalkLolamud,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkLolamud >> initialize [
	super initialize.
	self openWindowOnHost: 'lolamud.net' port: 6969
]
