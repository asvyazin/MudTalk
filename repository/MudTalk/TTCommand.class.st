Class {
	#name : #TTCommand,
	#superclass : #TelnetToken,
	#instVars : [
		'code'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTCommand class >> code: aCode [
	^ self new code: aCode
]

{ #category : #comparing }
TTCommand >> = anObject [
	^ (anObject class = self class) and: [anObject code = code]
]

{ #category : #accessing }
TTCommand >> code [
	^ code
]

{ #category : #initialization }
TTCommand >> code: aCode [
	code := aCode
]

{ #category : #comparing }
TTCommand >> hash [
	^ code hash
]
