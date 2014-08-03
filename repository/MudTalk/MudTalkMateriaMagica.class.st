Class {
	#name : #MudTalkMateriaMagica,
	#superclass : #MudTalkClient,
	#instVars : [
		'materiaMagicaWindow'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkMateriaMagica >> currentHitPoints: hp [ 
	materiaMagicaWindow currentHitPoints: hp
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentSpellPoints: sp [
	materiaMagicaWindow currentSpellPoints: sp
]

{ #category : #accessing }
MudTalkMateriaMagica >> currentStamina: st [
	materiaMagicaWindow currentStamina: st
]

{ #category : #initialization }
MudTalkMateriaMagica >> initialize [
	super initialize.
	self initializeGmcp.
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

{ #category : #private }
MudTalkMateriaMagica >> updateCharVitals: aMessage [ 
	self currentHitPoints: (aMessage at: #hp);
		currentSpellPoints: (aMessage at: #sp);
		currentStamina: (aMessage at: #st)
]
