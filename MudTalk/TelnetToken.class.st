Class {
	#name : #TelnetToken,
	#superclass : #Object,
	#category : #MudTalk
}

{ #category : #testing }
TelnetToken >> isTTCharacter [
	^ false
]

{ #category : #processing }
TelnetToken >> processWith: processor [
	self subclassResponsibility
]
