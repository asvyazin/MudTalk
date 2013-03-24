Class {
	#name : #MudTalkAlterAeon,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkAlterAeon >> initialize [
	super initialize.
	self openWindowOnHost: 'alteraeon.com' port: 3000.
	self enableTelnetOptionsDebugging
]
