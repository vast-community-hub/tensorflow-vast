Class {
	#name : 'BooleanDataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
BooleanDataType >> description [

	^'Boolean'
]

{ #category : 'accessing' }
BooleanDataType >> getElementAt: anIndex in: aByteArray [

	^aByteArray bool8At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
BooleanDataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	^anExternalAddressOrByteArray bool8At: anIndex * self dataSize put: aValue
]

{ #category : 'accessing' }
BooleanDataType >> uniqueIdentifier [

	^ 10 
]
