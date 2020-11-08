Extension { #name : #KeyboardEvent }

{ #category : #'*MudTalk' }
KeyboardEvent >> matchesMudTalkKeyBinding: aMudTalkClientKey [ 
	^ (self keyValue = aMudTalkClientKey keyValue) and:
		(self scanCode = aMudTalkClientKey scanCode)
]
