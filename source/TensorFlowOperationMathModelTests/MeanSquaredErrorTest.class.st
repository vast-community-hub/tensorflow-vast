Class {
	#name : 'MeanSquaredErrorTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
MeanSquaredErrorTest >> testMSEBetweenTwoConstantMatrices [

	| predicted expected mse expectedMSE |

	predicted := tf floatConstantWith: #((1.1 2.2) (3.50 0.2)) named: 'a'.
	expected := tf floatConstantWith: #((1 2) (4 -0.5)) named: 'b'.

	mse := MeanSquaredError of: predicted whenExpectedIs: expected.

	expectedMSE :=
		(OrderedCollection new
			add: 1 - 1.1;
			add: 2 - 2.2;
			add: 4 - 3.5;
			add: -0.5 - 0.2;
			collect: [:x | x raisedTo: 2])
				sum / 4.

	self assertOutputOf: mse isFloatScalarCloseTo: expectedMSE
]

{ #category : 'Test' }
MeanSquaredErrorTest >> testMSEBetweenTwoConstantVectors [

	| predicted expected mse expectedMSE |

	predicted := tf floatConstantWith: #(1.1 2.2 3.50 0.2) named: 'a'.
	expected := tf floatConstantWith: #(1 2 4 -0.5) named: 'b'.

	mse := MeanSquaredError of: predicted whenExpectedIs: expected.

	expectedMSE :=
		(OrderedCollection new
			add: 1 - 1.1;
			add: 2 - 2.2;
			add: 4 - 3.5;
			add: -0.5 - 0.2;
			collect: [:x | x raisedTo: 2])
				sum / 4.

	self assertOutputOf: mse isFloatScalarCloseTo: expectedMSE
]

{ #category : 'Test' }
MeanSquaredErrorTest >> testMSEBetweenTwoScalars [

	| prediction expected mse expectedMSE |

	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	mse := MeanSquaredError of: prediction whenExpectedIs: expected.

	expectedMSE := (Float pi - 3) raisedTo: 2.

	self assertOutputOf: mse isFloatScalarCloseTo: expectedMSE
]

{ #category : 'Test' }
MeanSquaredErrorTest >> testMSEBetweenTwoVariableVectors [

	| predicted expected mse expectedMSE |

	predicted := tf variableNamed: 'a' with: #(1.1 2.2 3.50 0.2) asFloatTensor.
	expected := tf variableNamed: 'b' with: #(1 2 4 -0.5) asFloatTensor.

	mse := MeanSquaredError of: predicted whenExpectedIs: expected.

	expectedMSE :=
		(OrderedCollection new
			add: 1 - 1.1;
			add: 2 - 2.2;
			add: 4 - 3.5;
			add: -0.5 - 0.2;
			collect: [:x | x raisedTo: 2])
				sum / 4.

	self assertOutputOf: mse isFloatScalarCloseTo: expectedMSE
]

{ #category : 'Test' }
MeanSquaredErrorTest >> testOperationName [

	| prediction expected |

	prediction := tf variableNamed: 'prediction' with: 3 asFloatTensor.
	expected := tf constantWith: Float pi.

	self
		assert: (MeanSquaredError of: prediction whenExpectedIs: expected) isNamedInGraphAs: 'MSE';
		assert: (MeanSquaredError of: prediction whenExpectedIs: expected)
			isNamedInGraphAs: 'MSE_1';
		assert: (MeanSquaredError named: 'error' of: prediction whenExpectedIs: expected)
			isNamedInGraphAs: 'error';
		assert: (MeanSquaredError named: 'error' of: prediction whenExpectedIs: expected)
			isNamedInGraphAs: 'error_1'
]
