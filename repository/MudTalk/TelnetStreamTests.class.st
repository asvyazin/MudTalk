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
TelnetStreamTests >> testCharacters [
	baseStream can receive: #next; answers: $a; answers: (Character value:255); answers: (Character value: 255).
	self assert: (telnetStream next) equals: (TTCharacter character: $a).
	self assert: (telnetStream next) equals: (TTCharacter character: (Character value: 255))
]

{ #category : #running }
TelnetStreamTests >> testCommand [
	baseStream can receive: #next; answers: (Character value:255); answers: $a.
	self assert: (telnetStream next) equals: (TTCommand code: $a)
]

{ #category : #running }
TelnetStreamTests >> testDo [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 253); answers: $a.
	self assert: (telnetStream next) equals: (TTDo option: $a)
]

{ #category : #running }
TelnetStreamTests >> testDont [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 254); answers: $a.
	self assert: (telnetStream next) equals: (TTDont option: $a)
]

{ #category : #running }
TelnetStreamTests >> testSubnego [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 250); answers: $a; answers: $b; answers: $c; answers: (Character value: 255); answers: (Character value: 240).
	self assert: (telnetStream next) equals: (TTSubnego option: $a body: {$b. $c})
]

{ #category : #running }
TelnetStreamTests >> testWill [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 251); answers: $a.
	self assert: (telnetStream next) equals: (TTWill option: $a)
]

{ #category : #running }
TelnetStreamTests >> testWont [
	baseStream can receive: #next; answers: (Character value:255); answers: (Character value: 252); answers: $a.
	self assert: (telnetStream next) equals: (TTWont option: $a)
]
