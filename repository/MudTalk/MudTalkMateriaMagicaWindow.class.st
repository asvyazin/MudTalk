Class {
	#name : #MudTalkMateriaMagicaWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'currentHitPointsGauge',
		'currentSpellPointsGauge',
		'currentStaminaGauge',
		'currentHitPointsText',
		'currentSpellPointsText',
		'currentStaminaText'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> client: aMudClient [
	self model: aMudClient.
	self model whenHitPointsChangedDo: [ self updateHitPointsGauge ].
	self model whenSpellPointsChangedDo: [ self updateSpellPointsGauge ].
	self model whenStaminaChangedDo: [ self updateStaminaGauge ].
	self addMorph: (self newColumn: {
		self newHitPointsRow.
		self newSpellPointsRow.
		self newStaminaRow })
		fullFrame: (0@0 extent: 1@1)
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentHitPointsGauge [
	^ currentHitPointsGauge ifNil: [
		currentHitPointsGauge := MudTalkGaugeMorph new
			color: Color white;
			gaugeColor: Color red;
			absoluteValue: 0.0;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentHitPointsText [
	^ currentHitPointsText ifNil: [ currentHitPointsText := self newCurrentHitPointsTextMorph ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentSpellPointsGauge [
	^ currentSpellPointsGauge ifNil: [
		currentSpellPointsGauge := MudTalkGaugeMorph new
			color: Color white;
			gaugeColor: Color blue;
			absoluteValue: 0.0;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentSpellPointsText [
	^ currentSpellPointsText ifNil: [ currentSpellPointsText := self newCurrentSpellPointsTextMorph ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentStaminaGauge [
	^ currentStaminaGauge ifNil: [
		currentStaminaGauge := MudTalkGaugeMorph new
			color: Color white;
			gaugeColor: Color green;
			absoluteValue: 0.0;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> currentStaminaText [
	^ currentStaminaText ifNil: [ currentStaminaText := self newCurrentStaminaTextMorph ]
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> initialize [
	super initialize.
	self setLabel: 'MateriaMagica'.

]

{ #category : #private }
MudTalkMateriaMagicaWindow >> newCurrentHitPointsTextMorph [
	^ (self newLabelFor: self model getLabel: #currentHitPointsText getEnabled: nil)
		vResizing: #spaceFill;
		yourself
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> newCurrentSpellPointsTextMorph [
	^ (self newLabelFor: self model getLabel: #currentSpellPointsText getEnabled: nil)
		vResizing: #spaceFill;
		yourself
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> newCurrentStaminaTextMorph [
	^ (self newLabelFor: self model getLabel: #currentStaminaText getEnabled: nil)
		vResizing: #spaceFill;
		yourself
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> newHitPointsRow [
	^ self newRow: {
		(self newLabel: 'HP') vResizing: #spaceFill.
		self currentHitPointsGauge.
		self currentHitPointsText}
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> newSpellPointsRow [
	^ self newRow: {
		(self newLabel: 'SP') vResizing: #spaceFill.
		self currentSpellPointsGauge.
		self currentSpellPointsText}
]

{ #category : #initialization }
MudTalkMateriaMagicaWindow >> newStaminaRow [
	^ self newRow: {
		(self newLabel: 'ST') vResizing: #spaceFill.
		self currentStaminaGauge.
		self currentStaminaText}
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> updateHitPointsGauge [
	| currentHitPoints maxHitPoints |
	currentHitPoints := self model currentHitPoints.
	maxHitPoints := self model maxHitPoints.
	maxHitPoints ~= 0
		ifTrue: [ self currentHitPointsGauge absoluteValue: currentHitPoints / maxHitPoints ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> updateSpellPointsGauge [
	| currentSpellPoints maxSpellPoints |
	currentSpellPoints := self model currentSpellPoints.
	maxSpellPoints := self model maxSpellPoints.
	maxSpellPoints ~= 0
		ifTrue: [ self currentSpellPointsGauge absoluteValue: currentSpellPoints / maxSpellPoints ]
]

{ #category : #private }
MudTalkMateriaMagicaWindow >> updateStaminaGauge [
	| currentStamina maxStamina |
	currentStamina := self model currentStamina.
	maxStamina := self model maxStamina.
	maxStamina ~= 0
		ifTrue: [ self currentStaminaGauge absoluteValue: currentStamina / maxStamina ]
]
