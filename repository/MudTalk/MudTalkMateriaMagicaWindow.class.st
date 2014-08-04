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
MudTalkMateriaMagicaWindow >> currentSpellPoints [
	^ currentSpellPoints
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> currentStamina [
	^ currentStamina
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> hp: hp maxHp: maxHp [
	currentHitPoints text: (hp asString, '/', maxHp asString)
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

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> sp: sp maxSp: maxSp [
	currentSpellPoints text: (sp asString, '/', maxSp asString)
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> st: st maxSt: maxSt [
	currentStamina text: (st asString, '/', maxSt asString)
]
