Class {
	#name : #MudTalkTwoTowers,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkTwoTowers >> initialize [
	super initialize.
	self openWindowOnHost: 't2tmud.org' port: 9999
]
