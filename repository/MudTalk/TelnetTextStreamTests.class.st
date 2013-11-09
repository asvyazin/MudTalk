Class {
	#name : #TelnetTextStreamTests,
	#superclass : #BabyMockTestCase,
	#instVars : [
		'stream',
		'baseStream'
	],
	#category : #'MudTalk-Tests'
}

{ #category : #tests }
TelnetTextStreamTests >> assertTelnetSpecialToken: token [
	baseStream can
		receive: #next;
		answers: token.
	self assert: stream next equals: token
]

{ #category : #tests }
TelnetTextStreamTests >> assertTextBeforeTelnetSpecialToken: token [
	baseStream can
		receive: #next;
		answers: (TTCharacter character: $b);
		answers: (TTCharacter character: $c);
		answers: token.
	baseStream can receive: #putBack:; with: token.
	self assert: stream next equals: (TTText text: 'bc')
]

{ #category : #running }
TelnetTextStreamTests >> setUp [
	baseStream := context mock: 'TelnetStream'.
	baseStream can receive: #isDataAvailable; answers: true.
	stream := TelnetTextStream on: baseStream
]

{ #category : #tests }
TelnetTextStreamTests >> testCommand [
	self assertTelnetSpecialToken: (TTCommand code: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testDo [
	self assertTelnetSpecialToken: (TTDo option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testDont [
	self assertTelnetSpecialToken: (TTDont option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testNewLineCR [
	baseStream can
		receive: #next;
		answers: (TTCharacter character: $a);
		answers: (TTCharacter character: $b);
		answers: (TTCharacter character: (Character cr));
		answers: (TTCharacter character: $c).
	baseStream can receive: #putBack:.
	self assert: stream next equals: (TTText text: (String withAll: {$a. $b. (Character cr).}))
]

{ #category : #tests }
TelnetTextStreamTests >> testNewLineCRLF [
	baseStream can
		receive: #next;
		answers: (TTCharacter character: $a);
		answers: (TTCharacter character: $b);
		answers: (TTCharacter character: (Character cr));
		answers: (TTCharacter character: (Character lf)).
	self assert: stream next equals: (TTText text: (String withAll: {$a. $b. (Character cr). (Character lf)}))
]

{ #category : #tests }
TelnetTextStreamTests >> testNewLineLF [
	baseStream can
		receive: #next;
		answers: (TTCharacter character: $a);
		answers: (TTCharacter character: $b);
		answers: (TTCharacter character: (Character lf));
		answers: (TTCharacter character: $c).
	baseStream can receive: #putBack:.
	self assert: stream next equals: (TTText text: (String withAll: {$a. $b. (Character lf).}))
]

{ #category : #tests }
TelnetTextStreamTests >> testNewLineLFCR [
	baseStream can
		receive: #next;
		answers: (TTCharacter character: $a);
		answers: (TTCharacter character: $b);
		answers: (TTCharacter character: (Character lf));
		answers: (TTCharacter character: (Character cr)).
	self assert: stream next equals: (TTText text:  (String withAll: {$a. $b. (Character lf). (Character cr).}))
]

{ #category : #tests }
TelnetTextStreamTests >> testSubnego [
	self assertTelnetSpecialToken: (TTSubnego option: $a body: #($b $c))
]

{ #category : #tests }
TelnetTextStreamTests >> testTextCommand [
	self assertTextBeforeTelnetSpecialToken: (TTCommand code: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testTextDo [
	self assertTextBeforeTelnetSpecialToken: (TTDo option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testTextDont [
	self assertTextBeforeTelnetSpecialToken: (TTDont option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testTextSubnego [
	self assertTextBeforeTelnetSpecialToken: (TTSubnego option: $a body: #($b $c))
]

{ #category : #tests }
TelnetTextStreamTests >> testTextWill [
	self assertTextBeforeTelnetSpecialToken: (TTWill option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testTextWont [
	self assertTextBeforeTelnetSpecialToken: (TTWont option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testWill [
	self assertTelnetSpecialToken: (TTWill option: $a)
]

{ #category : #tests }
TelnetTextStreamTests >> testWont [
	self assertTelnetSpecialToken: (TTWont option: $a)
]
