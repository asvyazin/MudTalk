Class {
	#name : #MudTalkAlias,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'MudTalk-Client'
}

{ #category : #running }
MudTalkAlias >> run: aText [
	self subclassResponsibility
]
