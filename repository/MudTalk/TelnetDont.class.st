Class {
	#name : #TelnetDont,
	#superclass : #Object,
	#category : #MudTalk
}

{ #category : #events }
TelnetDont >> triggerOn: aEventSource [
	aEventSource triggerEvent: #dont: with: self option
]
