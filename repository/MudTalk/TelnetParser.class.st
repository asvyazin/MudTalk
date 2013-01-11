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
	^ (TelnetParser iac , TelnetParser aoChar asParser) token: TelnetAoToken
]

{ #category : #constants }
TelnetParser class >> aoChar [
	^ Character value: 245.
]

{ #category : #parsers }
TelnetParser class >> ayt [
 	^ (TelnetParser iac , TelnetParser aytChar asParser) token: TelnetAytToken
]

{ #category : #constants }
TelnetParser class >> aytChar [
	^ Character value: 246.
]

{ #category : #parsers }
TelnetParser class >> brk [
	^ (TelnetParser iac , TelnetParser brkChar asParser) token: TelnetBrkToken
]

{ #category : #constants }
TelnetParser class >> brkChar [
	^ Character value: 243.
]

{ #category : #parsers }
TelnetParser class >> dm [
	^ (TelnetParser iac , TelnetParser dmChar asParser) token: TelnetDmToken
]

{ #category : #constants }
TelnetParser class >> dmChar [
	^ Character value: 242.
]

{ #category : #parsers }
TelnetParser class >> do [
	^ (TelnetParser iac,
		TelnetParser doChar asParser,
		(TelnetParser anyToken: TelnetDoToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> doChar [
	^ Character value: 253.
]

{ #category : #parsers }
TelnetParser class >> dont [
	^ (TelnetParser iac,
		TelnetParser dontChar asParser,
		(TelnetParser anyToken: TelnetDontToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> dontChar [
	^ Character value: 254.
]

{ #category : #parsers }
TelnetParser class >> ec [
	^ (TelnetParser iac , TelnetParser ecChar asParser) token: TelnetEcToken
]

{ #category : #constants }
TelnetParser class >> ecChar [
	^ Character value: 247.
]

{ #category : #parsers }
TelnetParser class >> el [
	^ (TelnetParser iac , TelnetParser elChar asParser) token: TelnetElToken
]

{ #category : #constants }
TelnetParser class >> elChar [
	^ Character value: 248.
]

{ #category : #parsers }
TelnetParser class >> eor [
	^ (TelnetParser iac, TelnetParser eorChar asParser) token: TelnetEorToken.
]

{ #category : #constants }
TelnetParser class >> eorChar [
	^ Character value: 239.
]

{ #category : #constants }
TelnetParser class >> eorDelimiter [
	^ String with: TelnetParser iacChar with: TelnetParser eorChar.
]

{ #category : #parsers }
TelnetParser class >> ga [
	^ (TelnetParser iac , TelnetParser gaChar asParser) token: TelnetGaToken
]

{ #category : #constants }
TelnetParser class >> gaChar [
	^ Character value: 249.
]

{ #category : #parsers }
TelnetParser class >> iac [
	^ TelnetParser iacChar asParser.
]

{ #category : #constants }
TelnetParser class >> iacChar [
	^ Character value: 255.
]

{ #category : #parsers }
TelnetParser class >> iaciac [
	^ (TelnetParser iac, TelnetParser iac)
		answer: TelnetParser iacChar.
]

{ #category : #parsers }
TelnetParser class >> ip [
	^ (TelnetParser iac , TelnetParser ipChar asParser) token: TelnetIpToken
]

{ #category : #parsers }
TelnetParser class >> ipChar [
	^ Character value: 244.
]

{ #category : #parsers }
TelnetParser class >> nop [
	^ (TelnetParser iac , TelnetParser nopChar asParser) token: TelnetNopToken
]

{ #category : #constants }
TelnetParser class >> nopChar [
	^ Character value: 241.
]

{ #category : #parsers }
TelnetParser class >> normalChar [
	^ TelnetParser iaciac / TelnetParser iac negate.
]

{ #category : #parsers }
TelnetParser class >> parser [
	^ (TelnetParser special / TelnetParser text) star end.
]

{ #category : #parsers }
TelnetParser class >> sb [
	^ (TelnetParser iac, TelnetParser sbChar asParser) answer: #sb
]

{ #category : #constants }
TelnetParser class >> sbChar [
	^ Character value: 250.
]

{ #category : #parsers }
TelnetParser class >> se [
	^ (TelnetParser iac, TelnetParser seChar asParser) answer: #se
]

{ #category : #constants }
TelnetParser class >> seChar [
	^ Character value: 240.
]

{ #category : #parsers }
TelnetParser class >> special [
	^ TelnetParser nop /
		TelnetParser dm /
		TelnetParser brk /
		TelnetParser ip /
		TelnetParser ao /
		TelnetParser ayt /
		TelnetParser ec /
		TelnetParser el /
		TelnetParser ga /
		TelnetParser do /
		TelnetParser dont /
		TelnetParser will /
		TelnetParser wont /
		TelnetParser subnego.
]

{ #category : #parsers }
TelnetParser class >> subnego [
	^ TelnetParser sb, (TelnetParser normalChar plus token: TelnetSubnegoToken), TelnetParser se ==>
		[ :parts | parts at: 2 ]
]

{ #category : #parsers }
TelnetParser class >> text [
	^ TelnetParser normalChar plus ==> [:chars | TelnetTextToken on: (String withAll: chars)].
]

{ #category : #parsers }
TelnetParser class >> will [
	^ (TelnetParser iac,
		TelnetParser willChar asParser,
		(TelnetParser anyToken: TelnetWillToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> willChar [
	^ Character value: 251.
]

{ #category : #parsers }
TelnetParser class >> wont [
	^ (TelnetParser iac,
		TelnetParser wontChar asParser,
		(TelnetParser anyToken: TelnetWontToken)) ==>
			[:parts | parts at: 3].
]

{ #category : #constants }
TelnetParser class >> wontChar [
	^ Character value: 252.
]
