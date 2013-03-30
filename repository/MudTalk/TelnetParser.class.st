Class {
	#name : #TelnetParser,
	#superclass : #Object,
	#instVars : [
		'baseParser',
		'parser'
	],
	#category : #MudTalk
}

{ #category : #constants }
TelnetParser class >> do [
	^ Character value: 253
]

{ #category : #parsers }
TelnetParser class >> doPrefix [
	^ self iac asParser, self do asParser
]

{ #category : #constants }
TelnetParser class >> dont [
	^ Character value: 254
]

{ #category : #parsers }
TelnetParser class >> dontPrefix [
	^ self iac asParser, self dont asParser
]

{ #category : #constants }
TelnetParser class >> iac [
	^ Character value: 255
]

{ #category : #constants }
TelnetParser class >> sb [
	^ Character value: 250
]

{ #category : #constants }
TelnetParser class >> se [
	^ Character value: 240
]

{ #category : #parsers }
TelnetParser class >> subnegoPostfix [
	^ self iac asParser, self se asParser
]

{ #category : #parsers }
TelnetParser class >> subnegoPrefix [
	^ self iac asParser, self sb asParser
]

{ #category : #constants }
TelnetParser class >> will [
	^ Character value: 251
]

{ #category : #parsers }
TelnetParser class >> willPrefix [
	^ self iac asParser, self will asParser
]

{ #category : #constants }
TelnetParser class >> wont [
	^ Character value: 252
]

{ #category : #parsers }
TelnetParser class >> wontPrefix [
	^ self iac asParser, self wont asParser
]

{ #category : #parsing }
TelnetParser >> baseParse: aStream [
	^ baseParser parse: aStream
]

{ #category : #initialization }
TelnetParser >> commandParser [
	^ (self class iac asParser, self commandToken) ==> #second
]

{ #category : #initialization }
TelnetParser >> commandToken [
	^ #any asParser ==> [ :option | TelnetCommandToken option: option ]
]

{ #category : #initialization }
TelnetParser >> doParser [
	^ (self class doPrefix, self doToken) ==> #third
]

{ #category : #initialization }
TelnetParser >> doToken [
	^ #any asParser ==> [ :option | TelnetDoToken option: option ]
]

{ #category : #initialization }
TelnetParser >> dontParser [
	^ (self class dontPrefix, self dontToken) ==> #third
]

{ #category : #initialization }
TelnetParser >> dontToken [
	^ #any asParser ==> [ :option | TelnetDontToken option: option ]
]

{ #category : #initialization }
TelnetParser >> doubleIacParser [
	^ (self class iac asParser, self class iac asParser) ==> [:tokens | self class iac]
]

{ #category : #initialization }
TelnetParser >> initialize [
	super initialize.
	baseParser := StreamParser on: (self newBaseParser).
	parser := StreamParser on: (self newParser)
]

{ #category : #initialization }
TelnetParser >> newBaseParser [
	^ (self doParser /
		self dontParser /
		self willParser /
		self wontParser /
		self subnegoParser /
		self doubleIacParser /
		self commandParser /
		self class iac asParser negate) star
]

{ #category : #initialization }
TelnetParser >> newParser [
	^ (#telnetSubnego asParser /
		#telnetDo asParser /
		#telnetDont asParser /
		#telnetWill asParser /
		#telnetWont asParser /
		#telnetCommand asParser /
		self textParser) star
]

{ #category : #parsing }
TelnetParser >> parse: aStream [
	| telnetTokens |
	telnetTokens := baseParser parse: aStream.
	^ parser parse: telnetTokens
]

{ #category : #initialization }
TelnetParser >> subnegoParser [
	| postfix |
	postfix := self class subnegoPostfix.
	^ (self class subnegoPrefix, #any asParser, (#any asParser starLazy: postfix), postfix) ==> [:tokens |
		TelnetSubnegoToken option: tokens third data: tokens fourth]
]

{ #category : #initialization }
TelnetParser >> textParser [
	^ #anyCharacter asParser plus ==> [ :chars | String withAll: chars ]
]

{ #category : #initialization }
TelnetParser >> willParser [
	^ (self class willPrefix, self willToken) ==> #third
]

{ #category : #initialization }
TelnetParser >> willToken [
	^ #any asParser ==> [ :option | TelnetWillToken option: option ]
]

{ #category : #initialization }
TelnetParser >> wontParser [
	^ (self class wontPrefix, self wontToken) ==> #third
]

{ #category : #initialization }
TelnetParser >> wontToken [
	^ #any asParser ==> [ :option | TelnetWontToken option: option ]
]
