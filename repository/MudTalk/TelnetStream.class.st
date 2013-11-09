Class {
	#name : #TelnetStream,
	#superclass : #Object,
	#instVars : [
		'baseStream',
		'putBackTokens'
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

{ #category : #initialization }
TelnetStream >> initialize [
	putBackTokens := OrderedCollection new
]

{ #category : #accessing }
TelnetStream >> next [
	putBackTokens ifNotEmpty: [:c | ^ c removeFirst].
	^ self readNext
]

{ #category : #accessing }
TelnetStream >> nextIac [
	| c |
	c := baseStream next.
	(c = self class iac) ifTrue: [^ TTCharacter character: (self class iac)].
	(c = self class do) ifTrue: [^ TTDo option: (baseStream  next)].
	(c = self class dont) ifTrue: [^ TTDont option: (baseStream next)].
	(c = self class will) ifTrue: [^ TTWill option: (baseStream next)].
	(c = self class wont) ifTrue: [^ TTWont option: (baseStream next)].
	(c = self class sb) ifTrue: [^ self nextIacSb].
	^ TTCommand code: (baseStream next)
]

{ #category : #accessing }
TelnetStream >> nextIacSb [
	| option body |
	option := baseStream next.
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
		] ifTrue: [
		^ TTSubnego option: anOption body: body ]
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

{ #category : #accessing }
TelnetStream >> putBack: token [
	putBackTokens addFirst: token
]

{ #category : #private }
TelnetStream >> readNext [
	| c |
	c := baseStream next.
	(c = self class iac)
		ifFalse: [^ TTCharacter character: c]
		ifTrue: [^ self nextIac]
]
