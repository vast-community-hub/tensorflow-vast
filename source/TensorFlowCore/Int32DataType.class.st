Class {
	#name : 'Int32DataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
Int32DataType >> description [

	^'Int32'
]

{ #category : 'accessing' }
Int32DataType >> getElementAt: anIndex in: aByteArray [

	^aByteArray int32At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
Int32DataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	^anExternalAddressOrByteArray int32At: anIndex * self dataSize put: aValue
]

{ #category : 'accessing' }
Int32DataType >> uniqueIdentifier [

	^3
]
