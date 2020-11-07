Class {
	#name : #TTWont,
	#superclass : #TTWithOption,
	#category : #MudTalk
}

{ #category : #processing }
TTWont >> processWith: processor [
	processor wont: self
]
