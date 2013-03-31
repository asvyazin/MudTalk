Class {
	#name : #TelnetOption,
	#superclass : #Object,
	#category : #MudTalk
}

{ #category : #constants }
TelnetOption class >> compress [
	^ 85.
]

{ #category : #constants }
TelnetOption class >> compress2 [
	^ 86.
]

{ #category : #constants }
TelnetOption class >> echo [
	^ 1
]

{ #category : #constants }
TelnetOption class >> eor [
	^ 25.
]

{ #category : #constants }
TelnetOption class >> ga [
	^ 249
]

{ #category : #constants }
TelnetOption class >> gmcp [
	^ 201.
]

{ #category : #constants }
TelnetOption class >> msp [
	^ 90.
]

{ #category : #constants }
TelnetOption class >> mssp [
	^ 70
]

{ #category : #constants }
TelnetOption class >> mxp [
	^ 91.
]

{ #category : #constants }
TelnetOption class >> naws [
	^ 31.
]

{ #category : #constants }
TelnetOption class >> suppressGoAhead [
	^ 3.
]

{ #category : #constants }
TelnetOption class >> terminalType [
	^ 24.
]
