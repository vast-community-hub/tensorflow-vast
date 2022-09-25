Class {
	#name : 'ReduceSumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
ReduceSumTest >> testOperationName [

	| tensor |

	tensor := tf constantWith: #((1.1)) asFloatTensor.

	self assert: (ReduceSum valuesIn: tensor) isNamedInGraphAs: 'Sum'.
	self assert: (ReduceSum valuesIn: tensor) isNamedInGraphAs: 'Sum_1'.
	self assert: (ReduceSum named: 'output' valuesIn: tensor) isNamedInGraphAs: 'output'.
	self assert: (ReduceSum named: 'output' valuesIn: tensor) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ReduceSumTest >> testReduceAlongsideAxis [

	| tensor sum0 sum01 sum1 sumNone |

	tensor :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	sum0 := tensor sumElementsAlongside: #(0).
	sum1 := tensor sumElementsAlongside: #(1).
	sum01 := tensor sumElementsAlongside: #(0 1).
	sumNone := tensor sumElementsAlongside: #().

	self assertOutputOf: sum0 isFloatVectorCloseTo: #(6.3 3.6).
	self assertOutputOf: sum1 isFloatVectorCloseTo: #(2.3 4.3 3.3).
	self assertOutputOf: sum01 isFloatScalarCloseTo: 9.9.
	self
		assertOutputOf: sumNone
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1.1 1.2);
				add: #(2.1 2.2);
				add: #(3.1 0.2);
				yourself)


]

{ #category : 'Test' }
ReduceSumTest >> testReduceWithoutAxis [

	| tensor sum sum01 |

	tensor :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	sum01 := tensor sumElementsAlongside: #(0 1).
	sum := tensor sumElements.

	self assertOutputOf: sum01 isFloatScalarCloseTo: 9.9.
	self assertOutputOf: sum isFloatScalarCloseTo: 9.9
]
