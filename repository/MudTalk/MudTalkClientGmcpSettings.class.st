Class {
	#name : #MudTalkClientGmcpSettings,
	#superclass : #Object,
	#instVars : [
		'enabledPackages',
		'messageClasses'
	],
	#category : #'MudTalk-Client'
}

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
	messageClasses := Dictionary new
]

{ #category : #messages }
MudTalkClientGmcpSettings >> messageFromData: aMessageData [
	^ (messageClasses at: aMessageData messageName)
		data: aMessageData
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessage: aMessageClass [
	self registerMessage: aMessageClass withName: aMessageClass messageName
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessage: aMessageClass withName: aMessageName [
	messageClasses at: aMessageName put: aMessageClass
]
