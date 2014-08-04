Class {
	#name : #MudTalkMateriaMagicaWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'currentHitPoints',
		'currentSpellPoints',
		'currentStamina',
		'maxHitPoints',
		'maxSpellPoints',
		'maxStamina'
	],
	#category : #'MudTalk-Client'
}

{ #category : #specs }
MudTalkMateriaMagicaWindow class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :column | column
			add: #currentHitPoints;
			add: #maxHitPoints;
			add: #currentSpellPoints;
			add: #maxSpellPoints;
			add: #currentStamina;
			add: #maxStamina ];
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
	maxHitPoints := self instantiate: LabeledText.
	maxHitPoints label: 'Max HP'.
	currentSpellPoints := self instantiate: LabeledText.
	currentSpellPoints label: 'SP'.
	maxSpellPoints := self instantiate: LabeledText.
	maxSpellPoints label: 'Max SP'.
	currentStamina := self instantiate: LabeledText.
	currentStamina label: 'ST'.
	maxStamina := self instantiate: LabeledText.
	maxStamina label: 'Max ST'
]

{ #category : #'as yet unclassified' }
MudTalkMateriaMagicaWindow >> maxHitPoints [
	^ maxHitPoints
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> maxHitPoints: anInteger [ 
	maxHitPoints text: anInteger asString
]

{ #category : #'as yet unclassified' }
MudTalkMateriaMagicaWindow >> maxSpellPoints [
	^ maxSpellPoints
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> maxSpellPoints: anInteger [ 
	maxSpellPoints text: anInteger asString
]

{ #category : #'as yet unclassified' }
MudTalkMateriaMagicaWindow >> maxStamina [
	^ maxStamina
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> maxStamina: anInteger [ 
	maxStamina text: anInteger asString
]
