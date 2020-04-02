Class {
	#name : 'TFCallEngine',
	#superclass : 'Object',
	#classVars : [
		'Default'
	],
	#category : 'TensorFlowApp'
}

{ #category : 'Defaults',
  #vaVisibility : 'private' }
TFCallEngine class >> default [
	"Answers the default calling engine
	 
	 Answers:
		<TFCallEngine>"

	^Default
]

{ #category : 'Defaults',
  #vaVisibility : 'private' }
TFCallEngine class >> default: aCallEngineClass [
	"Sets the default calling engine class
	 
	 Arguments:
		aCallEngineClass - <TFCallEngine class>"

	Default := aCallEngineClass
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFCallEngine class >> initializeAfterLoad [
	"The default calling engine is synchronous"

	self default: TFSynchronousCallEngine
]

{ #category : 'Creation' }
TFCallEngine class >> new [
	"Answer a new instance of this call engine
	 
	 Answers:
		<TFCallEngine>"

	^self basicNew initialize
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction [
	"Perform 0-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 [
	"Perform 1-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 [
	"Perform 2-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 [
	"Perform 3-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 [
	"Perform 4-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 [
	"Perform 5-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 [
	"Perform 6-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 [
	"Perform 7-arg call"

	self subclassResponsibility
]

{ #category : 'API',
 #vaCategories : ['API','Subclass Responsibility'] }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 [
	"Perform 8-arg call"

	self subclassResponsibility
]

{ #category : 'API' }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 [
	"Perform 9-arg call"

	self subclassResponsibility
]

{ #category : 'API' }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 [
	"Perform 10-arg call"

	self subclassResponsibility
]

{ #category : 'API' }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 [
	"Perform 11-arg call"

	self subclassResponsibility
]

{ #category : 'API' }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 [
	"Perform 12-arg call"

	self subclassResponsibility
]

{ #category : 'API' }
TFCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 with: arg13 [
	"Perform 13-arg call"

	self subclassResponsibility
]

{ #category : 'Initialize',
  #vaVisibility : 'private' }
TFCallEngine >> initialize [
	"Do nothing by default"


]

{ #category : 'Initialize',
  #vaVisibility : 'private' }
TFCallEngine >> release [
	"Subclasses should use this to release any resources"


]
