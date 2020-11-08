Class {
	#name : #MudTalkClientTelnetEnabledCommandSetting,
	#superclass : #MudTalkClientTelnetCommandSetting,
	#instVars : [
		'handler'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientTelnetEnabledCommandSetting >> handler [
	^ handler
]

{ #category : #accessing }
MudTalkClientTelnetEnabledCommandSetting >> handler: aHandler [
	handler := aHandler
]

{ #category : #accessing }
MudTalkClientTelnetEnabledCommandSetting >> isEnabled [
	^ true
]
