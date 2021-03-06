Class {
	#name : #ConfigurationOfMudTalk,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfMudTalk
}

{ #category : #'development support' }
ConfigurationOfMudTalk class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfMudTalk class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfMudTalk class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfMudTalk class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMudTalk class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMudTalk class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfMudTalk class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfMudTalk class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfMudTalk class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfMudTalk class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfMudTalk >> baseline01: spec [
	<version: '0.1-baseline'>
	spec for: #pharo do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/AlexanderSvyazin/MudTalk/main'.
		spec project: 'PetitParser Core' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				versionString: '1.6-baseline';
				loads: #('Core');
				repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main'].
		spec project: 'NeoJSON Core' with: [
			spec
				className: 'ConfigurationOfNeoJSON';
				versionString: #stable;
				loads: #('Core');
				repository: 'github://svenvc/NeoJSON:master/repository'].
		spec project: 'BabyMock Core' with: [
			spec
				className: 'ConfigurationOfBabyMock';
				versionString: '1.2-baseline';
				loads: #('Core');
				repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main'].
		spec package: 'MudTalk' with: [ spec requires: #('PetitParser Core' 'NeoJSON Core' 'BabyMock Core')]]
]

{ #category : #accessing }
ConfigurationOfMudTalk >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfMudTalk >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'
]

{ #category : #accessing }
ConfigurationOfMudTalk >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]
