Class {
	#name : #MudTalkRegexAlias,
	#superclass : #MudTalkAlias,
	#instVars : [
		'regex'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkRegexAlias >> regex: rxString do: aBlock [
	regex := rxString asRegex.
	block := aBlock
]

{ #category : #running }
MudTalkRegexAlias >> run: aText [
	(regex search: aText)
		ifTrue: [ block cull: regex. ^ true ]
		ifFalse: [ ^ false ]
]
