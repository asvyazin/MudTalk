Class {
	#name : #TelnetTextEvent,
	#superclass : #TelnetEvent,
	#instVars : [
		'text'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetTextEvent class >> text: aText [
	^ self new text: aText
]

{ #category : #comparing }
TelnetTextEvent >> = anObject [
	^ anObject text = text
]

{ #category : #comparing }
TelnetTextEvent >> hash [
	^ text hash
]

{ #category : #accessing }
TelnetTextEvent >> text [
	^ text
]

{ #category : #accessing }
TelnetTextEvent >> text: aText [
	text := aText
]
