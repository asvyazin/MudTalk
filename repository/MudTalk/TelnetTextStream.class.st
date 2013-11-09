Class {
	#name : #TelnetTextStream,
	#superclass : #Object,
	#instVars : [
		'baseStream',
		'buffer'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetTextStream class >> on: aStream [
	^ self new on: aStream
]

{ #category : #private }
TelnetTextStream >> addToBuffer: aCharacter [ 
	buffer add: aCharacter
]

{ #category : #private }
TelnetTextStream >> flushBuffer [
	| text |
	text := String withAll: buffer.
	buffer removeAll.
	^ TTText text: text
]

{ #category : #initialization }
TelnetTextStream >> initialize [
	buffer := OrderedCollection new
]

{ #category : #accessing }
TelnetTextStream >> next [
	| token maybeLf maybeCr |
	[token := baseStream next.
	(token isTTCharacter) ifFalse: [
		buffer ifEmpty: [^ token] ifNotEmpty: [
			baseStream putBack: token.
			^ self flushBuffer
		]
	] ifTrue: [
		self addToBuffer: token character.
		(token character = (Character cr)) ifTrue: [
			maybeLf := baseStream next.
			(maybeLf isTTCharacter and: [maybeLf character = (Character lf)]) ifTrue: [
				self addToBuffer: maybeLf character.
			] ifFalse: [
				baseStream putBack: maybeLf
			].
			^ self flushBuffer
		] ifFalse: [
			(token character = (Character lf)) ifTrue: [
				maybeCr := baseStream next.
				(maybeCr isTTCharacter and: [maybeCr character = (Character cr)]) ifTrue: [
					self addToBuffer: maybeCr character.
				] ifFalse: [
					baseStream putBack: maybeCr
				].
				^ self flushBuffer
			]
		]
	]] repeat
]

{ #category : #initialization }
TelnetTextStream >> on: aStream [
	baseStream := aStream
]
