Class {
	#name : 'TFIndexWithMaximumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFIndexWithMaximumTest >> testIndexWithMaximumValueAcrossAxis [

	| tensor maxAcross0 maxAcross1 |

	tensor :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	maxAcross0 := TFIndexWithMaximum in: tensor across: 0.
	maxAcross1 := TFIndexWithMaximum in: tensor across: 1.

	self assertOutputOf: maxAcross0 isLargeIntegerVectorEqualsTo: #(2 1).
	self assertOutputOf: maxAcross1 isLargeIntegerVectorEqualsTo: #(1 1 0)
]

{ #category : 'Tests' }
TFIndexWithMaximumTest >> testOperationName [

	| tensor |

	tensor := tf constantWith: #((1.1 1.2)) asFloatTensor.

	self assert: (TFIndexWithMaximum in: tensor across: 0) isNamedInGraphAs: 'ArgMax'.
	self assert: (TFIndexWithMaximum in: tensor across: 0) isNamedInGraphAs: 'ArgMax_1'.
	self assert: (TFIndexWithMaximum named: 'output' in: tensor across: 0) isNamedInGraphAs: 'output'.
	self
		assert: (TFIndexWithMaximum named: 'output' in: tensor across: 0)
		isNamedInGraphAs: 'output_1'
]
