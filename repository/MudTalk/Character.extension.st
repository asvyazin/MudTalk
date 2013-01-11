Extension { #name : #Character }

{ #category : #'*MudTalk' }
Character >> asTelnetCharacter [
	^ TelnetCharacter new value: self.
]
