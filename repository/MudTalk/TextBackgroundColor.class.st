Class {
	#name : #TextBackgroundColor,
	#superclass : #TextAttribute,
	#instVars : [
		'color'
	],
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
TextBackgroundColor class >> color: aColor [
	^ self new color: aColor
]

{ #category : #accessing }
TextBackgroundColor >> color [
	^ color
]

{ #category : #accessing }
TextBackgroundColor >> color: anObject [
	color := anObject
]

{ #category : #styling }
TextBackgroundColor >> emphasizeScanner: scanner [
	scanner textBackgroundColor: color
]
