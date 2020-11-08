Extension { #name : #Collection }

{ #category : #'*MudTalk' }
Collection >> matchesMudTalkKeyBinding: aMudTalkClientKey [ 
	^ self allSatisfy: [ :each | each matchesMudTalkKeyBinding: aMudTalkClientKey ]
]
