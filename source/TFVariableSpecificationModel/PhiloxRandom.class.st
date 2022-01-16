Class {
	#name : 'PhiloxRandom',
	#superclass : 'RandomNumberGeneratorAlgorithm',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Not categorized' }
PhiloxRandom >> createInitialStateOn: aTensorFlowComputation [

	| initialStateVector |

	" The philox algorithm state must be a 3 element array "

	initialStateVector := #(0 0 0).

	^ResourceVariableNode
		on: aTensorFlowComputation
		named: 'rng-state'
		of: Int64DataType new
		shaped: (TensorShape vectorSized: initialStateVector size)
		initializedWith: (
			ConstantInitializer
				with: (TFTensor newTyped: Int64DataType new containing: initialStateVector))
]

{ #category : 'Accessing' }
PhiloxRandom >> uniqueIdentifier [
	" https://github.com/tensorflow/tensorflow/blob/517f66b1e9a72f77c7086acb3bd8cc01a8c055b1/tensorflow/core/framework/rng_alg.h#L25. 
	 Another one available is ThreeFry (id 2) "

	^1
]
