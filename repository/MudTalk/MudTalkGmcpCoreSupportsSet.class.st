Class {
	#name : #MudTalkGmcpCoreSupportsSet,
	#superclass : #MudTalkGmcpMessage,
	#instVars : [
		'supportedPackages'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkGmcpCoreSupportsSet class >> messageName [
	^ 'Core.Supports.Set'
]

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
MudTalkGmcpCoreSupportsSet >> package: packageName version: packageVersion [
	supportedPackages add: packageName, ' ', packageVersion
]

{ #category : #accessing }
MudTalkGmcpCoreSupportsSet >> packages: packagesCollection [
	supportedPackages := packagesCollection
]
