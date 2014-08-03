Class {
	#name : #MudTalkMateriaMagicaWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'currentHitPoints',
		'currentSpellPoints',
		'currentStamina'
	],
	#category : #'MudTalk-Client'
}

{ #category : #specs }
MudTalkMateriaMagicaWindow class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :column | column
			add: #currentHitPoints;
			add: #currentSpellPoints;
			add: #currentStamina ];
		yourself
]

{ #category : #specs }
MudTalkMateriaMagicaWindow class >> title [
	 ^ 'Materia Magica'
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentHitPoints [
	^ currentHitPoints
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentHitPoints: anObject [
	currentHitPoints text: anObject asString
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentSpellPoints [
	^ currentSpellPoints
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentSpellPoints: anObject [
	currentSpellPoints text: anObject asString
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentStamina [
	^ currentStamina
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentStamina: anObject [
	currentStamina text: anObject asString
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> initializeWidgets [
	currentHitPoints := self instantiate: LabeledText.
	currentHitPoints label: 'HP'.
	currentSpellPoints := self instantiate: LabeledText.
	currentSpellPoints label: 'SP'.
	currentStamina := self instantiate: LabeledText.
	currentStamina label: 'ST'
]
