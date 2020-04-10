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
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	maxAcross0 := TFIndexWithMaximum in: tensor across: 0.
	maxAcross1 := TFIndexWithMaximum in: tensor across: 1.

	self assertOutputOf: maxAcross0 isIntegerVectorEqualsTo: #(2 1).
	self assertOutputOf: maxAcross1 isIntegerVectorEqualsTo: #(1 1 0)
]
