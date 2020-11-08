Extension { #name : #LogicalFontManager }

{ #category : #'*MudTalk-Client' }
LogicalFontManager >> fixedWidthFamilies [
	^ self allFamilies select: [ :family |
		family members allSatisfy: [ :member | member isFixedWidth ] ].
]
