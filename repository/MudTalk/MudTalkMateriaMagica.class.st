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

{ #category : #initialization }
MudTalkMateriaMagica >> grabMaxVitals [
	self traceCr: 'grabbing max vitals'.
	(self
		triggerRegex: '[0-9]+\% [0-9]+ \/ ([0-9]+) HP\.'
		do: [ :m | self maxHitPoints: (m subexpression: 2) asInteger ])
		oneTime: true.
	self send: 'score hp'.
	
	(self
		triggerRegex: '[0-9]+\% [0-9]+ \/ ([0-9]+) SP\.'
		do: [ :m | self maxSpellPoints: (m subexpression: 2) asInteger ])
		oneTime: true.
	self send: 'score sp'.
	
	(self
		triggerRegex: '[0-9]+\% [0-9]+ \/ ([0-9]+) ST\.'
		do: [ :m | self maxStamina: (m subexpression: 2) asInteger ])
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
		triggerRegex: '<(.+)hp(.+)sp(.+)st>$'
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
