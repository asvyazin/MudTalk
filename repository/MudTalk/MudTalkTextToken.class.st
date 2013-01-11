Class {
	#name : #MudTalkTextToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Client'
}

{ #category : #processing }
MudTalkTextToken >> triggerOn: aTarget [
	aTarget unescapedText: self value
]
