Class {
	#name : #TTSubnego,
	#superclass : #TTWithOption,
	#instVars : [
		'data'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTSubnego class >> option: option data: data [
	^ (self option: option) data: data; yourself
]

{ #category : #comparing }
TTSubnego >> = anObject [
	^ (self class = anObject class) and: [(data isNil and: anObject data isNil) or: [data hasEqualElements: anObject data]]
]

{ #category : #accessing }
TTSubnego >> data [
	^ data
]

{ #category : #accessing }
TTSubnego >> data: anObject [
	data := anObject
]

{ #category : #comparing }
TTSubnego >> hash [
	^ (super hash) bitXor: (data hash)
]
