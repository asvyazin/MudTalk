Class {
	#name : #TelnetToken,
	#superclass : #Object,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TelnetToken class >> option: anOption [ 
	^ self new option: anOption
]

{ #category : #comparing }
TelnetToken >> = anObject [ 
	^ anObject option = option
]

{ #category : #comparing }
TelnetToken >> hash [ 
	^ option hash
]

{ #category : #accessing }
TelnetToken >> option [
	^ option
]

{ #category : #accessing }
TelnetToken >> option: anOption [
	option := anOption
]
