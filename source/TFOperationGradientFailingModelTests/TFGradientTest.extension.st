Extension {
	#name : 'TFGradientTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
TFGradientTest >> testMSEGradient [
	" This test fails randomly and don't know why. Needs work 

	| prediction expected mse gradWeight |

	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	mse := TFMeanSquaredError of: prediction whenExpectedIs: expected.

	gradWeight := TFGradient of: (Array with: mse) withRespectTo: (Array with: prediction).

	self assertOutputOf: (tf compute: gradWeight) isFloatScalarCloseTo: 2 * (3 - Float pi)"
]
