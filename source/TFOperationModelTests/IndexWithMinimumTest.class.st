Class {
	#name : 'IndexWithMinimumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
IndexWithMinimumTest >> testIndexWithMinimumValueAcrossAxis [

	| tensor minAcross0 minAcross1 |

	tensor :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	minAcross0 := tensor argMinAcross: 0.
	minAcross1 := tensor argMinAcross: 1.

	self assertOutputOf: minAcross0 isLargeIntegerVectorEqualsTo: #(0 2).
	self assertOutputOf: minAcross1 isLargeIntegerVectorEqualsTo: #(0 0 1)
]

{ #category : 'Tests' }
IndexWithMinimumTest >> testOperationName [

	| tensor |

	tensor := tf constantWith: #((1.1 1.2)) asFloatTensor.

	self assert: (IndexWithMinimum in: tensor across: 0) isNamedInGraphAs: 'ArgMin'.
	self assert: (IndexWithMinimum in: tensor across: 0) isNamedInGraphAs: 'ArgMin_1'.
	self assert: (IndexWithMinimum named: 'output' in: tensor across: 0) isNamedInGraphAs: 'output'.
	self
		assert: (IndexWithMinimum named: 'output' in: tensor across: 0)
		isNamedInGraphAs: 'output_1'
]
