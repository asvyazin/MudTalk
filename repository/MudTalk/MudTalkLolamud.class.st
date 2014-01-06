Class {
	#name : #MudTalkLolamud,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #'as yet unclassified' }
MudTalkLolamud >> initialize [
	super initialize.
	self openWindowOnHost: 'lolamud.net' port: 6969
]
