Class {
	#name : #MudServer,
	#superclass : #Object,
	#instVars : [
		'started'
	],
	#category : #MudTalk
}

{ #category : #'initialize-release' }
MudServer >> initialize [
	started := false.
]

{ #category : #state }
MudServer >> isStarted [
	^ started.
]

{ #category : #state }
MudServer >> isStopped [
	^ started not.
]

{ #category : #'start-stop' }
MudServer >> start [
	started := true.
]

{ #category : #'start-stop' }
MudServer >> stop [
	started := false.
]
