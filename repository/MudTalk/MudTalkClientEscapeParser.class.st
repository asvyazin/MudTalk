Class {
	#name : #MudTalkClientEscapeParser,
	#superclass : #Object,
	#instVars : [
		'parser',
		'textAttributeParser'
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
	^ (self CSI, self P star, self I star, self F) ==> [:tokens |
		MudTalkEscapeToken new
			parameter: tokens third;
			intermediate: tokens fourth;
			final: tokens fifth;
			yourself]
]

{ #category : #initialization }
MudTalkClientEscapeParser >> initialize [
	super initialize.
	parser := self newParser
]

{ #category : #base }
MudTalkClientEscapeParser >> newParser [
	^ StreamParser on: ((self escapeParser / #any asParser) plus)
]

{ #category : #base }
MudTalkClientEscapeParser >> parse: aText [
	| tokens processor |
	tokens := parser parse: aText.
	processor := MudTalkClientEscapeProcessor new.
	tokens do: [ :token | token processEscapeTokenWith: processor ].
	^ processor currentText
]
