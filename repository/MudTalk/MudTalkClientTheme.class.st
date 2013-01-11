Class {
	#name : #MudTalkClientTheme,
	#superclass : #PharoTheme,
	#category : #'MudTalk-Client'
}

{ #category : #fonts }
MudTalkClientTheme >> fixedWidthFontFamily [
	^ (LogicalFontManager current fixedWidthFamilies at: 1) familyName
]

{ #category : #fonts }
MudTalkClientTheme >> fontSize [
	^ 10
]

{ #category : #'fill-styles' }
MudTalkClientTheme >> textEditorNormalFillStyleFor: aTextEditor [
	^ Color black
]

{ #category : #fonts }
MudTalkClientTheme >> textFont [
	^ LogicalFont familyName: (self fixedWidthFontFamily) pointSize: self fontSize
]
