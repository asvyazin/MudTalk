Class {
	#name : #TelnetStreamTests,
	#superclass : #BabyMockTestCase,
	#instVars : [
		'telnetStream',
		'baseStream'
	],
	#category : #'MudTalk-Tests'
}

{ #category : #running }
TelnetStreamTests >> setUp [
	baseStream := context mock: 'stream'.
	telnetStream := TelnetStream on: baseStream
]

{ #category : #running }
TelnetStreamTests >> testCommand [
	baseStream can receive: #next; answers: (Character value:255); answers: $a.
	self assert: (telnetStream next) equals: (TTCommand code: $a asInteger)
]

{ #category : #running }
TelnetStreamTests >> testDo [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 253); answers: $a.
	self assert: (telnetStream next) equals: (TTDo option: $a asInteger)
]

{ #category : #running }
TelnetStreamTests >> testDont [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 254); answers: $a.
	self assert: (telnetStream next) equals: (TTDont option: $a asInteger)
]

{ #category : #running }
TelnetStreamTests >> testSubnego [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 250); answers: $a; answers: $b; answers: $c; answers: (Character value: 255); answers: (Character value: 240).
	self assert: (telnetStream next) equals: (TTSubnego option: ($a asInteger) data: {$b. $c})
]

{ #category : #running }
TelnetStreamTests >> testTextCr [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character cr); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: ('abc', String cr))
]

{ #category : #running }
TelnetStreamTests >> testTextCr2Lines [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character cr);
		answers: $d; answers: $e; answers: $f;
		answers: (Character cr); answers: (Character lf).
	self assert: (telnetStream next) equals: (TTText text: ('abc', String cr)).
	self assert: (telnetStream next) equals: (TTText text: ('def', String crlf))
]

{ #category : #running }
TelnetStreamTests >> testTextCrLf [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character cr); answers: (Character lf).
	self assert: (telnetStream next) equals: (TTText text: ('abc', String crlf))
]

{ #category : #running }
TelnetStreamTests >> testTextLf [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character lf); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: ('abc', String lf))
]

{ #category : #running }
TelnetStreamTests >> testTextLfCr [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character lf); answers: (Character cr).
	self assert: (telnetStream next) equals: (TTText text: ('abc', String lf, String cr))
]

{ #category : #running }
TelnetStreamTests >> testTextThenCommand [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value: 255); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testTextThenDo [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value: 255); answers: (Character value: 253); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testTextThenDont [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value: 255); answers: (Character value: 254); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testTextThenSubnego [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value:255); answers: (Character value: 250); answers: $a; answers: $b; answers: $c; answers: (Character value: 255); answers: (Character value: 240).
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testTextThenWill [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value: 255); answers: (Character value: 251); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testTextThenWont [
	baseStream can receive: #next;
		answers: $a; answers: $b; answers: $c;
		answers: (Character value: 255); answers: (Character value: 252); answers: $a.
	self assert: (telnetStream next) equals: (TTText text: 'abc')
]

{ #category : #running }
TelnetStreamTests >> testWill [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 251); answers: $a.
	self assert: (telnetStream next) equals: (TTWill option: $a asInteger)
]

{ #category : #running }
TelnetStreamTests >> testWont [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 252); answers: $a.
	self assert: (telnetStream next) equals: (TTWont option: $a asInteger)
]
