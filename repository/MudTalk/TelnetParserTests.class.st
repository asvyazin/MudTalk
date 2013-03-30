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
			'abc'.
			TelnetSubnegoToken option: $d data: {$e}.
			'fg'.
			TelnetDoToken option: $h.
			'ij'.
			TelnetWillToken option: $k.
			'lm'.
			TelnetDontToken option: $n.
			'op'.
			TelnetWontToken option: $q.
			'rs' }.
]

{ #category : #testing }
TelnetParserTests >> testCommand [
	self parse: (iac, 'a') expect: {(TelnetCommandToken option: $a)}

]

{ #category : #testing }
TelnetParserTests >> testDo [
	self parse: (do, 'a') expect: {(TelnetDoToken option: $a)}

]

{ #category : #testing }
TelnetParserTests >> testDont [
	self parse: (dont, 'a') expect: {(TelnetDontToken option: $a)}

]

{ #category : #testing }
TelnetParserTests >> testDoubleIac [
	self parse: (iac, iac, 'abc') expect: {(iac, 'abc')}
]

{ #category : #testing }
TelnetParserTests >> testSimpleCharacters [
	self parse: '123' expect: {'123'}
]

{ #category : #testing }
TelnetParserTests >> testStreamParser [
	self parse: ('abc', iac) expect: { 'abc' }.
	self parse: 'abc' expect: { TelnetCommandToken option: $a. 'bc' }.
]

{ #category : #testing }
TelnetParserTests >> testSubnego [
	self parse: (sb, 'a', se) expect: {(TelnetSubnegoToken option: $a data: #())}.
	self parse: (sb, 'bc', se) expect: {(TelnetSubnegoToken option: $b data: {$c})}.

]

{ #category : #testing }
TelnetParserTests >> testWill [
	self parse: (will, 'a') expect: {(TelnetWillToken option: $a)}

]

{ #category : #testing }
TelnetParserTests >> testWont [
	self parse: (wont, 'a') expect: {(TelnetWontToken option: $a)}

]
