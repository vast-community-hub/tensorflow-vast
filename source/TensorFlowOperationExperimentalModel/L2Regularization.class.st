Class {
	#name : 'L2Regularization',
	#superclass : 'Regularizer',
	#instVars : [
		'lambda'
	],
	#category : 'TensorFlowOperationExperimentalModel'
}

{ #category : 'Instance Creation' }
L2Regularization class >> by: aLambda [

	^super new initializeBy: aLambda
]

{ #category : 'Instance Creation' }
L2Regularization class >> new [

	^self by: 1
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
L2Regularization >> initializeBy: aLambda [

	lambda := aLambda
]

{ #category : 'Processing' }
L2Regularization >> regularize: anOperation [

	^(ReduceSum valuesIn: anOperation squared) * lambda asTensor
]
