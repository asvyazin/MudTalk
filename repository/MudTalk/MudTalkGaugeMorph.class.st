Class {
	#name : #MudTalkGaugeMorph,
	#superclass : #Morph,
	#instVars : [
		'absoluteValue',
		'gaugeColor'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGaugeMorph >> absoluteValue [
	^ absoluteValue
]

{ #category : #accessing }
MudTalkGaugeMorph >> absoluteValue: anObject [
	absoluteValue = anObject ifFalse: [ 
		absoluteValue := anObject.
		self changed ]
]

{ #category : #drawing }
MudTalkGaugeMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	aCanvas fillRectangle: self gaugeRectangle color: self gaugeColor.
]

{ #category : #accessing }
MudTalkGaugeMorph >> gaugeColor [
	^ gaugeColor
]

{ #category : #accessing }
MudTalkGaugeMorph >> gaugeColor: aColor [
	gaugeColor := aColor
]

{ #category : #private }
MudTalkGaugeMorph >> gaugeRectangle [
	| morphBounds |
	morphBounds := self bounds.
	^ morphBounds origin extent: (morphBounds extent scaleBy: absoluteValue @ 1)
]
