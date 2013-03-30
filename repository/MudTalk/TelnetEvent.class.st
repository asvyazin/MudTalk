Class {
	#name : #TelnetEvent,
	#superclass : #Announcement,
	#category : #MudTalk
}

{ #category : #initialization }
TelnetEvent class >> option: anOption [ 
	^ self new option: anOption
]
