Class {
	#name : 'TFIndexWithMinimumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFIndexWithMinimumTest >> testIndexWithMinimumValueAcrossAxis [

	| tensor minAcross0 minAcross1 |

	tensor :=
		tf
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	minAcross0 := TFIndexWithMinimum in: tensor across: 0.
	minAcross1 := TFIndexWithMinimum in: tensor across: 1.

	self assertOutputOf: minAcross0 isFloatVectorCloseTo: #(0 2).
	self assertOutputOf: minAcross1 isFloatVectorCloseTo: #(0 0 1)
]
