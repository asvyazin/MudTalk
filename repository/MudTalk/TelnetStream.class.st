Class {
	#name : #TelnetStream,
	#superclass : #Object,
	#instVars : [
		'baseStream',
		'putBackTokens',
		'lineBuffer'
	],
	#category : #MudTalk
}

{ #category : #'private-constants' }
TelnetStream class >> do [
	^ Character value: 253
]

{ #category : #constants }
TelnetStream class >> dont [
	^ Character value: 254
]

{ #category : #constants }
TelnetStream class >> iac [
	^ Character value: 255
]

{ #category : #initialization }
TelnetStream class >> on: aStream [
	^ self new on: aStream
]

{ #category : #constants }
TelnetStream class >> sb [
	^ Character value: 250
]

{ #category : #constants }
TelnetStream class >> se [
	^ Character value: 240
]

{ #category : #constants }
TelnetStream class >> will [
	^ Character value: 251
]

{ #category : #constants }
TelnetStream class >> wont [
	^ Character value: 252
]

{ #category : #accessing }
TelnetStream >> flushLineBuffer [
	| nextLine |
	nextLine := String withAll: lineBuffer.
	lineBuffer removeAll.
	^ TTText text: nextLine
]

{ #category : #accessing }
TelnetStream >> flushLineBufferAndPutToken: token [
	lineBuffer
		ifEmpty: [^ token]
		ifNotEmpty: [
			putBackTokens add: token.
			^ self flushLineBuffer]
]

{ #category : #initialization }
TelnetStream >> initialize [
	putBackTokens := OrderedCollection new.
	lineBuffer := OrderedCollection new
]

{ #category : #testing }
TelnetStream >> isDataAvailable [
	^ putBackTokens isNotEmpty or: [baseStream isDataAvailable]
]

{ #category : #accessing }
TelnetStream >> next [
	putBackTokens ifNotEmpty: [:c | ^ c removeFirst].
	^ self readNext
]

{ #category : #private }
TelnetStream >> nextCharacter: c [
	lineBuffer add: c.
	(c = Character cr)
		ifTrue: [ ^ self nextCharacterCr ]
		ifFalse: [ 
			(c = Character lf)
				ifTrue: [ ^ self nextCharacterLf ]
				ifFalse: [ ^ self readNext ] ]
]

{ #category : #private }
TelnetStream >> nextCharacterCr [
	| c token |
	c := baseStream next.
	(c = Character lf)
		ifTrue: [ 
			lineBuffer add: c.
			^ self flushLineBuffer ]
		ifFalse: [ 
			token := self flushLineBuffer.
			lineBuffer add: c.
			^ token ]
]

{ #category : #private }
TelnetStream >> nextCharacterLf [
	| c token |
	c := baseStream next.
	(c = Character cr)
		ifTrue: [ 
			lineBuffer add: c.
			^ self flushLineBuffer ]
		ifFalse: [ 
			token := self flushLineBuffer.
			lineBuffer add: c.
			^ token ]
]

{ #category : #accessing }
TelnetStream >> nextIac [
	| c |
	c := baseStream next.
	(c = self class iac) ifTrue: [^ self nextCharacter: (self class iac)].
	(c = self class do) ifTrue: [^ self flushLineBufferAndPutToken: (TTDo option: (baseStream  next) asInteger)].
	(c = self class dont) ifTrue: [^ self flushLineBufferAndPutToken: (TTDont option: (baseStream next) asInteger)].
	(c = self class will) ifTrue: [^ self flushLineBufferAndPutToken: (TTWill option: (baseStream next) asInteger)].
	(c = self class wont) ifTrue: [^ self flushLineBufferAndPutToken: (TTWont option: (baseStream next) asInteger)].
	(c = self class sb) ifTrue: [^ self nextIacSb].
	^ self flushLineBufferAndPutToken: (TTCommand code: c asInteger)
]

{ #category : #accessing }
TelnetStream >> nextIacSb [
	| option body |
	option := baseStream next asInteger.
	body := OrderedCollection new.
	^ self nextIacSbReadBody: body option: option
]

{ #category : #accessing }
TelnetStream >> nextIacSbIacOption: anOption body: body [
	| c |
	c := baseStream next.
	(c = self class se) ifFalse: [
		body add: self class iac; add: c.
		^ self nextIacSbReadBody: body option: anOption
	] ifTrue: [^ self flushLineBufferAndPutToken: (TTSubnego option: anOption data: body)]
]

{ #category : #accessing }
TelnetStream >> nextIacSbReadBody: body option: option [
	| c |
	[c := baseStream next.
	 c = self class iac
		 ifTrue: [ ^ self nextIacSbIacOption: option body: body ]
		 ifFalse: [ body add: c ]] repeat
]

{ #category : #initialization }
TelnetStream >> on: aStream [
	baseStream := aStream
]

{ #category : #private }
TelnetStream >> readNext [
	| c |
	c := baseStream next.
	(c = self class iac)
		ifTrue: [^ self nextIac]
		ifFalse: [^ self nextCharacter: c]
]
