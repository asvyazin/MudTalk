Class {
	#name : #MudTalkClientGmcpSettings,
	#superclass : #Object,
	#instVars : [
		'enabledPackages',
		'messageClasses',
		'defaultMessageClass'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientGmcpSettings >> defaultMessageClass [
	^ defaultMessageClass
]

{ #category : #accessing }
MudTalkClientGmcpSettings >> defaultMessageClass: aClass [
	defaultMessageClass := aClass
]

{ #category : #packages }
MudTalkClientGmcpSettings >> enablePackage: packageName [
	self enablePackage: packageName version: '1'
]

{ #category : #packages }
MudTalkClientGmcpSettings >> enablePackage: packageName version: packageVersion [
	enabledPackages add: (packageName, ' ', packageVersion)
]

{ #category : #packages }
MudTalkClientGmcpSettings >> enabledPackages [
	^ enabledPackages
]

{ #category : #initialization }
MudTalkClientGmcpSettings >> initialize [
	super initialize.
	enabledPackages := OrderedCollection new.
	messageClasses := Dictionary new.
	defaultMessageClass := MudTalkGmcpMessage
]

{ #category : #messages }
MudTalkClientGmcpSettings >> messageClassByName: aMessageName [
	^ messageClasses at: aMessageName ifAbsent: [ ^ self defaultMessageClass ]
]

{ #category : #messages }
MudTalkClientGmcpSettings >> messageFromData: aMessageData [
	^ (self messageClassByName: aMessageData messageName) new
		data: aMessageData;
		yourself
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessage: aMessageName withClass: aMessageClass [
	messageClasses at: aMessageName put: aMessageClass
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessageClass: aMessageClass [
	self registerMessage: aMessageClass messageName withClass: aMessageClass
]
