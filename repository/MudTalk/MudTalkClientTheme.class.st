Class {
	#name : #MudTalkClientTheme,
	#superclass : #PharoTheme,
	#category : #'MudTalk-Client'
}

{ #category : #'class initialization' }
MudTalkClientTheme class >> initialize [
	"self initialize"
	FreeTypeFontProvider current loadFromSystem
]

{ #category : #fonts }
MudTalkClientTheme >> fixedWidthFontFamily [
	^ LogicalFontManager current fixedWidthFamilies first familyName
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
	^ LogicalFont
		familyName: (self fixedWidthFontFamily)
		pointSize: self fontSize
]
