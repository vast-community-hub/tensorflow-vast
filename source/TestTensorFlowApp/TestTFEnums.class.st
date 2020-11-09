Class {
	#name : 'TestTFEnums',
	#superclass : 'TensorFlowTestCase',
	#category : 'TestTensorFlowApp'
}

{ #category : 'Tests' }
TestTFEnums >> testDataTypeEnum [
	"Test TF_DataTypeSize function with enum args"
	
	| sz |

	sz := self dispatcher callTF_DataTypeSizeWith: TF_UINT8.
	self assert: sz equals: 1.
	
	sz := self dispatcher callTF_DataTypeSizeWith: TF_INT16.
	self assert: sz equals: 2.
	
	sz := self dispatcher callTF_DataTypeSizeWith: TF_INT32.
	self assert: sz equals: 4.
	
]
