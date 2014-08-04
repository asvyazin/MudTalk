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
	currentHitPoints color: Color red.
	currentHitPoints value: hp.
	maxHp ifNotNil: [
		currentHitPoints max: maxHp.
		currentHitPoints label: (hp asString, '/', maxHp asString) ]
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> initializeWidgets [
	currentHitPoints := self newSlider.
	currentSpellPoints := self newSlider.
	currentStamina := self newSlider.
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> sp: sp maxSp: maxSp [
	currentSpellPoints color: Color blue.
	currentSpellPoints value: sp.
	maxSp ifNotNil: [
		currentSpellPoints max: maxSp.
		currentSpellPoints label: (sp asString, '/', maxSp asString) ]
]

{ #category : #accessing }
MudTalkMateriaMagicaWindow >> st: st maxSt: maxSt [
	currentStamina color: Color green.
	currentStamina value: st.
	maxSt ifNotNil: [
		currentStamina max: maxSt.
		currentStamina label: (st asString, '/', maxSt asString) ]
]
