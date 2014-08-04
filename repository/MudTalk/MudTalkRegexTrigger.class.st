Class {
	#name : #MudTalkRegexTrigger,
	#superclass : #MudTalkTrigger,
	#instVars : [
		'regex'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkRegexTrigger >> regex: rxString do: aBlock [
	regex := rxString asRegex.
	block := aBlock
]

{ #category : #running }
MudTalkRegexTrigger >> run: aText [
	(regex search: aText)
		ifTrue: [ block cull: regex. ^ true ]
		ifFalse: [ ^ false ]
]
