Class {
	#name : #MudTalkAlias,
	#superclass : #Object,
	#instVars : [
		'regex',
		'block'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'as yet unclassified' }
MudTalkAlias >> regex: rxString do: aBlock [
	regex := rxString asRegex.
	block := aBlock
]

{ #category : #'as yet unclassified' }
MudTalkAlias >> run: aText [
	(regex search: aText)
		ifTrue: [ block cull: regex. ^ true ]
		ifFalse: [ ^ false ]
]
