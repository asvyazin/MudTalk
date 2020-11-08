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
		default: Character arrowUp asKeyCombination
		do: [ :target | target inputHistoryPrevious ].
	(aBuilder shortcut: #historyNext)
		category: #MudTalkClientInputPane
		default: Character arrowDown asKeyCombination
		do: [ :target |  target inputHistoryNext ]
]

{ #category : #theme }
MudTalkClientWindow class >> textFont [ 
	^ LogicalFont 
		familyName: 'Source Code Pro' 
		pointSize: StandardFonts defaultFont pointSize
]

{ #category : #private }
MudTalkClientWindow >> inputPane [
	^ inputPane ifNil: [
		inputPane := self
			newTextEditorFor: self model inputModel
			getText: self model inputGetTextSelector
			setText: self model inputSetTextSelector.
		inputPane announcer when: RubReturnEntered send: #whenReturnEntered: to: self.
		inputPane
			autoAccept: true;
			textFont: self class textFont;
			color: Color black;
			textColor: Color white;
			attachKeymapCategory: #MudTalkClientInputPane targetting: self model]
]

{ #category : #private }
MudTalkClientWindow >> inputPaneHeight [
	^ 75
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
			newTextEditorFor: self model outputModel
			getText: self model outputGetTextSelector
			setText: self model outputSetTextSelector.
		outputPane
			textFont: self class textFont;
			textColor: Color white;
			color: Color black ]
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

{ #category : #input }
MudTalkClientWindow >> whenReturnEntered: announcement [
	announcement accepted: true.
	self model processCurrentInput.
]
