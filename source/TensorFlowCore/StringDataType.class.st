Class {
	#name : 'StringDataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
StringDataType >> dataSize [
	" pointer to the tfstring "

	^24
]

{ #category : 'accessing' }
StringDataType >> description [

	^'String'
]

{ #category : 'accessing' }
StringDataType >> getElementAt: anIndex in: aByteArray [

	^TFString address: (aByteArray address + ((anIndex - 1) * self dataSize))
]

{ #category : 'accessing' }
StringDataType >> put: aString at: anIndex in: anExternalAddressOrByteArray [

	^TensorFlowCAPI current
		newStringOn:
			(OSPtr address: (anExternalAddressOrByteArray address + (anIndex * self dataSize)))
		with: aString
]

{ #category : 'accessing' }
StringDataType >> uniqueIdentifier [

	^7
]
