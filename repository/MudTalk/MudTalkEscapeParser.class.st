Class {
	#name : #MudTalkEscapeParser,
	#superclass : #Object,
	#instVars : [
		'parser',
		'textAttributeParser'
	],
	#category : #'MudTalk-Client'
}

{ #category : #parsing }
MudTalkEscapeParser >> CSI [
	^ (Character value: 16r1B) asParser, (Character value: 16r5B) asParser
]

{ #category : #parsing }
MudTalkEscapeParser >> F [
	^ PPPredicateObjectParser between: (Character value: 16r40) and: (Character value: 16r7E)
]

{ #category : #parsing }
MudTalkEscapeParser >> I [
	^ PPPredicateObjectParser between: (Character value: 16r20) and: (Character value: 16r2F)
]

{ #category : #parsing }
MudTalkEscapeParser >> P [
	^ PPPredicateObjectParser between: (Character value: 16r30) and: (Character value: 16r3F)
]

{ #category : #parsing }
MudTalkEscapeParser >> escapeParser [
	^ (self CSI, self P star, self I star, self F) token: MudTalkEscapeToken
]

{ #category : #private }
MudTalkEscapeParser >> newParser [
	^ (self escapeParser / self text) plus end
]

{ #category : #parsing }
MudTalkEscapeParser >> newTextAttributeParser [
	^ (self CSI , self numbers , self textAttributeFinisher) end ==> #third
]

{ #category : #private }
MudTalkEscapeParser >> normalChar [
	^ (Character value: 16r1B) asParser negate
]

{ #category : #parsing }
MudTalkEscapeParser >> number [
	^ #digit asParser plus flatten ==> [ :str | str asInteger ].
]

{ #category : #parsing }
MudTalkEscapeParser >> numbers [
	^ (self number separatedBy: self textAttributeDelimiter) ==>
		[ :node | node select: [ :each | each isInteger ] ]
]

{ #category : #parsing }
MudTalkEscapeParser >> parse: aSource [
	^ self parser parse: aSource
]

{ #category : #private }
MudTalkEscapeParser >> parser [
	^ parser ifNil: [ parser := self newParser ]
]

{ #category : #private }
MudTalkEscapeParser >> text [
	^ self normalChar plus ==> [ :chars | MudTalkTextToken on: (String withAll: chars)]
]

{ #category : #parsing }
MudTalkEscapeParser >> textAttributeDelimiter [
	^ $; asParser
]

{ #category : #parsing }
MudTalkEscapeParser >> textAttributeFinisher [
	^ $m asParser
]

{ #category : #parsing }
MudTalkEscapeParser >> textAttributeParser [
	^ textAttributeParser ifNil: [ textAttributeParser := self newTextAttributeParser ]
]
