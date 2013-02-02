Extension { #name : #Symbol }

{ #category : #'*MudTalk-Client' }
Symbol >> asKey [
	^ MudTalkClientKey perform: self
]
