Class {
	#name : #TelnetOptionEvent,
	#superclass : #TelnetEvent,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #comparing }
TelnetOptionEvent >> = anObject [ 
	^ anObject option = option
]

{ #category : #comparing }
TelnetOptionEvent >> hash [ 
	^ option hash
]

{ #category : #accessing }
TelnetOptionEvent >> option [
	^ option
]

{ #category : #accessing }
TelnetOptionEvent >> option: anOption [
	option := anOption
]
