Class {
	#name : #TelnetStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'iacHandlers',
		'charBuffer'
	],
	#category : #MudTalk
}

{ #category : #telnet }
TelnetStream class >> DO [
	^ Character value: 253.
]

{ #category : #telnet }
TelnetStream class >> DONT [
	^ Character value: 254.
]

{ #category : #telnet }
TelnetStream class >> IAC [
	^ Character value: 255
]

{ #category : #telnet }
TelnetStream class >> SB [
	^ Character value: 250.
]

{ #category : #telnet }
TelnetStream class >> SE [
	^ Character value: 240.
]

{ #category : #telnet }
TelnetStream class >> WILL [
	^ Character value: 251.
]

{ #category : #telnet }
TelnetStream class >> WONT [
	^ Character value: 252 .
]

{ #category : #'instance creation' }
TelnetStream class >> on: aSource [ 
	^ self new source: aSource
]

{ #category : #telnet }
TelnetStream class >> subnegoEnd [
	^ {TelnetStream IAC. TelnetStream SE}
]

{ #category : #reading }
TelnetStream >> iacDoNext [
	^ TelnetDo option: self readOption
]

{ #category : #reading }
TelnetStream >> iacDontNext [
	^ TelnetDont option: self readOption
]

{ #category : #reading }
TelnetStream >> iacNext [
	| c |
	c := stream next.
	(c = TelnetStream IAC)
		ifTrue: [
			charBuffer add: TelnetStream IAC.
			charBuffer isFull isTrue: [ ^ charBuffer clear ].
			^ self next ]
		ifFalse: [
			iacHandlers at: c
				ifPresent: [ :handler | ^ handler value ]
				ifAbsent: [ ^ TelnetCommand value: c asInteger ] ]
	
]

{ #category : #reading }
TelnetStream >> iacSbNext [
	| option data |
	option := self readOption.
	data := stream upToAll: TelnetStream subnegoEnd.
	^ TelnetSubnego option: option data: data
]

{ #category : #reading }
TelnetStream >> iacWillNext [
	^ TelnetWill option: self readOption
]

{ #category : #reading }
TelnetStream >> iacWontNext [
	^ TelnetWont option: self readOption
]

{ #category : #initializing }
TelnetStream >> initialize [
	super initialize.
	charBuffer := TelnetCharBuffer new.
	iacHandlers := Dictionary new.
	iacHandlers at: TelnetStream DO put: [ self iacDoNext ].
	iacHandlers at: TelnetStream DONT put: [ self iacDontNext ].
	iacHandlers at: TelnetStream WILL put: [ self iacWillNext ].
	iacHandlers at: TelnetStream WONT put: [ self iacWontNext ].
	iacHandlers at: TelnetStream SB put: [ self iacSbNext ].
]

{ #category : #reading }
TelnetStream >> next [
	| c |
	[ stream isDataAvailable ifFalse: [ charBuffer isEmpty ifFalse: [ ^ charBuffer clear ] ].
		c := stream next.
		(c = TelnetStream IAC) ifTrue: [ ^ self iacNext ].
		charBuffer add: c.
		charBuffer isFull ifTrue: [ ^ charBuffer clear ] ] repeat.
]

{ #category : #reading }
TelnetStream >> readOption [
	^ stream next asInteger
]

{ #category : #initializing }
TelnetStream >> source: aSource [ 
	stream := aSource
]
