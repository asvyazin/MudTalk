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

{ #category : #theme }
MudTalkClientWindow class >> theme [
	^ MudTalkClientTheme new
]

{ #category : #private }
MudTalkClientWindow >> inputPane [
	^ inputPane ifNil: [
		inputPane := self
			newBasicTextEditorFor: self model
			getText: #getInput
			setText: #setInput:.
		inputPane
			textColor: Color white;
			acceptOnCR: true;
			alwaysAccept: true;
			attachKeymapCategory: #MudTalkClientInputPane targetting: self model]
]

{ #category : #private }
MudTalkClientWindow >> inputPaneHeight [
	^ 75
]

{ #category : #keybindings }
MudTalkClientWindow >> keyStroke: evt [
	self eventHandler ifNotNil: [:eventHandler |
		(eventHandler keyStroke: evt fromMorph: self) ifTrue: [^true]].
	^ super keyStroke: evt
]

{ #category : #initialization }
MudTalkClientWindow >> model: aModel [
	super model: aModel.
	
	self
		addMorph: self outputPane
		fullFrame: ((0@0 corner: 1@1) asLayoutFrame bottomOffset: self inputPaneHeight negated);
		
		addMorph: self inputPane
		fullFrame: ((0@1 corner: 1@1) asLayoutFrame topOffset: self inputPaneHeight negated)
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
			setText: #setOutput:.
		outputPane textColor: Color white]
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
