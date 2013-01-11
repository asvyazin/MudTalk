Class {
	#name : #TelnetCommand,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #MudTalk
}

{ #category : #constants }
TelnetCommand class >> GA [
	^ 249
]

{ #category : #'instance creation' }
TelnetCommand class >> value: aCommand [ 
	^ self new value: aCommand
]

{ #category : #events }
TelnetCommand >> triggerOn: aEventSource [
	aEventSource triggerEvent: #command: with: self value
]

{ #category : #accessing }
TelnetCommand >> value [
	^ value
]

{ #category : #initialize }
TelnetCommand >> value: aCommand [ 
	value := aCommand
]
