Class {
	#name : #MudTalkClientSuppressGoAheadHandler,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#category : #'MudTalk-Client'
}

{ #category : #telnet }
MudTalkClientSuppressGoAheadHandler >> ga [
	self traceCr: 'GA command received'
]

{ #category : #initialization }
MudTalkClientSuppressGoAheadHandler >> server [
	^ server.
]

{ #category : #accessing }
MudTalkClientSuppressGoAheadHandler >> server: aConnection client: aClient [
	server := aConnection.
	aClient commandHandlers at: TelnetCommand GA put: [ :command | self ga ]
]

{ #category : #telnet }
MudTalkClientSuppressGoAheadHandler >> will: option [ 
	(option = TelnetOption suppressGoAhead) ifTrue: [ self server do: TelnetOption suppressGoAhead ]
]
