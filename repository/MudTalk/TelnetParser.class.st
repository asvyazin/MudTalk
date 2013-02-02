Class {
	#name : #TelnetParser,
	#superclass : #Object,
	#category : #'MudTalk-Obsolete'
}

{ #category : #parsers }
TelnetParser class >> anyToken: aTokenClass [
	^ #any asParser token: aTokenClass.
]

{ #category : #parsers }
TelnetParser class >> ao [
	^ (self class iac, self class aoChar asParser) token: TelnetAoToken
]

{ #category : #constants }
TelnetParser class >> aoChar [
	^ Character value: 245.
]

{ #category : #parsers }
TelnetParser class >> ayt [
 	^ (self class iac, self class aytChar asParser) token: TelnetAytToken
]

{ #category : #constants }
TelnetParser class >> aytChar [
	^ Character value: 246.
]

{ #category : #parsers }
TelnetParser class >> brk [
	^ (self class iac, self class brkChar asParser) token: TelnetBrkToken
]

{ #category : #constants }
TelnetParser class >> brkChar [
	^ Character value: 243.
]

{ #category : #parsers }
TelnetParser class >> dm [
	^ (self class iac, self class dmChar asParser) token: TelnetDmToken
]

{ #category : #constants }
TelnetParser class >> dmChar [
	^ Character value: 242.
]

{ #category : #parsers }
TelnetParser class >> do [
	^ (self class iac,
		self class doChar asParser,
		(self class anyToken: TelnetDoToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> doChar [
	^ Character value: 253.
]

{ #category : #parsers }
TelnetParser class >> dont [
	^ (self class iac,
		self class dontChar asParser,
		(self class anyToken: TelnetDontToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> dontChar [
	^ Character value: 254.
]

{ #category : #parsers }
TelnetParser class >> ec [
	^ (self class iac, self class ecChar asParser) token: TelnetEcToken
]

{ #category : #constants }
TelnetParser class >> ecChar [
	^ Character value: 247.
]

{ #category : #parsers }
TelnetParser class >> el [
	^ (self class iac, self class elChar asParser) token: TelnetElToken
]

{ #category : #constants }
TelnetParser class >> elChar [
	^ Character value: 248.
]

{ #category : #parsers }
TelnetParser class >> eor [
	^ (self class iac, self class eorChar asParser) token: TelnetEorToken.
]

{ #category : #constants }
TelnetParser class >> eorChar [
	^ Character value: 239.
]

{ #category : #constants }
TelnetParser class >> eorDelimiter [
	^ String with: self class iacChar with: self class eorChar.
]

{ #category : #parsers }
TelnetParser class >> ga [
	^ (self class iac, self class gaChar asParser) token: TelnetGaToken
]

{ #category : #constants }
TelnetParser class >> gaChar [
	^ Character value: 249.
]

{ #category : #parsers }
TelnetParser class >> iac [
	^ self class iacChar asParser.
]

{ #category : #constants }
TelnetParser class >> iacChar [
	^ Character value: 255.
]

{ #category : #parsers }
TelnetParser class >> iaciac [
	^ (self class iac, self class iac)
		answer: self class iacChar.
]

{ #category : #parsers }
TelnetParser class >> ip [
	^ (self class iac, self class ipChar asParser) token: TelnetIpToken
]

{ #category : #parsers }
TelnetParser class >> ipChar [
	^ Character value: 244.
]

{ #category : #parsers }
TelnetParser class >> nop [
	^ (self class iac, self class nopChar asParser) token: TelnetNopToken
]

{ #category : #constants }
TelnetParser class >> nopChar [
	^ Character value: 241.
]

{ #category : #parsers }
TelnetParser class >> normalChar [
	^ self class iaciac / self class iac negate.
]

{ #category : #parsers }
TelnetParser class >> parser [
	^ (self class special / self class text) star end.
]

{ #category : #parsers }
TelnetParser class >> sb [
	^ (self class iac, self class sbChar asParser) answer: #sb
]

{ #category : #constants }
TelnetParser class >> sbChar [
	^ Character value: 250.
]

{ #category : #parsers }
TelnetParser class >> se [
	^ (self class iac, self class seChar asParser) answer: #se
]

{ #category : #constants }
TelnetParser class >> seChar [
	^ Character value: 240.
]

{ #category : #parsers }
TelnetParser class >> special [
	^ self class nop /
		self class dm /
		self class brk /
		self class ip /
		self class ao /
		self class ayt /
		self class ec /
		self class el /
		self class ga /
		self class do /
		self class dont /
		self class will /
		self class wont /
		self class subnego
]

{ #category : #parsers }
TelnetParser class >> subnego [
	^ self class sb, (self class normalChar plus token: TelnetSubnegoToken), self class se ==>
		[ :parts | parts at: 2 ]
]

{ #category : #parsers }
TelnetParser class >> text [
	^ self class normalChar plus ==> [:chars | TelnetTextToken on: (String withAll: chars)].
]

{ #category : #parsers }
TelnetParser class >> will [
	^ (self class iac,
		self class willChar asParser,
		(self class anyToken: TelnetWillToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> willChar [
	^ Character value: 251.
]

{ #category : #parsers }
TelnetParser class >> wont [
	^ (self class iac,
		self class wontChar asParser,
		(self class anyToken: TelnetWontToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> wontChar [
	^ Character value: 252.
]
