Class {
	#name : #MudTalkEscapeToken,
	#superclass : #PPToken,
	#category : #'MudTalk-Client'
}

{ #category : #processing }
MudTalkEscapeToken >> processEscapeTokenWith: processor [  
	processor escape: self
]
