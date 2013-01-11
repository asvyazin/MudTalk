Class {
	#name : #TelnetSubnego,
	#superclass : #Object,
	#instVars : [
		'option',
		'data'
	],
	#category : #MudTalk
}

{ #category : #'instance creation' }
TelnetSubnego class >> option: anOption data: aByteString [
	^ self new option: anOption data: aByteString
]

{ #category : #accessing }
TelnetSubnego >> data [
	^ data
]

{ #category : #initialization }
TelnetSubnego >> option [
	^ option
]

{ #category : #events }
TelnetSubnego >> option: anOption data: aByteString [
	option := anOption.
	data := aByteString.
]

{ #category : #accessing }
TelnetSubnego >> triggerOn: aEventSource [
	aEventSource triggerEvent: #subnego:data: withArguments: {self option. self data}
]
