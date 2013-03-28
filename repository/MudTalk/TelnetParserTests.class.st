Class {
	#name : #TelnetParserTests,
	#superclass : #TestCase,
	#instVars : [
		'iac',
		'do',
		'dont',
		'will',
		'wont',
		'sb',
		'se',
		'parser'
	],
	#category : #'MudTalk-Tests'
}

{ #category : #testing }
TelnetParserTests >> parse: aString expect: expectedResult [
	self assert: (parser parse: aString) equals: expectedResult
]

{ #category : #testing }
TelnetParserTests >> parse: aStream expect: tokenClass option: anOption [
	self parse: aStream expect: tokenClass suchAs: [ :token | token option = anOption ]
]

{ #category : #testing }
TelnetParserTests >> parse: aString expect: tokenClass suchAs: assertionBlock [
	| result tokens |
	tokens := parser parse: aString.
	self assert: tokens size equals: 1.
	result := tokens first.
	self assert: result class equals: tokenClass.
	self should: [assertionBlock value: result]
]

{ #category : #testing }
TelnetParserTests >> setUp [
	parser := TelnetParser new.
	iac := String with: TelnetParser iac.
	do := iac, (String with: TelnetParser do).
	dont := iac, (String with: TelnetParser dont).
	will := iac, (String with: TelnetParser will).
	wont := iac, (String with: TelnetParser wont).
	sb := iac, (String with: TelnetParser sb).
	se := iac, (String with: TelnetParser se)
]

{ #category : #testing }
TelnetParserTests >> testCommand [
	self parse: (iac, 'a') expect: TelnetCommandToken option: $a

]

{ #category : #testing }
TelnetParserTests >> testDo [
	self parse: (do, 'a') expect: TelnetDoToken option: $a

]

{ #category : #testing }
TelnetParserTests >> testDont [
	self parse: (dont, 'a') expect: TelnetDontToken option: $a

]

{ #category : #testing }
TelnetParserTests >> testSimpleCharacters [
	self parse: '123' expect: {'123'}
]

{ #category : #testing }
TelnetParserTests >> testSubnego [
	self parse: (sb, 'a', se) expect: TelnetSubnegoToken suchAs: [:token |
		(token option = $a) and: [token data size = 0]].
	self parse: (sb, 'bc', se) expect: TelnetSubnegoToken suchAs: [:token |
		((token option = $b) and: [token data size = 1]) and: [token data first = $c]]

]

{ #category : #testing }
TelnetParserTests >> testWill [
	self parse: (will, 'a') expect: TelnetWillToken option: $a

]

{ #category : #testing }
TelnetParserTests >> testWont [
	self parse: (wont, 'a') expect: TelnetWontToken option: $a

]
