Class {
	#name : 'ModelUpdater',
	#superclass : 'TFOperationAbstract',
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
ModelUpdater class >> updating: aModel toMinimize: aLossFunction using: anOptimizer [

	^self new initializeUpdating: aModel toMinimize: aLossFunction using: anOptimizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ModelUpdater >> initializeUpdating: aModel toMinimize: aLossFunction using: anOptimizer [

	| grads optimizations |

	grads := aLossFunction partialDerivativeWithRespectTo: aModel trainableVariables.
	optimizations :=
		aModel trainableVariables collect: [:variable |
			anOptimizer apply: (grads gradientRespectTo: variable) to: variable].
	value := TFIdentity of: aLossFunction evaluatedOnlyAfter: optimizations
]
