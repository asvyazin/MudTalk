Class {
	#name : #MudTalkClientEscapeParser,
	#superclass : #Object,
	#instVars : [
		'parser',
		'textAttributeParser',
		'textBuffer'
	],
	#category : #'MudTalk-Client'
}

{ #category : #common }
MudTalkClientEscapeParser >> CSI [
	^ (Character value: 16r1B) asParser, (Character value: 16r5B) asParser
]

{ #category : #base }
MudTalkClientEscapeParser >> F [
	^ PPPredicateObjectParser between: (Character value: 16r40) and: (Character value: 16r7E)
]

{ #category : #base }
MudTalkClientEscapeParser >> I [
	^ PPPredicateObjectParser between: (Character value: 16r20) and: (Character value: 16r2F)
]

{ #category : #base }
MudTalkClientEscapeParser >> P [
	^ PPPredicateObjectParser between: (Character value: 16r30) and: (Character value: 16r3F)
]

{ #category : #base }
MudTalkClientEscapeParser >> escapeParser [
	^ (self CSI, self P star, self I star, self F) token: MudTalkEscapeToken
]

{ #category : #initialization }
MudTalkClientEscapeParser >> initialize [
	textBuffer := ''
]

{ #category : #base }
MudTalkClientEscapeParser >> newParser [
	^ (self escapeParser / #any asParser) plus
]

{ #category : #base }
MudTalkClientEscapeParser >> parse: aText [
	| petitStream tokens processor |
	petitStream := (textBuffer, aText) asPetitStream.
	tokens := self parser parse: petitStream.
	textBuffer := String withAll: petitStream upToEnd.
	processor := MudTalkClientEscapeProcessor new.
	tokens do: [ :token | token processEscapeTokenWith: processor ].
	^ processor currentText
]

{ #category : #base }
MudTalkClientEscapeParser >> parser [
	^ parser ifNil: [ parser := self newParser ]
]
