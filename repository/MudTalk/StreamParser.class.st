Class {
	#name : #StreamParser,
	#superclass : #PPDelegateParser,
	#instVars : [
		'stream'
	],
	#category : #MudTalk
}

{ #category : #accessing }
StreamParser >> appendToUnparsed: aCollection [
	stream nextPutAll: aCollection.
	stream reset
]

{ #category : #initialization }
StreamParser >> initialize [
	super initialize.
	stream := ReadWriteStream on: #()
]

{ #category : #parsing }
StreamParser >> parseOn: aStream [
	| result |
	self appendToUnparsed: aStream.
	result := parser parseOn: self unparsed.
	self unparsed: aStream upToEnd.
	^ result
]

{ #category : #accessing }
StreamParser >> unparsed [
	^ stream readStream asPetitStream
]

{ #category : #accessing }
StreamParser >> unparsed: aCollection [
	stream := ReadWriteStream on: aCollection
]
