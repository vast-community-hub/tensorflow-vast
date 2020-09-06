Extension {
	#name : 'MeanSquaredErrorTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
MeanSquaredErrorTest >> testGradientOfMSEBetweenTwoScalars [
	"This test fails randomly and don't know why. Needs work 

	| prediction expected mse |

	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	mse := MeanSquaredError of: prediction whenExpectedIs: expected.

	self assertPartialDerivativeOf: mse withRespectTo: prediction isCloseTo: 2 * (3 - Float pi)"
]
