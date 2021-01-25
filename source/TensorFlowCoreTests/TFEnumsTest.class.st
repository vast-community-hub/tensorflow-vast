Class {
	#name : 'TFEnumsTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'Tests' }
TFEnumsTest >> testDataTypeEnum [
	"Test TF_DataTypeSize function with enum args"

	Dictionary new
		at: TFTensor typeFloat put: 4;
		at: TFTensor typeInt64 put: 8;
		at: TFTensor typeInt32 put: 4;
		at: TFTensor typeDouble put: 8;
		at: TFTensor typeBoolean put: 1;
		at: TFTensor typeUInt8 put: 1;
		at: TFTensor typeVariant put: 0;
		keysAndValuesDo: [:type :expectedType |
			self assert: (TensorFlowCAPI current sizeOfDataType: type) equals: expectedType]
]
