Class {
	#name : #MudTalkClientTheme,
	#superclass : #UITheme,
	#category : #'MudTalk-Client'
}

{ #category : #fonts }
MudTalkClientTheme class >> fixedWidthFontFamily [
	^ LogicalFontManager current fixedWidthFamilies first familyName
]

{ #category : #initialization }
MudTalkClientTheme class >> initialize [
	"self initialize"
	FreeTypeFontProvider current loadFromSystem
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
		familyName: (self class fixedWidthFontFamily)
		pointSize: self class fontSize
]
