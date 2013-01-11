Class {
	#name : #TelnetText,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #MudTalk
}

{ #category : #'instance creation' }
TelnetText class >> on: aCollection from: start to: stop [
	^ self new on: aCollection from: start to: stop
]

{ #category : #accessing }
TelnetText >> collection [
	^ collection
]

{ #category : #events }
TelnetText >> on: aCollection from: start to: stop [ 
	collection := aCollection copyFrom: start to: stop
]

{ #category : #initialization }
TelnetText >> triggerOn: anEventSource [
	anEventSource triggerEvent: #text: with: (String withAll: self collection)
]
