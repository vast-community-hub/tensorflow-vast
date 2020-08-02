Class {
	#name : 'TFDiagonalSetter',
	#superclass : 'TFTensorModifier',
	#category : 'TFTensorModifierModel'
}

{ #category : 'Accessing' }
TFDiagonalSetter class >> like: aTensor withElementsInDiagonal: aDiagonalTensor [

	^self named: 'MatrixSetDiag' like: aTensor withElementsInDiagonal: aDiagonalTensor
]

{ #category : 'Accessing' }
TFDiagonalSetter class >> named: aName like: aTensor withElementsInDiagonal: aDiagonalTensor [

	^aTensor currentComputation
		newOperationOf: 'MatrixSetDiag'
		namePrefixed: aName
		with: aTensor
		with: aDiagonalTensor
]
