Class {
	#name : #MudTalkClientMsspHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#instVars : [
		'events'
	],
	#category : #'MudTalk-Client'
}

{ #category : #parsing }
MudTalkClientMsspHandler class >> MSSP_VAL [
	^ Character value: 2
]

{ #category : #parsing }
MudTalkClientMsspHandler class >> MSSP_VAR [
	^ Character value: 1
]

{ #category : #parsing }
MudTalkClientMsspHandler >> anyChar [
	^ PPPredicateObjectParser anyExceptAnyOf: {self class MSSP_VAR. self class MSSP_VAL}
]

{ #category : #accessing }
MudTalkClientMsspHandler >> events [
	^ events
]

{ #category : #initialization }
MudTalkClientMsspHandler >> initialize [
	super initialize.
	events := EventManager new
]

{ #category : #parsing }
MudTalkClientMsspHandler >> makeMsspParam: paramName value: paramValues [
	^ MudTalkMsspParam new name: paramName values: paramValues
]

{ #category : #parsing }
MudTalkClientMsspHandler >> msspParam [
	^ self msspVar, (self msspVal star) ==> [:tokens |
		self makeMsspParam: (tokens first) value: (tokens second)]
]

{ #category : #parsing }
MudTalkClientMsspHandler >> msspParser [
	^ self msspParam star end
]

{ #category : #parsing }
MudTalkClientMsspHandler >> msspVal [
	^ self class MSSP_VAL asParser, (self anyChar star flatten) ==> #second
]

{ #category : #parsing }
MudTalkClientMsspHandler >> msspVar [
	^ self class MSSP_VAR asParser, (self anyChar plus flatten) ==> #second
]

{ #category : #accessing }
MudTalkClientMsspHandler >> params: paramsCollection [
	events triggerEvent: #msspParams: with: paramsCollection
]

{ #category : #telnet }
MudTalkClientMsspHandler >> subnego: anOption data: msspData from: server [
	| tokens |
	tokens := self msspParser parse: msspData.
	self params: tokens
]
