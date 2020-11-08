Class {
	#name : #MudTalkParserTrigger,
	#superclass : #MudTalkTrigger,
	#instVars : [
		'parser'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkParserTrigger >> parser: aParser do: aBlock [
	block := aBlock.
	parser := aParser
]

{ #category : #running }
MudTalkParserTrigger >> run: aText [
	parser matchesIn: aText do: [ :result | block cull: result. ^ true ].
	^ false

]
