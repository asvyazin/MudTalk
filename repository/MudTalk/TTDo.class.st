Class {
	#name : #TTDo,
	#superclass : #TTWithOption,
	#category : #MudTalk
}

{ #category : #processing }
TTDo >> processWith: processor [
	processor do: self
]
