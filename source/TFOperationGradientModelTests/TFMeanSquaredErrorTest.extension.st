Extension {
	#name : 'TFMeanSquaredErrorTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFMeanSquaredErrorTest >> testGradientOfMSEBetweenTwoConstantScalars [

	| prediction expected mse |

	prediction := tf floatConstantWith: 3 named: 'prediction'.
	expected := tf constantWith: Float pi.

	mse := TFMeanSquaredError of: prediction whenExpectedIs: expected.

	self assertPartialDerivativeOf: mse withRespectTo: prediction isCloseTo: 2 * (3 - Float pi)
]
