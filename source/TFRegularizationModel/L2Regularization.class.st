Class {
	#name : 'L2Regularization',
	#superclass : 'TFRegularizer',
	#instVars : [
		'lambda'
	],
	#category : 'TFRegularizationModel'
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
L2Regularization >> regularize: aTFOperation [

	^(TFReduceSum valuesIn: aTFOperation squared) * lambda asTensor
]
