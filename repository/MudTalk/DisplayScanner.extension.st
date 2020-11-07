Extension { #name : #DisplayScanner }

{ #category : #'*MudTalk-Client' }
DisplayScanner >> textBackgroundColor: textColor [
	ignoreColorChanges ifTrue: [^ self].
	backgroundColor := textColor
]
