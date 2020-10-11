Class {
	#name : 'ModelUpdater',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'lossToMinimize',
		'optimizer'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
ModelUpdater class >> updating: aModel toMinimize: aLossFunction using: anOptimizer [

	^self new initializeUpdating: aModel toMinimize: aLossFunction using: anOptimizer
]

{ #category : 'Accessing' }
ModelUpdater >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ModelUpdater >> initializeOptimizationsToMinimize: aTrainableVariableCollection [

	| grads optimizations |

	grads := lossToMinimize partialDerivativeWithRespectTo: aTrainableVariableCollection.
	optimizations :=
		aTrainableVariableCollection
			collect: [:variable | optimizer apply: (grads valueWithRespectTo: variable) to: variable].
	value := IdentityTransformation of: lossToMinimize evaluatedOnlyAfter: optimizations
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ModelUpdater >> initializeUpdating: aModel toMinimize: aLossFunction using: anOptimizer [

	lossToMinimize := aLossFunction.
	optimizer := anOptimizer.
	self initializeOptimizationsToMinimize: aModel trainableVariables
]

{ #category : 'Accessing' }
ModelUpdater >> lossToMinimize [

	^lossToMinimize
]

{ #category : 'Printing' }
ModelUpdater >> printOn: aStream [

	aStream
		nextPutAll: ('Loss: <1p>' expandMacrosWith: lossToMinimize);
		cr;
		nextPutAll: ('Optimization Algorithm: <1p>' expandMacrosWith: optimizer)
]
