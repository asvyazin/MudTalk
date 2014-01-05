Class {
	#name : #MudTalkClientEscapeParser,
	#superclass : #Object,
	#instVars : [
		'parser',
		'textAttributeParser',
		'currentTextAttributes',
		'escapeTextAttributes'
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

{ #category : #accessing }
MudTalkClientEscapeParser >> currentTextAttributes [
	^ currentTextAttributes
]

{ #category : #accessing }
MudTalkClientEscapeParser >> currentTextAttributes: attributes [
	currentTextAttributes := attributes collect: [ :attribute | self textAttributeFromCode: attribute ]
]

{ #category : #initialization }
MudTalkClientEscapeParser >> defaultTextAttribute [
	^ TextColor color: Color white
]

{ #category : #initialization }
MudTalkClientEscapeParser >> defaultTextAttributes [
	^ {self defaultTextAttribute}
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
	parser := self escapeParser.
	currentTextAttributes := self defaultTextAttributes.
	escapeTextAttributes := self newEscapeTextAttributes.
	textAttributeParser := self textAttributes end
]

{ #category : #initialization }
MudTalkClientEscapeParser >> newEscapeTextAttributes [
	^ Dictionary new
		at: 0 put: self defaultTextAttribute;
		at: 1 put: TextEmphasis bold;
		at: 30 put: (TextColor color: Color black);
		at: 31 put: (TextColor color: Color red);
		at: 32 put: (TextColor color: Color green);
		at: 33 put: (TextColor color: Color yellow);
		at: 34 put: (TextColor color: Color blue);
		at: 35 put: (TextColor color: Color magenta);
		at: 36 put: (TextColor color: Color cyan);
		at: 37 put: (TextColor color: Color white);
		yourself
]

{ #category : #base }
MudTalkClientEscapeParser >> parse: aText [
	| currentIndex currentText textChunk |
	currentIndex := 1.
	currentText := Text new.
	parser matchingRangesIn: aText do: [ :range | | match start stop token |
		start := range first.
		stop := range last.
		match := aText copyFrom: start to: stop.
		(start > currentIndex) ifTrue: [ 
			textChunk := (aText copyFrom: currentIndex to: (start - 1)) asText.
			textChunk addAttributes: self currentTextAttributes.
			currentText append: textChunk ].
		currentIndex := stop + 1.
		token := parser parse: match.
		(token isTextAttributesEscapeSequence)
			ifFalse: [ self unknownEscape: match ]
			ifTrue: [ self currentTextAttributes: (textAttributeParser parse: (token parameter)) ] ].
	(aText size > currentIndex) ifTrue: [
		textChunk := (aText allButFirst: (currentIndex - 1)) asText.
		textChunk addAttributes: self currentTextAttributes.
		currentText append: textChunk ].
	^ currentText
]

{ #category : #base }
MudTalkClientEscapeParser >> textAttribute [
	^ #digit asParser star flatten ==> [:str | self textAttributeFromString: (String withAll: str)]
]

{ #category : #base }
MudTalkClientEscapeParser >> textAttributeFromCode: code [
	^ escapeTextAttributes at: code
]

{ #category : #base }
MudTalkClientEscapeParser >> textAttributeFromString: str [
	str ifEmpty: [ ^ 0 ] ifNotEmpty: [ ^ str asInteger ]
]

{ #category : #base }
MudTalkClientEscapeParser >> textAttributes [
	^ (self textAttribute separatedBy: $; asParser) withoutSeparators
]

{ #category : #base }
MudTalkClientEscapeParser >> unknownEscape: escape [
	self trace: 'Unknown escape: '; traceCr: escape
]
