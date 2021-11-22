Class {
	#name : 'DoubleDataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
DoubleDataType >> description [

	^'Double'
]

{ #category : 'accessing' }
DoubleDataType >> getElementAt: anIndex in: aByteArray [

	^aByteArray float64At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
DoubleDataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	^anExternalAddressOrByteArray float64At: anIndex * self dataSize put: aValue
]

{ #category : 'accessing' }
DoubleDataType >> uniqueIdentifier [

	^2
]
