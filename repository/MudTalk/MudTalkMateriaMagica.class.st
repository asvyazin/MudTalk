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
MudTalkMateriaMagica >> currentHitPoints: hp [
	currentHitPoints := hp.
	materiaMagicaWindow hp: currentHitPoints maxHp: maxHitPoints
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentSpellPoints: sp [
	currentSpellPoints := sp.
	materiaMagicaWindow sp: currentSpellPoints maxSp: maxSpellPoints
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentStamina: st [
	currentStamina := st.
	materiaMagicaWindow st: currentStamina maxSt: maxStamina
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
	self initializeGmcp.
	self initializeTriggers.
	materiaMagicaWindow := MudTalkMateriaMagicaWindow new.
	materiaMagicaWindow openWithSpec.
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
MudTalkMateriaMagica >> maxHitPoints: anInteger [
	maxHitPoints := anInteger.
	materiaMagicaWindow hp: currentHitPoints maxHp: maxHitPoints
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxSpellPoints: anInteger [
	maxSpellPoints := anInteger.
	materiaMagicaWindow sp: currentSpellPoints maxSp: maxSpellPoints
]

{ #category : #accessing }
MudTalkMateriaMagica >> maxStamina: anInteger [
	maxStamina := anInteger.
	materiaMagicaWindow st: currentStamina maxSt: maxStamina
]

{ #category : #private }
MudTalkMateriaMagica >> updateCharVitals: aMessage [ 
	self currentHitPoints: (aMessage at: #hp);
		currentSpellPoints: (aMessage at: #sp);
		currentStamina: (aMessage at: #st)
]
