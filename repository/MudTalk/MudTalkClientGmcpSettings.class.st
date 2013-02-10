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
	self enabledPackages add: (packageName, ' ', packageVersion)
]

{ #category : #packages }
MudTalkClientGmcpSettings >> enabledPackages [
	^ enabledPackages ifNil: [ enabledPackages := OrderedCollection new ]
]

{ #category : #accessing }
MudTalkClientGmcpSettings >> messageClasses [
	^ messageClasses ifNil: [ messageClasses := Dictionary new ]
]

{ #category : #messages }
MudTalkClientGmcpSettings >> messageFromData: aMessageData [
	^ (self messageClasses at: aMessageData messageName) data: aMessageData
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessage: aMessageClass [
	self registerMessage: aMessageClass withName: aMessageClass messageName
]

{ #category : #messages }
MudTalkClientGmcpSettings >> registerMessage: aMessageClass withName: aMessageName [
	self messageClasses at: aMessageName put: aMessageClass
]
