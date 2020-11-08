Class {
	#name : #MudTalkParserAlias,
	#superclass : #MudTalkAlias,
	#instVars : [
		'parser'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkParserAlias >> parser: aParser do: aBlock [
	block := aBlock.
	parser := aParser
]

{ #category : #running }
MudTalkParserAlias >> run: aText [
	parser matchesIn: aText do: [ :result | block cull: result. ^ true ].
	^ false

]
