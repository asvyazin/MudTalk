Class {
	#name : #MudTalkTrigger,
	#superclass : #Object,
	#instVars : [
		'block',
		'oneTime'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkTrigger >> oneTime [
	^ oneTime
]

{ #category : #accessing }
MudTalkTrigger >> oneTime: aBoolean [ 
	oneTime := aBoolean
]

{ #category : #running }
MudTalkTrigger >> run: aText [
	self subclassResponsibility
]
