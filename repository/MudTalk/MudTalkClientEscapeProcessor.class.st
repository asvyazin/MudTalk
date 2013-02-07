Class {
	#name : #MudTalkClientEscapeProcessor,
	#superclass : #Object,
	#instVars : [
		'currentAttributes',
		'currentText'
	],
	#classInstVars : [
		'textAttributeParser',
		'escapeTextAttributes'
	],
	#category : #'MudTalk-Client'
}

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> csi [
	^ (Character value: 16r1B) asParser, (Character value: 16r5B) asParser
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> defaultTextAttribute [
	^ TextColor color: Color white
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> escapeTextAttributes [
	^ escapeTextAttributes ifNil: [ escapeTextAttributes := self newEscapeTextAttributes ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> newEscapeTextAttributes [
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
MudTalkClientEscapeProcessor class >> newTextAttributeParser [
	^ self csi, self textAttributes, self textAttributeFinisher end ==> #third
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttribute [
	^ #digit asParser plus flatten ==> [ :str | self textAttributeFromCode: str asInteger ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttributeDelimiter [
	^ $; asParser
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttributeFinisher [
	^ $m asParser
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttributeFromCode: code [
	^ self escapeTextAttributes at: code
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttributeParser [
	^ textAttributeParser ifNil: [ textAttributeParser := self newTextAttributeParser ]
]

{ #category : #parsing }
MudTalkClientEscapeProcessor class >> textAttributes [
	^ (self textAttribute separatedBy: self textAttributeDelimiter) withoutSeparators
]

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

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentAttributes [
	^ currentAttributes ifNil: [ ^ self defaultAttributes ]
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentAttributes: attributes [
	currentAttributes := attributes
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> currentText [
	^ currentText
]

{ #category : #accessing }
MudTalkClientEscapeProcessor >> defaultAttributes [
	^ {self class defaultTextAttribute}
]

{ #category : #protocol }
MudTalkClientEscapeProcessor >> escape: anEscape [
	| attributes |
	attributes := self class textAttributeParser parse: anEscape value.
	attributes isPetitFailure
		ifTrue: [ self unknownEscape: anEscape ]
		ifFalse: [ self currentAttributes: attributes ]
]

{ #category : #initialization }
MudTalkClientEscapeProcessor >> initialize [
	currentText := '' asText
]

{ #category : #private }
MudTalkClientEscapeProcessor >> unknownEscape: anEscape [
	self trace: 'unknown escape: ';
		traceCr: anEscape
]
