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
TelnetParserTests >> testAllTokens [
	self parse: ('abc', sb, 'de', se, 'fg', do, 'hij', will, 'klm', dont, 'nop', wont, 'qrs')
		expect: { 
			TelnetTextEvent text: 'abc'.
			TelnetSubnegoEvent option: $d data: {$e}.
			TelnetTextEvent text: 'fg'.
			TelnetDoEvent option: $h.
			TelnetTextEvent text: 'ij'.
			TelnetWillEvent option: $k.
			TelnetTextEvent text: 'lm'.
			TelnetDontEvent option: $n.
			TelnetTextEvent text: 'op'.
			TelnetWontEvent option: $q.
			TelnetTextEvent text: 'rs' }.
]

{ #category : #testing }
TelnetParserTests >> testCommand [
	self parse: (iac, 'a') expect: TelnetCommandEvent option: $a

]

{ #category : #testing }
TelnetParserTests >> testDo [
	self parse: (do, 'a') expect: TelnetDoEvent option: $a

]

{ #category : #testing }
TelnetParserTests >> testDont [
	self parse: (dont, 'a') expect: TelnetDontEvent option: $a

]

{ #category : #testing }
TelnetParserTests >> testDoubleIac [
	self parse: (iac, iac, 'abc') expect: {TelnetTextEvent text: (iac, 'abc')}
]

{ #category : #testing }
TelnetParserTests >> testSimpleCharacters [
	self parse: '123' expect: {TelnetTextEvent text: '123'}
]

{ #category : #testing }
TelnetParserTests >> testStreamParser [
	self parse: ('abc', iac) expect: { TelnetTextEvent text:'abc' }.
	self parse: 'abc' expect: { TelnetCommandEvent option: $a. TelnetTextEvent text: 'bc' }.
]

{ #category : #testing }
TelnetParserTests >> testSubnego [
	self parse: (sb, 'a', se) expect: TelnetSubnegoEvent suchAs: [:token |
		(token option = $a) and: [token data size = 0]].
	self parse: (sb, 'bc', se) expect: TelnetSubnegoEvent suchAs: [:token |
		((token option = $b) and: [token data size = 1]) and: [token data first = $c]]

]

{ #category : #testing }
TelnetParserTests >> testWill [
	self parse: (will, 'a') expect: TelnetWillEvent option: $a

]

{ #category : #testing }
TelnetParserTests >> testWont [
	self parse: (wont, 'a') expect: TelnetWontEvent option: $a

]
