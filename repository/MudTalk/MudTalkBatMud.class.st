Class {
	#name : #MudTalkBatMud,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #initialize }
MudTalkBatMud >> initialize [
	super initialize.
	self openWindowOnHost: 'bat.org' port: 23
]
