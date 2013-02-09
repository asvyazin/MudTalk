Class {
	#name : #MudTalkGmcpCoreSupportsSet,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'supportedPackages'
	],
	#category : #'MudTalk-Client'
}

{ #category : #gmcp }
MudTalkGmcpCoreSupportsSet >> bodyOn: jsonWriter [
	jsonWriter nextPut: supportedPackages
]

{ #category : #initialization }
MudTalkGmcpCoreSupportsSet >> initialize [
	super initialize.
	supportedPackages := OrderedCollection new
]

{ #category : #accessing }
MudTalkGmcpCoreSupportsSet >> name [
	^ 'Core.Supports.Set'
]

{ #category : #accessing }
MudTalkGmcpCoreSupportsSet >> package: packageName version: packageVersion [
	supportedPackages add: packageName, ' ', packageVersion
]
