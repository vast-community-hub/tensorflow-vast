Extension {
	#name : 'Object'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['ANSI-API'] }
Object >> isA: aClass [

	"Answer a Boolean which is true if aClass, is the class or
	 a superclass of the receiver, and false otherwise."

	^(self isMemberOf: aClass) or: [self class inheritsFrom: aClass]
]
