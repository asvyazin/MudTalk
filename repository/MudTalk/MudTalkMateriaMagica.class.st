Class {
	#name : #MudTalkMateriaMagica,
	#superclass : #MudTalkClient,
	#category : #'MudTalk-Client'
}

{ #category : #initialization }
MudTalkMateriaMagica >> initialize [
	super initialize.
	self openWindowOnHost: 'materiamagica.com' port: 4000
]
