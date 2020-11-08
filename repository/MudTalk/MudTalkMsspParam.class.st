Class {
	#name : #MudTalkMsspParam,
	#superclass : #Object,
	#instVars : [
		'name',
		'values'
	],
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkMsspParam >> name [
	^ name
]

{ #category : #initialization }
MudTalkMsspParam >> name: paramName values: paramValues [ 
	name := paramName.
	values := paramValues
]

{ #category : #accessing }
MudTalkMsspParam >> values [
	^ values
]
