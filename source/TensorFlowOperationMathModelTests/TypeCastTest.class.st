Class {
	#name : 'TypeCastTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
TypeCastTest >> testBooleanToFloat [

	| x |

	x := tf constantWith: (Array with: true with: false) asBooleanTensor.

	self assert: (tf compute: (x castedTo: FloatDataType new)) isFloatVectorCloseTo: #(1 0)
]

{ #category : 'Test' }
TypeCastTest >> testBooleanToInteger [

	| x |

	x :=
		tf constantWith: (
			OrderedCollection new
				add: (Array with: true with: false);
				add: (Array with: false with: true);
				asBooleanTensor).

	self
		assert: (tf compute: (x castedTo: Int32DataType new))
		isIntegerMatrixCloseTo: #((1 0) (0 1))
]

{ #category : 'Test' }
TypeCastTest >> testPrintString [

	| x |

	x := tf variableNamed: 'input' with: (Array with: true with: false) asBooleanTensor.

	self assert: (x castedTo: FloatDataType new) printString equals: 'input casted to Float'
]
