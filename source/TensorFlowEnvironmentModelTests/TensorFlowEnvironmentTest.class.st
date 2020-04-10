Class {
	#name : 'TensorFlowEnvironmentTest',
	#superclass : 'TestCase',
	#category : 'TensorFlowEnvironmentModelTests'
}

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> assert: aTensor isTensorEquivalentTo: anotherTensor [

	self
		assert: aTensor shape equals: anotherTensor shape;
		assert: aTensor type equals: anotherTensor type;
		assert: aTensor allElements equals: anotherTensor allElements
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> executeShould: aBlock inScopeOf: anException withSignalDo: anotherBlock [

	^[aBlock value.
 	false] 
		sunitOn: anException
		do: [:aSignal | 
			anotherBlock value: aSignal.
			aSignal sunitExitWith: true]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> lossFunction [
	^[:predictedY :desiredY | (predictedY - desiredY) squared meanOn: #(0) asInt32Tensor]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> normalWith: aNumber examplesFrom: calculator [

	^(calculator constant: (Array with: aNumber) asInt32Tensor)
		unaryOp: 'RandomStandardNormal'
		described: [:description |
			description
				at: 'seed' putInt: 3;
				at: 'seed2' putInt: 4;
				at: 'dtype' putType: TFTensor typeFloat]
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> should: aBlock raise: anException withDescription: aString [

	self
		should: aBlock
		raise: anException
		withSignalDo: [:exception | self assert: exception messageText equals: aString]
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowEnvironmentTest >> should: aBlock raise: anException withSignalDo: anotherBlock [

	^self
		assert: (self executeShould: aBlock inScopeOf: anException withSignalDo: anotherBlock)
		description: ('Expected exception (%1) wasn''t raised' bindWith: anException)
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testAdd [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (environment calculate: [:calculator | calculator add: #()])
			isTensorEquivalentTo: 0 asTensor;
		assert: (environment calculate: [:calculator | calculator add: #(1.0 2.0)])
			isTensorEquivalentTo: 3.0 asTensor;
		assert: (environment calculate: [:calculator | calculator add: (Array with: 1 with: 2)])
			isTensorEquivalentTo: 3 asTensor;
		assert: (
				environment calculate: [:calculator |
					calculator add: (Array with: #(1 2) asInt32Tensor with: #(3 4) asInt32Tensor)])
			isTensorEquivalentTo: #(4 6) asInt32Tensor;
		assert: (
				environment calculate: [:calculator |
					calculator add: (
						Array
							with: #(1 2) asFloatTensor
							with: #(3 4) asFloatTensor
							with: #(5 6) asFloatTensor)])
			isTensorEquivalentTo: (Array with: 1 + 3 + 5 with: 2 + 4 + 6) asFloatTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testAddSquares [

	| environment |

	environment := TensorFlowEnvironment new.

	self
		assert: (
				environment
					calculate: [:calculator | (calculator square: 2) + (calculator square: 3)])
			isTensorEquivalentTo: 13 asTensor;
		assert: (
				environment calculate: [:calculator |
					(calculator constant: 2) squared + (calculator constant: 3) squared])
			isTensorEquivalentTo: 13 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testCurrentLoss [

	| environment currentLoss |

	environment := TensorFlowEnvironment new.
	currentLoss :=
		environment calculate: [:calculator | | weight coefficient linearModel trueWeight
			  trueCoefficient numberOfExamples inputs noise outputs |
			weight := calculator variable: 5.0.
			coefficient := calculator variable: 0.0.
			linearModel := [:input | weight @* input + coefficient].
			trueWeight := 3.0.
			trueCoefficient := 2.0.
			numberOfExamples := 1000.
			inputs := self normalWith: numberOfExamples examplesFrom: calculator.
			noise := self normalWith: numberOfExamples examplesFrom: calculator.
			outputs := inputs @* trueWeight + trueCoefficient + noise.
			self lossFunction value: (linearModel value: inputs) value: outputs].
	self assert: currentLoss isTensorEquivalentTo: 4.93131494522095 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testEncodeBase64 [

	| environment tensor |

	environment := TensorFlowEnvironment new.
	tensor := environment calculate: [:calculator | calculator encodeBase64: 'hello world'].
	self assert: tensor allStrings equals: #('aGVsbG8gd29ybGQ')
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testLinearModel [

	| environment linearModel |

	environment := TensorFlowEnvironment new.

	linearModel := [:input |
		environment calculate: [:calculator | | weight coefficient |
			weight := calculator variable: 5.0.
			coefficient := calculator variable: 0.0.
			weight @* input + coefficient]].

	self assert: (linearModel value: 3.0) isTensorEquivalentTo: 15.0 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testMoreThanOneOperation [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (environment calculate: [:calculator | calculator add: #(1.0 2.0)])
			isTensorEquivalentTo: 3.0 asTensor;
		assert: (environment calculate: [:calculator | calculator square: 5.0])
			isTensorEquivalentTo: 25.0 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testMultiplyByScalar [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (
			environment calculate: [:calculator | | tensorOf1s |
				tensorOf1s := calculator tensorOfOnesWith: #(3 3) asInt32Tensor.
				calculator multiplyElementsOf: tensorOf1s by: 42])
		isTensorEquivalentTo: (
			environment
				calculate: [:calculator | calculator tensorOf: 42 with: #(3 3) asInt32Tensor])
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testMultiplyMatrices [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (
				environment calculate: [:calculator |
					calculator multiplyMatrices:
						(Array with: #((1)) asInt32Tensor with: #((1 2)) asInt32Tensor)])
			isTensorEquivalentTo: #((1 2)) asInt32Tensor;
		assert: (
				environment calculate: [:calculator |
					calculator multiplyMatrices: (
						Array
							with: #((1) (2) (3)) asInt32Tensor
							with: #((3 4 5)) asInt32Tensor)])
			isTensorEquivalentTo:
				(Array
					with: (Array with: 1 * 3 with: 1 * 4 with: 1 * 5)
					with: (Array with: 2 * 3 with: 2 * 4 with: 2 * 5)
					with: (Array with: 3 * 3 with: 3 * 4 with: 3 * 5))
						asInt32Tensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testReduceSum [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (
				environment calculate: [:calculator | calculator reduceSum: #(1 2 3) asInt32Tensor])
			isTensorEquivalentTo: 6 asTensor;
		assert: (
				environment calculate: [:calculator |
					calculator reduceSum:
						#(((1 1 1) (2 2 2) (3 3 3) (4 4 4))
						((5 5 5) (6 6 6) (7 7 7) (8 8 8)))
							asInt32Tensor])
			isTensorEquivalentTo: 108 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testSquare [

	| environment |

	environment := TensorFlowEnvironment new.
	self
		assert: (environment calculate: [:calculator | calculator square: 5.0])
			isTensorEquivalentTo: 25.0 asTensor;
		assert: (environment calculate: [:calculator | (calculator constant: 5) squared])
			isTensorEquivalentTo: 25 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testVariable [

	| environment variable |

	environment := TensorFlowEnvironment new.

	environment calculate: [:calculator |
		variable := calculator variableNamed: 'this_var'.
		calculator assign: 3 to: variable].
	self assert: (environment calculate: [:calculator | variable]) isTensorEquivalentTo: 3 asTensor.

	environment calculate: [:calculator | calculator assign: variable squared to: variable].
	self assert: (environment calculate: [:calculator | variable]) isTensorEquivalentTo: 9 asTensor
]

{ #category : 'Tests' }
TensorFlowEnvironmentTest >> testVariableMustBeAssignedBeforeCompletingCalculation [

	self
		should: [
			TensorFlowEnvironment new calculate: [:calculator | calculator variableNamed: 'cant_use']]
		raise: Error
		withSignalDo: [:aSignal |
			aSignal messageText
				includes: 'FAILED_PRECONDITION: Attempting to use uninitialized value cant_use']
]
