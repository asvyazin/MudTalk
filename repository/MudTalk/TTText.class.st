Class {
	#name : #TTText,
	#superclass : #TelnetToken,
	#instVars : [
		'text'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTText class >> text: aText [
	^ self new text: aText
]

{ #category : #comparing }
TTText >> = anObject [
	^ (self class = anObject class) and: [text = anObject text]
]

{ #category : #comparing }
TTText >> hash [
	^ text hash
]

{ #category : #processing }
TTText >> processWith: processor [
	processor text: self
]

{ #category : #accessing }
TTText >> text [
	^ text
]

{ #category : #accessing }
TTText >> text: anObject [
	text := anObject
]
