Class {
	#name : #MudTalkClientEscapeProcessor,
	#superclass : #Object,
	#instVars : [
		'currentAttributes',
		'currentText',
		'textAttributeParser',
		'escapeTextAttributes'
	],
	#category : #'MudTalk-Client'
}

{ #category : #private }
MudTalkClientEscapeProcessor >> appendCharacter: aCharacter withAttributes: attributes [
	self appendText:
		(aCharacter asText copy addAttributes: attributes; yourself)
]

{ #category : #private }
MudTalkClientEscapeProcessor >> appendText: aText [
	currentText append: aText
]

{ #category : #protocol }
MudTalkClientEscapeProcessor >> character: aCharacter [
	self appendCharacter: aCharacter withAttributes: self currentAttributes
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> csi [
	^ (Character value: 16r1B) asParser, (Character value: 16r5B) asParser
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentAttributes [
	^ currentAttributes ifNil: [ ^ self defaultAttributes ]
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentAttributes: attributes [
	currentAttributes := attributes collect: [ :attribute | self textAttributeFromCode: attribute ]
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentText [
	^ currentText
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> defaultAttributes [
	^ {self defaultTextAttribute}
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> defaultTextAttribute [
	^ TextColor color: Color white
]

{ #category : #protocol }
MudTalkClientEscapeProcessor >> escape: anEscape [
	| attributes |
	attributes := self textAttributeParser parse: anEscape value.
	attributes isPetitFailure
		ifTrue: [ self unknownEscape: anEscape ]
		ifFalse: [ self currentAttributes: attributes ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> escapeTextAttributes [
	^ escapeTextAttributes ifNil: [ escapeTextAttributes := self newEscapeTextAttributes ]
]

{ #category : #initialization }
MudTalkClientEscapeProcessor >> initialize [
	currentText := '' asText
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> newEscapeTextAttributes [
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

{ #category : #parsing }
MudTalkClientEscapeProcessor >> newTextAttributeParser [
	^ self csi, self textAttributes, self textAttributeFinisher end ==> #third
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttribute [
	^ #digit asParser plus flatten ==> [ :str | str asInteger ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttributeDelimiter [
	^ $; asParser
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttributeFinisher [
	^ $m asParser
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttributeFromCode: code [
	^ self escapeTextAttributes at: code
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttributeParser [
	^ textAttributeParser ifNil: [ textAttributeParser := self newTextAttributeParser ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor >> textAttributes [
	^ (self textAttribute separatedBy: self textAttributeDelimiter) withoutSeparators
]

{ #category : #private }
MudTalkClientEscapeProcessor >> unknownEscape: anEscape [
	self trace: 'unknown escape: ';
		traceCr: anEscape
]
