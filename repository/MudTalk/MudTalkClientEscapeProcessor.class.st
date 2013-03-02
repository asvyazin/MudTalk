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

{ #category : #'text attributes parsing' }
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

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> defaultTextAttribute [
	^ TextColor color: Color white
]

{ #category : #protocol }
MudTalkClientEscapeProcessor >> escape: anEscape [
	| attributes |
	attributes := textAttributeParser parse: anEscape inputValue.
	attributes isPetitFailure
		ifTrue: [ self unknownEscape: anEscape ]
		ifFalse: [ self currentAttributes: attributes ]
]

{ #category : #initialization }
MudTalkClientEscapeProcessor >> initialize [
	currentText := '' asText.
	escapeTextAttributes := self newEscapeTextAttributes.
	textAttributeParser := self newTextAttributeParser
]

{ #category : #'text attributes parsing' }
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

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> newTextAttributeParser [
	^ self csi, self textAttributes, self textAttributeFinisher end ==> #third
]

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> textAttribute [
	^ #digit asParser plus flatten ==> [:str | str asInteger]
]

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> textAttributeDelimiter [
	^ $; asParser
]

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> textAttributeFinisher [
	^ $m asParser
]

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> textAttributeFromCode: code [
	^ escapeTextAttributes at: code
]

{ #category : #'text attributes parsing' }
MudTalkClientEscapeProcessor >> textAttributes [
	^ (self textAttribute separatedBy: self textAttributeDelimiter) withoutSeparators
]

{ #category : #private }
MudTalkClientEscapeProcessor >> unknownEscape: anEscape [
	self trace: 'unknown escape: ';
		traceCr: anEscape
]
