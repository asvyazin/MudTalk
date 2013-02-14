Class {
	#name : #MudTalkClientWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'inputPane',
		'outputPane'
	],
	#category : #'MudTalk-Client'
}

{ #category : #keymap }
MudTalkClientWindow class >> buildKeymap: aBuilder [
	<keymap>
	(aBuilder shortcut: #historyPrevious)
		category: #MudTalkClientInputPane
		default: Character arrowUp asShortcut
		do: [ :target | target inputHistoryPrevious ].
	(aBuilder shortcut: #historyNext)
		category: #MudTalkClientInputPane
		default: Character arrowDown asShortcut
		do: [ :target |  target inputHistoryNext ]
]

{ #category : #private }
MudTalkClientWindow >> inputPane [
	^ inputPane ifNil: [
		inputPane := self newBasicTextEditorFor: self model getText: #getInput setText: #setInput:.
		inputPane textColor: Color white;
			acceptOnCR: true;
			alwaysAccept: true;
			attachKeymapCategory: #MudTalkClientInputPane targetting: self model ]
]

{ #category : #keybindings }
MudTalkClientWindow >> keyStroke: evt [
	self eventHandler ifNotNil: [:eventHandler |
		(eventHandler keyStroke: evt fromMorph: self) ifTrue: [^true]].
	^ super keyStroke: evt
]

{ #category : #initialization }
MudTalkClientWindow >> on: aModel [
	self
		model: aModel;
		setLabel: 'MUD client';
		theme: MudTalkClientTheme new;
		
		addMorph: self outputPane
		fullFrame: (LayoutFrame fractions: (0@0 extent: 1@0.75));
		
		addMorph: self inputPane
		fullFrame: (LayoutFrame fractions: (0@0.75 extent: 1@1))
]

{ #category : #initialization }
MudTalkClientWindow >> openInWorld [
	super openInWorld.
	self inputPane takeKeyboardFocus
]

{ #category : #private }
MudTalkClientWindow >> outputPane [
	^ outputPane ifNil: [
		outputPane := self
			newBasicTextEditorFor: self model
			getText: #getOutput
			setText: #setOutput:;
			textColor: Color white;
			yourself]
]

{ #category : #output }
MudTalkClientWindow >> outputText: aText [
	self outputPane appendText: aText
]

{ #category : #output }
MudTalkClientWindow >> outputText: aText withAttributes: attributes [
	| textCopy |
	textCopy := aText copy.
	attributes do: [:attr | textCopy addAttribute: attr].
	self outputText: textCopy
]
