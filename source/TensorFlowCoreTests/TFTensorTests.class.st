Class {
	#name : 'TFTensorTests',
	#superclass : 'TestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'tests' }
TFTensorTests >> testTypeDescriptions [


	self assert: ( TFTensor descriptionOf: 1 ) equals: 'Float'.
	self assert: ( TFTensor descriptionOf: 2 ) equals: 'Double'.
	self assert: ( TFTensor descriptionOf: 3 ) equals: 'Int32'.
	self assert: ( TFTensor descriptionOf: 4 ) equals: 'Uint8'.
	self assert: ( TFTensor descriptionOf: 5 ) equals: 'Int16'.
	self assert: ( TFTensor descriptionOf: 6 ) equals: 'Int8'.
	self assert: ( TFTensor descriptionOf: 7 ) equals: 'String'.
	self assert: ( TFTensor descriptionOf: 8 ) equals: 'Complex64'.
	self assert: ( TFTensor descriptionOf: 9 ) equals: 'Int64'.
	self assert: ( TFTensor descriptionOf: 10 ) equals: 'Bool'.
	self assert: ( TFTensor descriptionOf: 11 ) equals: 'QInt8'.
	self assert: ( TFTensor descriptionOf: 12 ) equals: 'QUInt8'.
	self assert: ( TFTensor descriptionOf: 13 ) equals: 'QInt32'.
	self assert: ( TFTensor descriptionOf: 14 ) equals: 'BFloat16'.
	self assert: ( TFTensor descriptionOf: 15 ) equals: 'QInt16'.
	self assert: ( TFTensor descriptionOf: 16 ) equals: 'QUInt16'.
	self assert: ( TFTensor descriptionOf: 17 ) equals: 'UInt16'.
	self assert: ( TFTensor descriptionOf: 18 ) equals: 'Complex128'.
	self assert: ( TFTensor descriptionOf: 19 ) equals: 'Half'.
	self assert: ( TFTensor descriptionOf: 20 ) equals: 'Resource'.
	self assert: ( TFTensor descriptionOf: 21 ) equals: 'Variant'.
	self assert: ( TFTensor descriptionOf: 22 ) equals: 'Uint32'.
	self assert: ( TFTensor descriptionOf: 23 ) equals: 'Uint64'
]
