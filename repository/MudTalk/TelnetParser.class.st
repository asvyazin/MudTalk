Class {
	#name : #TelnetParser,
	#superclass : #Object,
	#instVars : [
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

{ #category : #initialization }
TelnetParser >> commandParser [
	^ self class iac asParser, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> doParser [
	^ self class doPrefix, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> dontParser [
	^ self class dontPrefix, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> initialize [
	super initialize.
	parser := StreamParser on: (self newParser)
]

{ #category : #initialization }
TelnetParser >> newParser [
	^ (self doParser /
	 self dontParser /
	 self willParser /
	 self wontParser /
	 self subnegoParser /
	 self commandParser /
	 #any asParser) star
]

{ #category : #parsing }
TelnetParser >> parse: aStream [
	^ parser parse: aStream
]

{ #category : #initialization }
TelnetParser >> subnegoParser [
	^ self class subnegoPrefix, #any asParser star, self class subnegoPostfix ==> #second
]

{ #category : #initialization }
TelnetParser >> willParser [
	^ self class willPrefix, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> wontParser [
	^ self class wontPrefix, #any asParser ==> #second
]
