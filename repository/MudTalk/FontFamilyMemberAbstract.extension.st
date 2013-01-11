Extension { #name : #FontFamilyMemberAbstract }

{ #category : #'*MudTalk-Client' }
FontFamilyMemberAbstract >> isFixedWidth [
	^ (self respondsTo: #fileInfo) ifFalse: [ false ]
		ifTrue: [ self fileInfo fixedWidth ]
]
