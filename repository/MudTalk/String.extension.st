Extension { #name : #String }

{ #category : #'*MudTalk-Client' }
String >> isClientSideCommand [
	^ (self isNotEmpty) and: [ (self first) = $/ ]
]
