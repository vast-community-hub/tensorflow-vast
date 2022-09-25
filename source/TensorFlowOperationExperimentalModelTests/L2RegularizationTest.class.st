Class {
	#name : 'L2RegularizationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationExperimentalModelTests'
}

{ #category : 'Test' }
L2RegularizationTest >> testRegularizeMatrix [

	| l2 tensor |

	tensor :=
		tf floatConstantWith: (
			OrderedCollection new
				add: #(1 2 3 4);
				add: #(0 1 5 6);
				yourself).

	l2 := L2Regularization by: 0.001.
	self
		assertOutputOf: (l2 regularize: tensor)
		isFloatScalarCloseTo: (1 + 4 + 9 + 16 + 1 + 25 + 36) * 0.001
]

{ #category : 'Test' }
L2RegularizationTest >> testRegularizeVector [

	| l2 tensor |

	tensor := tf floatConstantWith: #(1 2 3 4).

	l2 := L2Regularization by: 0.001.
	
	self assertOutputOf: (l2 regularize: tensor) isFloatScalarCloseTo: (1 + 4 + 9 + 16) * 0.001
]
