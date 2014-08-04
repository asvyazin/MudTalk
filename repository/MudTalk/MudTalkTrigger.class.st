Class {
	#name : #MudTalkTrigger,
	#superclass : #Object,
	#instVars : [
		'block',
		'regex',
		'oneTime'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'as yet unclassified' }
MudTalkTrigger >> oneTime [
	^ oneTime
]

{ #category : #'as yet unclassified' }
MudTalkTrigger >> oneTime: aBoolean [ 
	oneTime := aBoolean
]

{ #category : #'as yet unclassified' }
MudTalkTrigger >> regex: rxString do: aBlock [
	regex := rxString asRegex.
	block := aBlock
]

{ #category : #'as yet unclassified' }
MudTalkTrigger >> run: aText [
	(regex search: aText)
		ifTrue: [ block cull: regex. ^ true ]
		ifFalse: [ ^ false ]
]
