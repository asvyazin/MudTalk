Class {
	#name : #LabeledText,
	#superclass : #ComposableModel,
	#instVars : [
		'label',
		'text'
	],
	#category : #'MudTalk-Client'
}

{ #category : #specs }
LabeledText class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | row add: #label;
			add: #text ];
		yourself
]

{ #category : #initialization }
LabeledText >> initializeWidgets [
	label := self newLabel.
	text := self newLabel
]

{ #category : #accessing }
LabeledText >> label [
	^ label
]

{ #category : #accessing }
LabeledText >> label: aLabel [
	label label: (aLabel,':')
]

{ #category : #accessing }
LabeledText >> text [
	^ text
]

{ #category : #accessing }
LabeledText >> text: aText [
	text label: aText
]
