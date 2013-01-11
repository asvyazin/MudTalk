Class {
	#name : #TelnetCharBuffer,
	#superclass : #Object,
	#instVars : [
		'position',
		'buffer'
	],
	#category : #MudTalk
}

{ #category : #writing }
TelnetCharBuffer >> add: aCharacter [ 
	buffer at: position put: aCharacter.
	position := position + 1
]

{ #category : #accessing }
TelnetCharBuffer >> clear [
	| savedPosition |
	savedPosition := position - 1.
	position := 1.
	^ TelnetText on: buffer from: 1 to: savedPosition
]

{ #category : #initialization }
TelnetCharBuffer >> initialize [
	buffer := Array new: self size.
	position := 1.
]

{ #category : #accessing }
TelnetCharBuffer >> isEmpty [
	^ position = 1
]

{ #category : #accessing }
TelnetCharBuffer >> isFull [
	^ position > self size
]

{ #category : #accessing }
TelnetCharBuffer >> size [
	^ 4096
]
