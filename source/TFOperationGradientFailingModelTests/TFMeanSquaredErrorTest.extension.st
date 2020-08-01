Extension {
	#name : 'TFMeanSquaredErrorTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
TFMeanSquaredErrorTest >> testGradientOfMSEBetweenTwoScalars [
	"This test fails randomly and don't know why. Needs work 

	| prediction expected mse |

	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	mse := TFMeanSquaredError of: prediction whenExpectedIs: expected.

	self assertPartialDerivativeOf: mse withRespectTo: prediction isCloseTo: 2 * (3 - Float pi). "
]
