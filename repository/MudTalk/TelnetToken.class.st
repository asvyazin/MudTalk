Class {
	#name : #TelnetToken,
	#superclass : #Announcement,
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
