Class {
	#name : #ManifestMudTalk,
	#superclass : #Object,
	#category : #MudTalk
}

{ #category : #'meta data' }
ManifestMudTalk class >> rejectClasses [
^ #()
]

{ #category : #'meta data' }
ManifestMudTalk class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleConsistencyCheckRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#MudTalkClientMsspHandler #msspParam #false)) #'2013-01-25T22:10:30.109000001+06:00') #(#(#RGMethodDefinition #(#TelnetWontToken #triggerOn: #false)) #'2013-01-25T22:10:39.239+06:00') #(#(#RGMethodDefinition #(#MudTalkClientTheme #fixedWidthFontFamily #false)) #'2013-01-25T22:10:47.957+06:00') #(#(#RGMethodDefinition #(#TelnetDontToken #triggerOn: #false)) #'2013-01-25T22:10:55.994+06:00') #(#(#RGMethodDefinition #(#TelnetWillToken #triggerOn: #false)) #'2013-01-25T22:11:05.812+06:00') #(#(#RGMethodDefinition #(#TelnetDoToken #triggerOn: #false)) #'2013-01-25T22:11:13.811+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleGuardClauseRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#MudTalkClientMsspHandler #subnego:data: #false)) #'2013-01-25T22:07:34.771000001+06:00') #(#(#RGMethodDefinition #(#MudTalkClientTerminalTypeHandler #will: #false)) #'2013-01-25T22:08:15.135+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleIfTrueBlocksRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#MudTalkClientKey #matchEvent: #false)) #'2013-01-25T21:47:31.026+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleMissingYourselfRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#MudTalkClient #unknownCommand: #false)) #'2013-01-25T21:49:58.482000006+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleRefersToClassRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#TelnetStream #initialize #false)) #'2013-01-25T21:53:57.397000001+06:00') #(#(#RGMethodDefinition #(#TelnetStream #iacNext #false)) #'2013-01-25T21:54:14.794+06:00') #(#(#RGMethodDefinition #(#TelnetStream #iacSbNext #false)) #'2013-01-25T21:54:25.556+06:00') #(#(#RGMethodDefinition #(#TelnetStream #next #false)) #'2013-01-25T21:54:35.983+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #parser #true)) #'2013-01-25T21:54:57.06+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #subnego #true)) #'2013-01-25T21:55:13.311+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #ip #true)) #'2013-01-25T21:55:29.312+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #sb #true)) #'2013-01-25T21:55:44.187+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #text #true)) #'2013-01-25T21:56:01.04+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #ao #true)) #'2013-01-25T21:56:19.432+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #eor #true)) #'2013-01-25T21:56:30.98+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #ayt #true)) #'2013-01-25T21:56:43.037+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #ga #true)) #'2013-01-25T21:56:57.81+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #iac #true)) #'2013-01-25T21:57:05.33+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #brk #true)) #'2013-01-25T21:57:18.613+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #el #true)) #'2013-01-25T21:57:31.08+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #will #true)) #'2013-01-25T21:57:46.408+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #se #true)) #'2013-01-25T21:57:58.729+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #iaciac #true)) #'2013-01-25T21:58:13.811+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #ec #true)) #'2013-01-25T21:58:26.094+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #normalChar #true)) #'2013-01-25T21:58:36.572+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #eorDelimiter #true)) #'2013-01-25T21:58:48.779+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #special #true)) #'2013-01-25T21:59:38.3+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #nop #true)) #'2013-01-25T21:59:54.474+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #dm #true)) #'2013-01-25T22:00:08.317+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #do #true)) #'2013-01-25T22:00:22.949+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #dont #true)) #'2013-01-25T22:00:36.661+06:00') #(#(#RGMethodDefinition #(#'TelnetParser class' #wont #true)) #'2013-01-25T22:00:50.909+06:00') #(#(#RGMethodDefinition #(#'TelnetStream class' #subnegoEnd #true)) #'2013-01-25T22:01:03.837+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleSentNotImplementedRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#TelnetStream #iacNext #false)) #'2013-01-25T21:34:40.886000004+06:00') )
]

{ #category : #'meta data' }
ManifestMudTalk class >> ruleVariableReferencedOnceRuleV1TruePositive [
^ #(#(#(#RGMethodDefinition #(#MudTalkConnectionToServer #connectTo:port: #false)) #'2013-01-25T22:02:39.597+06:00') )
]
