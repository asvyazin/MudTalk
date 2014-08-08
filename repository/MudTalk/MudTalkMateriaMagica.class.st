Class {
	#name : #MudTalkMateriaMagica,
	#superclass : #MudTalkClient,
	#instVars : [
		'materiaMagicaWindow',
		'currentHitPoints',
		'currentSpellPoints',
		'currentStamina',
		'maxHitPoints',
		'maxSpellPoints',
		'maxStamina'
	],
	#category : #'MudTalk-Client'
}

{ #category : #parsers }
MudTalkMateriaMagica class >> integerParser [
	^ #digit asParser plus ==> [ :t | (String withAll: t) asInteger ]
]

{ #category : #parsers }
MudTalkMateriaMagica class >> maxVitalParser: aVital [
	^ self integerParser, '%' asParser, self integerParser trimSpaces, '/' asParser, self integerParser trimSpaces, aVital asParser, '.' asParser ==> [ :t | { t at: 1. t at: 3. t at: 5 } ]
]

{ #category : #parsers }
MudTalkMateriaMagica class >> vitalsLineParser [
	^ '<' asParser, self integerParser, 'hp' asParser trimSpaces,
		self integerParser, 'sp' asParser trimSpaces,
		self integerParser, 'st' asParser trimSpaces, '>' asParser ==> [ :t | { t at: 2. t at: 4. t at: 6 } ]
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentHitPoints [
	^ currentHitPoints value
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentHitPoints: hp [
	currentHitPoints value: hp.
	self changed: #currentHitPointsText
]

{ #category : #protocol }
MudTalkMateriaMagica >> currentHitPointsText [
	^ self textGaugeCurrentValue: self currentHitPoints maxValue: self maxHitPoints.
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentSpellPoints [
	^ currentSpellPoints value
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentSpellPoints: sp [
	currentSpellPoints value: sp.
	self changed: #currentSpellPointsText
]

{ #category : #protocol }
MudTalkMateriaMagica >> currentSpellPointsText [
	^ self textGaugeCurrentValue: self currentSpellPoints maxValue: self maxSpellPoints.
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentStamina [
	^ currentStamina value
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentStamina: st [
	currentStamina value: st.
	self changed: #currentStaminaText
]

{ #category : #protocol }
MudTalkMateriaMagica >> currentStaminaText [
	^ self textGaugeCurrentValue: self currentStamina maxValue: self maxStamina.
]

{ #category : #private }
MudTalkMateriaMagica >> grabMaxVitals [
	self traceCr: 'grabbing max vitals'.
	(self
		triggerParser: (self class maxVitalParser: 'HP')
		do: [ :m | self maxHitPoints: (m at: 3) asInteger ])
		oneTime: true.
	self send: 'score hp'.
	
	(self
		triggerParser: (self class maxVitalParser: 'SP')
		do: [ :m | self maxSpellPoints: (m at: 3) asInteger ])
		oneTime: true.
	self send: 'score sp'.
	
	(self
		triggerParser: (self class maxVitalParser: 'ST')
		do: [ :m | self maxStamina: (m at: 3) asInteger ])
		oneTime: true.
	self send: 'score st'.
]

{ #category : #initialization }
MudTalkMateriaMagica >> initialize [
	super initialize.
	currentHitPoints := 0 asReactiveVariable.
	maxHitPoints := 0 asReactiveVariable.
	currentSpellPoints := 0 asReactiveVariable.
	maxSpellPoints := 0 asReactiveVariable.
	currentStamina := 0 asReactiveVariable.
	maxStamina := 0 asReactiveVariable.
	self initializeGmcp.
	self initializeTriggers.
	materiaMagicaWindow := MudTalkMateriaMagicaWindow new
		client: self;
		yourself.
	materiaMagicaWindow openInWorld.
	self openWindowOnHost: 'materiamagica.com' port: 4000
]

{ #category : #initialization }
MudTalkMateriaMagica >> initializeGmcp [
	gmcpSettings
		enablePackage: 'Core';
		enablePackage: 'Comm';
		enablePackage: 'Char';
		enablePackage: 'Char.Skills';
		enablePackage: 'Char.Items';
		enablePackage: 'Room';
		enablePackage: 'Redirect';
		enablePackage: 'Debug';
		enablePackage: 'IRE.Composer';
		registerMessageClass: MudTalkGmcpRoomInfo;
		registerMessageClass: MudTalkGmcpRoomWrongdir;
		registerMessageClass: MudTalkGmcpCoreGoodbye;
		registerMessageClass: MudTalkGmcpCharVitals.
	announcer on: MudTalkGmcpCharVitals send: #updateCharVitals: to: self.
]

{ #category : #initialization }
MudTalkMateriaMagica >> initializeTriggers [
	(self
		triggerParser: self class vitalsLineParser
		do: [ self grabMaxVitals ])
		oneTime: true.
	self
		aliasRegex: '^resync maxes$'
		do: [ self grabMaxVitals ].
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxHitPoints [
	^ maxHitPoints value
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxHitPoints: anInteger [
	maxHitPoints value: anInteger.
	self changed: #currentHitPointsText
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxSpellPoints [
	^ maxSpellPoints value
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxSpellPoints: anInteger [
	maxSpellPoints value: anInteger.
	self changed: #currentSpellPointsText
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxStamina [
	^ maxStamina value
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxStamina: anInteger [
	maxStamina value: anInteger.
	self changed: #currentStaminaText
]

{ #category : #private }
MudTalkMateriaMagica >> textGaugeCurrentValue: current maxValue: max [
	^ (current isNotNil and: [ max isNotNil ])
		ifTrue: [ current asString, '/', max asString ]
		ifFalse: [ '0/0' ]
]

{ #category : #private }
MudTalkMateriaMagica >> updateCharVitals: aMessage [
	aMessage
		at: #hp ifPresent: [ :hp | self currentHitPoints: hp ];
		at: #sp ifPresent: [ :sp | self currentSpellPoints: sp ];
		at: #st ifPresent: [ :st | self currentStamina: st ]
]

{ #category : #'protocol events' }
MudTalkMateriaMagica >> whenHitPointsChangedDo: aBlock [
	currentHitPoints whenChangedDo: aBlock.
	maxHitPoints whenChangedDo: aBlock
]

{ #category : #'protocol events' }
MudTalkMateriaMagica >> whenSpellPointsChangedDo: aBlock [
	currentSpellPoints whenChangedDo: aBlock.
	maxSpellPoints whenChangedDo: aBlock
]

{ #category : #'protocol events' }
MudTalkMateriaMagica >> whenStaminaChangedDo: aBlock [
	currentStamina whenChangedDo: aBlock.
	maxStamina whenChangedDo: aBlock
]
