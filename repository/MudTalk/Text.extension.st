Extension { #name : #Text }

{ #category : #'*MudTalk-Client' }
Text >> addAttributes: attributes [
	attributes do: [ :attribute | self addAttribute: attribute ]
]
