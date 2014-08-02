Class {
	#name : #MudTalkClientTheme,
	#superclass : #Pharo3Theme,
	#category : #'MudTalk-Client'
}

{ #category : #fonts }
MudTalkClientTheme class >> fixedWidthFontFamily [
	^ LogicalFontManager current fixedWidthFamilies first familyName
]

{ #category : #fonts }
MudTalkClientTheme class >> fontSize [
	^ 10
]

{ #category : #initialization }
MudTalkClientTheme class >> initialize [
	"self initialize"
	FreeTypeFontProvider current loadFromSystem
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
