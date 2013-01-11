Class {
	#name : #MudServerTests,
	#superclass : #TestCase,
	#category : #'MudTalk-Tests'
}

{ #category : #tests }
MudServerTests >> testStartStop [
	|server|
	server := MudServer new.
	server start.
	self should: [server isStarted].
	self shouldnt: [server isStopped].
	server stop.
	self should: [server isStopped].
	self shouldnt: [server isStarted].
]

{ #category : #tests }
MudServerTests >> testState [
	|server|
	server := MudServer new.
	self should: [server isStopped].
	self shouldnt: [server isStarted].
]
