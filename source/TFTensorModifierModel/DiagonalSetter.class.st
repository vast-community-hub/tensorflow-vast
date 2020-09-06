Class {
	#name : 'DiagonalSetter',
	#superclass : 'TensorModifier',
	#category : 'TFTensorModifierModel'
}

{ #category : 'Accessing' }
DiagonalSetter class >> like: aTensor withElementsInDiagonal: aDiagonalTensor [

	^self named: 'MatrixSetDiag' like: aTensor withElementsInDiagonal: aDiagonalTensor
]

{ #category : 'Accessing' }
DiagonalSetter class >> named: aName like: aTensor withElementsInDiagonal: aDiagonalTensor [

	^aTensor currentComputation
		newOperationOf: 'MatrixSetDiag'
		namePrefixed: aName
		with: aTensor
		with: aDiagonalTensor
]
