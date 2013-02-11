Class {
	#name : #MudTalkClientTelnetSettings,
	#superclass : #Object,
	#instVars : [
		'handlers',
		'commands'
	],
	#category : #'MudTalk-Client'
}

{ #category : #'telnet commands' }
MudTalkClientTelnetSettings >> commandHandlerFor: aCommandCode ifEnabled: enabledAction ifAbsent: absentAction [
	self commands at: aCommandCode
		ifPresent: [ :setting | setting isEnabled ifTrue: [ enabledAction value: setting handler ] ]
		ifAbsent: [ absentAction value ]
]

{ #category : #'telnet commands' }
MudTalkClientTelnetSettings >> disableCommand: aCommandCode [
	commands at: aCommandCode put: MudTalkClientTelnetEnabledCommandSetting new
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> disableOption: anOption [
	self setHandler: MudTalkClientDisabledOptionHandler new for: anOption
]

{ #category : #'telnet commands' }
MudTalkClientTelnetSettings >> enableCommand: aCommandCode withHandler: aBlock [
	commands at: aCommandCode put: (MudTalkClientTelnetCommandSetting new handler: aBlock)
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
	handlers := Dictionary new.
	commands := Dictionary new
]

{ #category : #'telnet options' }
MudTalkClientTelnetSettings >> setHandler: aHandler for: anOption [
	handlers at: anOption put: aHandler
]
