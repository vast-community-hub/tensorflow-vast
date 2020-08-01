Extension {
	#name : 'TFMatrixMultiplicationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFMatrixMultiplicationTest >> testGradientOfDotProduct [

	| constA constB output |

	constA := tf floatConstantWith: #((1.1 1.2 1.3)) named: 'a'.
	constB := tf floatConstantWith: #((1.1) (2.1) (3.1)) named: 'b'.

	output := TFMatrixMultiplication of: constA and: constB.

	self
		assertPartialDerivativeOf: output withRespectTo: constA isMatrixCloseTo: #((1.1 2.1 3.1));
		assertPartialDerivativeOf: output
			withRespectTo: constB
			isMatrixCloseTo: #((1.1) (1.2) (1.3))
]
