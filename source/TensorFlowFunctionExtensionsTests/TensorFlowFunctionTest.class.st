Class {
	#name : 'TensorFlowFunctionTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowFunctionExtensionsTests'
}

{ #category : 'Tests' }
TensorFlowFunctionTest >> testCreateEmptyFunction [

	| newComputation |

	newComputation := TensorFlowComputation new.

	newComputation storeComputationAsFunctionNamed: 'duplicar' outputing: #().

	self assert: newComputation allTheFunctions size equals: 1
]

{ #category : 'Tests' }
TensorFlowFunctionTest >> testCreateFunction [

	| newComputation |

	newComputation := TensorFlowComputation new.

	newComputation storeComputationAsFunctionNamed: 'duplicar' outputing: #()
]

{ #category : 'Tests' }
TensorFlowFunctionTest >> testCreateIdentityFunction [

	| newComputation input |

	newComputation := TensorFlowComputation new.
	input := InputNode on: newComputation named: 'input' of: FloatDataType new.

	newComputation
		storeComputationAsFunctionNamed: 'duplicar'
		outputing: (Array with: input value firstOutput)
]
