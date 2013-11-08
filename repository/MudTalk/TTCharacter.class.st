Class {
	#name : #TTCharacter,
	#superclass : #TelnetToken,
	#instVars : [
		'character'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTCharacter class >> character: aCharacter [ 
	^ self new character: aCharacter
]

{ #category : #comparing }
TTCharacter >> = anObject [
	^ (self class = anObject class) and: (character = anObject character)
]

{ #category : #accessing }
TTCharacter >> character [
	^ character
]

{ #category : #accessing }
TTCharacter >> character: aCharacter [ 
	character := aCharacter
]

{ #category : #comparing }
TTCharacter >> hash [
	^ character hash
]
