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
TelnetParser class >> doHeader [
	^ self iac asParser, self do asParser
]

{ #category : #constants }
TelnetParser class >> dont [
	^ Character value: 254
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

{ #category : #constants }
TelnetParser class >> will [
	^ Character value: 251
]

{ #category : #constants }
TelnetParser class >> wont [
	^ Character value: 252
]

{ #category : #initialization }
TelnetParser >> commandParser [
	^ self class iac asParser, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> doHeader [
	^ self class iac asParser , self class do asParser
]

{ #category : #initialization }
TelnetParser >> doParser [
	^ self class doHeader, #any asParser ==> #second
]

{ #category : #initialization }
TelnetParser >> dontParser [
	^ self class iac asParser, self class dont asParser, #any asParser
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
	^ self class iac asParser, self class sb asParser, #any asParser star, self class iac asParser, self class se asParser
]

{ #category : #initialization }
TelnetParser >> willParser [
	^ self class iac asParser, self class will asParser, #any asParser
]

{ #category : #initialization }
TelnetParser >> wontParser [
	^ self class iac asParser, self class wont asParser, #any asParser
]
