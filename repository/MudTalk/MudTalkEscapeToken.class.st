Class {
	#name : #MudTalkEscapeToken,
	#superclass : #Object,
	#instVars : [
		'parameter',
		'intermediate',
		'final'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkEscapeToken >> final [
	^ final
]

{ #category : #accessing }
MudTalkEscapeToken >> final: aFinalCharacter [
	final := aFinalCharacter
]

{ #category : #accessing }
MudTalkEscapeToken >> intermediate [
	^ intermediate
]

{ #category : #accessing }
MudTalkEscapeToken >> intermediate: anIntermediateBytes [
	intermediate := anIntermediateBytes
]

{ #category : #accessing }
MudTalkEscapeToken >> isTextAttributesEscapeSequence [
	^ final == $m
]

{ #category : #accessing }
MudTalkEscapeToken >> parameter [
	^ parameter
]

{ #category : #accessing }
MudTalkEscapeToken >> parameter: aParameterCharacters [
	parameter := aParameterCharacters
]

{ #category : #processing }
MudTalkEscapeToken >> processEscapeTokenWith: processor [  
	processor escape: self
]
