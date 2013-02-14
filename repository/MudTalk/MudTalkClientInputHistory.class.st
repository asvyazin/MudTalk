Class {
	#name : #MudTalkClientInputHistory,
	#superclass : #Object,
	#instVars : [
		'position',
		'history'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientInputHistory >> appendCommand: aCommand [
	history add: aCommand.
	position := history size
]

{ #category : #initialization }
MudTalkClientInputHistory >> initialize [
	super initialize.
	position := 0.
	history := OrderedCollection new
]

{ #category : #accessing }
MudTalkClientInputHistory >> nextCommand [
	position < history size ifTrue: [position := position + 1].
	^ history at: position
]

{ #category : #accessing }
MudTalkClientInputHistory >> previousCommand [
	| result |
	position == 0 ifTrue: [^nil].
	result := history at: position.
	position := position - 1.
	^ result
]
