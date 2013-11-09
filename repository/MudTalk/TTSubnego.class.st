Class {
	#name : #TTSubnego,
	#superclass : #TTWithOption,
	#instVars : [
		'body'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTSubnego class >> option: option body: body [
	^ (self option: option) body: body; yourself
]

{ #category : #comparing }
TTSubnego >> = anObject [
	^ (self class = anObject class) and: [(body isNil and: anObject body isNil) or: [body hasEqualElements: anObject body]]
]

{ #category : #accessing }
TTSubnego >> body [
	^ body
]

{ #category : #accessing }
TTSubnego >> body: anObject [
	body := anObject
]

{ #category : #comparing }
TTSubnego >> hash [
	^ (super hash) bitXor: (body hash)
]
