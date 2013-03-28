Extension { #name : #PPPredicateObjectParser }

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> anyCharacter [
	^ self on: [ :token | token isCharacter ] message: 'Character expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetCommand [
	^ self on: [ :token | token isTelnetCommand ] message: 'telnet command expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetDo [
	^ self on: [ :token | token isTelnetDo ] message: 'telnet DO expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetDont [
	^ self on: [ :token | token isTelnetDont ] message: 'telnet DONT expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetSubnego [
	^ self on: [ :token | token isTelnetSubnego ] message: 'telnet SUBNEGO expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetWill [
	^ self on: [ :token | token isTelnetWill ] message: 'telnet WILL expected'
]

{ #category : #'*MudTalk-Parsers' }
PPPredicateObjectParser class >> telnetWont [
	^ self on: [ :token | token isTelnetWont ] message: 'telnet WONT expected'
]
