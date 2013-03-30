Class {
	#name : #StreamParser,
	#superclass : #PPDelegateParser,
	#instVars : [
		'unparsed'
	],
	#category : #MudTalk
}

{ #category : #initialization }
StreamParser >> initialize [
	super initialize.
	unparsed := OrderedCollection new.

]

{ #category : #parsing }
StreamParser >> parseOn: aStream [
	| result unparsedStream |
	unparsedStream := (self unparsed, aStream collection) asPetitStream.
	result := parser parseOn: unparsedStream.
	self unparsed: unparsedStream upToEnd.
	^ result
]

{ #category : #accessing }
StreamParser >> unparsed [
	^ unparsed
]

{ #category : #accessing }
StreamParser >> unparsed: aCollection [
	unparsed := aCollection
]
