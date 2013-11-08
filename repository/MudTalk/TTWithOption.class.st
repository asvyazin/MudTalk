Class {
	#name : #TTWithOption,
	#superclass : #TelnetToken,
	#instVars : [
		'option'
	],
	#category : #MudTalk
}

{ #category : #initialization }
TTWithOption class >> option: anOption [
	^ self new option: anOption
]

{ #category : #comparing }
TTWithOption >> = anObject [
	^ (anObject class = self class) and: (anObject option = option)
]

{ #category : #comparing }
TTWithOption >> hash [
	^ option hash
]

{ #category : #accessing }
TTWithOption >> option [
	^ option
]

{ #category : #initialization }
TTWithOption >> option: anOption [
	option := anOption
]
