Class {
	#name : #TelnetOption,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#classInstVars : [
		'optionStrings'
	],
	#category : #MudTalk
}

{ #category : #constants }
TelnetOption class >> compress [
	^ 85.
]

{ #category : #constants }
TelnetOption class >> compress2 [
	^ 86.
]

{ #category : #constants }
TelnetOption class >> echo [
	^ 1
]

{ #category : #constants }
TelnetOption class >> eor [
	^ 239
]

{ #category : #constants }
TelnetOption class >> ga [
	^ 249
]

{ #category : #constants }
TelnetOption class >> gmcp [
	^ 201.
]

{ #category : #initialization }
TelnetOption class >> initialize [
	"TelnetOption initialize"
	super initialize.
	optionStrings := Dictionary new.
	self initializeOptionStrings
	
]

{ #category : #initialization }
TelnetOption class >> initializeOptionStrings [
	optionStrings
		at: self compress put: 'COMPRESS';
		at: self compress2 put: 'COMPRESS2';
		at: self echo put: 'ECHO';
		at: self teloptEor put: 'EOR';
		at: self gmcp put: 'GMCP';
		at: self msp put: 'MSP';
		at: self mssp put: 'MSSP';
		at: self msdp put: 'MSDP';
		at: self mxp put: 'MXP';
		at: self naws put: 'NAWS';
		at: self suppressGoAhead put: 'SUPPRESS_GO_AHEAD';
		at: self terminalType put: 'TERMINAL_TYPE';
		at: self newEnviron put: 'NEW_ENVIRON'
]

{ #category : #constants }
TelnetOption class >> msdp [
	^ 69
]

{ #category : #constants }
TelnetOption class >> msp [
	^ 90.
]

{ #category : #constants }
TelnetOption class >> mssp [
	^ 70
]

{ #category : #constants }
TelnetOption class >> mxp [
	^ 91.
]

{ #category : #constants }
TelnetOption class >> naws [
	^ 31.
]

{ #category : #constants }
TelnetOption class >> newEnviron [
	^ 39
]

{ #category : #initialization }
TelnetOption class >> on: anOption [
	^ self new on: anOption
]

{ #category : #strings }
TelnetOption class >> optionString: anOption [
	optionStrings
		at: anOption
		ifPresent: [ :str | ^ str ]
		ifAbsent: [ ^ anOption asString ]
]

{ #category : #constants }
TelnetOption class >> suppressGoAhead [
	^ 3.
]

{ #category : #constants }
TelnetOption class >> teloptEor [
	^ 25.
]

{ #category : #constants }
TelnetOption class >> terminalType [
	^ 24.
]

{ #category : #comparing }
TelnetOption >> = anObject [
	^ option = (anObject option)
]

{ #category : #converting }
TelnetOption >> asString [
	^ self class optionString: option
]

{ #category : #comparing }
TelnetOption >> hash [
	^ option hash
]

{ #category : #initialization }
TelnetOption >> on: anOption [
	option := anOption
]
