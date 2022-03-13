Class {
	#name : 'FloatDataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
FloatDataType >> description [

	^'Float'
]

{ #category : 'accessing' }
FloatDataType >> getElementAt: anIndex in: aByteArray [

	^aByteArray float32At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
FloatDataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	^anExternalAddressOrByteArray float32At: anIndex * self dataSize put: aValue value asFloat
]

{ #category : 'accessing' }
FloatDataType >> uniqueIdentifier [

	^1
]
