Class {
	#name : 'TFIndexWithMaximumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFIndexWithMaximumTest >> testIndexWithMaximumValueAcrossAxis [

	| tensor |

	tensor :=
		tf
			floatConstantWith: (
				(OrderedCollection new)
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.
			
	self assertOutputOf: tensor argMaxOnColumns isLargeIntegerVectorEqualsTo: #(2 1).
	self assertOutputOf: tensor argMaxOnRows isLargeIntegerVectorEqualsTo: #(1 1 0)
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
