Class {
	#name : #TTDont,
	#superclass : #TTWithOption,
	#category : #MudTalk
}

{ #category : #processing }
TTDont >> processWith: processor [
	processor dont: self
]
