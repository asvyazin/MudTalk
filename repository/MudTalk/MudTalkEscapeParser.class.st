Class {
	#name : #MudTalkEscapeParser,
	#superclass : #Object,
	#instVars : [
		'parser',
		'textAttributeParser',
		'textBuffer'
	],
	#category : #'MudTalk-Client'
}

{ #category : #common }
MudTalkEscapeParser >> CSI [
	^ (Character value: 16r1B) asParser, (Character value: 16r5B) asParser
]

{ #category : #base }
MudTalkEscapeParser >> F [
	^ PPPredicateObjectParser between: (Character value: 16r40) and: (Character value: 16r7E)
]

{ #category : #base }
MudTalkEscapeParser >> I [
	^ PPPredicateObjectParser between: (Character value: 16r20) and: (Character value: 16r2F)
]

{ #category : #base }
MudTalkEscapeParser >> P [
	^ PPPredicateObjectParser between: (Character value: 16r30) and: (Character value: 16r3F)
]

{ #category : #base }
MudTalkEscapeParser >> escapeParser [
	^ (self CSI, self P star, self I star, self F) token: MudTalkEscapeToken
]

{ #category : #initialization }
MudTalkEscapeParser >> initialize [
	textBuffer := ''
]

{ #category : #base }
MudTalkEscapeParser >> newParser [
	^ (self escapeParser / self text) plus
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> newTextAttributeParser [
	^ (self CSI , self numbers , self textAttributeFinisher) end ==> #third
]

{ #category : #base }
MudTalkEscapeParser >> normalChar [
	^ (Character value: 16r1B) asParser negate
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> number [
	^ #digit asParser plus flatten ==> [ :str | str asInteger ].
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> numbers [
	^ (self number separatedBy: self textAttributeDelimiter) ==>
		[ :node | node select: [ :each | each isInteger ] ]
]

{ #category : #base }
MudTalkEscapeParser >> parse: aText [
	| petitStream result |
	petitStream := (textBuffer, aText) asPetitStream.
	result := self parser parse: petitStream.
	textBuffer := String withAll: petitStream upToEnd.
	^ result
]

{ #category : #base }
MudTalkEscapeParser >> parser [
	^ parser ifNil: [ parser := self newParser ]
]

{ #category : #base }
MudTalkEscapeParser >> text [
	^ self normalChar plus ==> [ :chars | MudTalkTextToken on: (String withAll: chars)]
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> textAttributeDelimiter [
	^ $; asParser
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> textAttributeFinisher [
	^ $m asParser
]

{ #category : #'attribute parsing' }
MudTalkEscapeParser >> textAttributeParser [
	^ textAttributeParser ifNil: [ textAttributeParser := self newTextAttributeParser ]
]
