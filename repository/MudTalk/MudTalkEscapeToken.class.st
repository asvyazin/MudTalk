Class {
	#name : #MudTalkEscapeToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Client'
}

{ #category : #processing }
MudTalkEscapeToken >> triggerOn: aTarget [ 
	aTarget escape: self value
]
