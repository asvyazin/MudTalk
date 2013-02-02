Class {
	#name : #MudTalkClientTelnetSettings,
	#superclass : #Object,
	#instVars : [
		'handlers'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> disableOption: anOption [
	self setHandler: MudTalkClientDisabledOptionHandler new for: anOption
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> enableOption: anOption withHandler: handler [
	self setHandler: handler for: anOption
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> handlerFor: anOption [ 
	handlers at: anOption
		ifPresent: [:handler | ^handler]
		ifAbsent: [^nil]

]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> ifOption: anOption unknown: unknownBlock disabled: disabledBlock ignored: ignoredBlock enabled: enabledBlock [
	(self handlerFor: anOption)
		ifNil: [^unknownBlock value];
		ifDisabled: [^disabledBlock value];
		ifIgnored: [^ignoredBlock value];
		ifEnabled: enabledBlock
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> ignoreOption: anOption [
	self setHandler: MudTalkClientIgnoredOptionHandler new for: anOption
]

{ #category : #initialization }
MudTalkClientTelnetSettings >> initialize [
	super initialize.
	handlers := Dictionary new
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> setHandler: aHandler for: anOption [
	handlers at: anOption put: aHandler
]
