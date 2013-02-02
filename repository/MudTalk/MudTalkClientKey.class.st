Class {
	#name : #MudTalkClientKey,
	#superclass : #Object,
	#instVars : [
		'keyValue',
		'scanCode'
	],
	#category : #'MudTalk-Client'
}

{ #category : #numpad }
MudTalkClientKey class >> num0 [
	^ self new keyValue: 16r30; scanCode: 96
]

{ #category : #numpad }
MudTalkClientKey class >> num1 [
	^ self new keyValue: 16r31; scanCode: 97
]

{ #category : #numpad }
MudTalkClientKey class >> num2 [
	^ self new keyValue: 16r32; scanCode: 98
]

{ #category : #numpad }
MudTalkClientKey class >> num3 [
	^ self new keyValue: 16r33; scanCode: 99
]

{ #category : #numpad }
MudTalkClientKey class >> num4 [
	^ self new keyValue: 16r34; scanCode: 100
]

{ #category : #numpad }
MudTalkClientKey class >> num5 [
	^ self new keyValue: 16r35; scanCode: 101
]

{ #category : #numpad }
MudTalkClientKey class >> num6 [
	^ self new keyValue: 16r36; scanCode: 102
]

{ #category : #numpad }
MudTalkClientKey class >> num7 [
	^ self new keyValue: 16r37; scanCode: 103
]

{ #category : #numpad }
MudTalkClientKey class >> num8 [
	^ self new keyValue: 16r38; scanCode: 104
]

{ #category : #numpad }
MudTalkClientKey class >> num9 [
	^ self new keyValue: 16r39; scanCode: 105
]

{ #category : #accessing }
MudTalkClientKey >> keyValue [
	^ keyValue
]

{ #category : #accessing }
MudTalkClientKey >> keyValue: aKeyValue [
	keyValue := aKeyValue
]

{ #category : #matching }
MudTalkClientKey >> matchEvent: evt [
	^ (scanCode isNil or: [scanCode = evt scanCode]) and:
		[keyValue isNil or: [keyValue = evt keyValue]]
]

{ #category : #accessing }
MudTalkClientKey >> scanCode: aScanCode [
	scanCode := aScanCode
]
