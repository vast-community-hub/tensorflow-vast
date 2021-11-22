Class {
	#name : 'TensorDataType',
	#superclass : 'Object',
	#classInstVars : [
		'singletons'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Instance Creation' }
TensorDataType class >> identifiedWith: aUniqueIdentifier [

	^(self subclasses detect: [:subclass | subclass new uniqueIdentifier = aUniqueIdentifier]) new
]

{ #category : 'Instance Creation' }
TensorDataType class >> new [

	singletons ifNil: [singletons := Dictionary new].
	^singletons at: self ifAbsentPut: [super new]
]

{ #category : 'accessing' }
TensorDataType >> = aDataType [

	^ self class = aDataType class
]

{ #category : 'accessing' }
TensorDataType >> dataSize [

	^TensorFlowCAPI current sizeOfDataType: self
]

{ #category : 'accessing' }
TensorDataType >> description [

	self subclassResponsibility
]

{ #category : 'accessing' }
TensorDataType >> getElementAt: anIndex in: anExternalAddressOrByteArray [

	
	self subclassResponsibility 
]

{ #category : 'accessing' }
TensorDataType >> hash [

	^self class hash
]

{ #category : 'accessing' }
TensorDataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	
	self subclassResponsibility 
]

{ #category : 'accessing' }
TensorDataType >> uniqueIdentifier [

	self subclassResponsibility
]
