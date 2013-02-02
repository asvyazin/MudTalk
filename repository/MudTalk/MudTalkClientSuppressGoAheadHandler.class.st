Class {
	#name : #MudTalkClientSuppressGoAheadHandler,
	#superclass : #MudTalkClientEnabledOptionHandler,
	#category : #'MudTalk-Client'
}

{ #category : #accessing }
MudTalkClientSuppressGoAheadHandler >> client: aClient [
	aClient commandHandlers at: TelnetCommand GA put: [ :command | self ga ]
]

{ #category : #telnet }
MudTalkClientSuppressGoAheadHandler >> ga [
	self traceCr: 'GA command received'
]
