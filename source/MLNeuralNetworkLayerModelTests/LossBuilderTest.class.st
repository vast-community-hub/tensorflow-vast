Class {
	#name : 'LossBuilderTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLNeuralNetworkLayerModelTests'
}

{ #category : 'Test - Optimizer',
  #vaVisibility : 'private' }
LossBuilderTest >> gradientDescentOf: aLossFunction withRespectTo: aVariable [

	| gradOutput grad |

	grad := aLossFunction partialDerivativeWithRespectTo: aVariable.
	gradOutput := grad valueWithRespectTo: aVariable.
	^(GradientDescent scalingBy: 0.2) apply: gradOutput to: aVariable
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> inputAndExpectedLabels [

	^(Dictionary new)
		at: 'input' put: self logictStatements;
		at: 'expected' put: #(0 1 0 0) asInt32Tensor;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> inputAndExpectedProbabilities [

	^(Dictionary new)
		at: 'input' put: self logictStatements;
		at: 'expected' put: #((0) (1) (0) (0)) asFloatTensor;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> logictStatements [

	^#((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> modelWithOneOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 1
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2)];
		build
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> modelWithTwoOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 2
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2 0.8)];
		build
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testCategoricalCrossEntropy [

	| loss |

	loss := (LossBuilder for: self modelWithOneOutputUnits) buildCategoricalCrossEntropy.
	
	self assert: (loss computeWith: self inputAndExpectedProbabilities) isFloatScalarCloseTo: 0
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testCategoricalCrossEntropyGradient [

	| loss grads |

	loss := (LossBuilder for: self modelWithOneOutputUnits) buildCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: self weight.
	
	self
		assert: (grads computeWith: self inputAndExpectedProbabilities)
		isMatrixCloseTo: #((0.5) (0.25) (0.5))
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testCategoricalCrossEntropyWithoutReducing [

	| loss |

	loss :=
		(LossBuilder for: self modelWithOneOutputUnits)
			withoutReducing;
			buildCategoricalCrossEntropy.
			
	self
		assert: (loss computeWith: self inputAndExpectedProbabilities)
		isFloatVectorCloseTo: #(0 0 0 0)
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testCategoricalCrossEntropyWithoutReducingGradient [

	| loss grads |

	loss :=
		(LossBuilder for: self modelWithOneOutputUnits)
			withoutReducing;
			buildCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: self weight.
	
	self
		assert: (grads computeWith: self inputAndExpectedProbabilities)
		isMatrixCloseTo: #((2) (1) (2))
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testMeanSquaredError [

	| loss |

	loss := (LossBuilder for: self modelWithOneOutputUnits) buildMeanSquaredError.
	
	self assert: (loss computeWith: self inputAndExpectedProbabilities) isFloatScalarCloseTo: 0.19
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testMeanSquaredErrorGradient [

	| loss grads |

	loss := (LossBuilder for: self modelWithOneOutputUnits) buildMeanSquaredError.
	grads := loss partialDerivativeWithRespectTo: self weight.

	self
		assert: (grads computeWith: self inputAndExpectedProbabilities)
		isMatrixCloseTo: #((0.2) (-0.3) (-0.2))
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testMeanSquaredErrorWithoutReducing [

	| loss |

	loss :=
		(LossBuilder for: self modelWithOneOutputUnits)
			withoutReducing;
			buildSquaredError.
			
	self
		assert: (loss computeWith: self inputAndExpectedProbabilities)
		isMatrixCloseTo: #((0.04) (0.64) (0.04) (0.04))
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testMeanSquaredErrorWithoutReducingGradient [

	| loss grads |

	loss :=
		(LossBuilder for: self modelWithOneOutputUnits)
			withoutReducing;
			buildSquaredError.
	grads := loss partialDerivativeWithRespectTo: self weight.
	
	self
		assert: (grads computeWith: self inputAndExpectedProbabilities)
		isMatrixCloseTo: #((0.8) (-1.2) (-0.8))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingCategoricalCrossEntropy [

	| loss weight optimize |

	loss := (LossBuilder for: self modelWithTwoOutputUnits) buildCategoricalCrossEntropy.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedProbabilities.
	
	self
		assertOutputOf: weight
		isMatrixCloseTo: #(
			(-3.54343689978123e-2 -6.45656287670136e-2) (1.45656336098909e-2 -1.45656289532781e-2)
			(-3.1515508890152e-3 -4.68484424054623e-2))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingCategoricalCrossEntropyWithoutReducing [

	| loss weight optimize |

	loss :=
		(LossBuilder for: self modelWithTwoOutputUnits)
			withoutReducing;
			buildCategoricalCrossEntropy.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedProbabilities.
	
	self
		assertOutputOf: weight
		isMatrixCloseTo: #(
			(-1.41737475991249e-1 -2.58262515068054e-1) (5.82625344395638e-2 -5.82625158131123e-2)
			(-1.26062035560608e-2 -1.87393769621849e-1))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingMeanSquaredError [

	| loss weight optimize |

	loss := (LossBuilder for: self modelWithTwoOutputUnits) buildMeanSquaredError.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedProbabilities.
	
	self assertOutputOf: weight isMatrixCloseTo: #((-0.02 -0.08) (0.03 -0.03) (0.02 -0.07))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingMeanSquaredErrorWithoutReducing [

	| loss weight optimize |

	loss :=
		(LossBuilder for: self modelWithTwoOutputUnits)
			withoutReducing;
			buildSquaredError.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedProbabilities.
	
	self assertOutputOf: weight isMatrixCloseTo: #((-0.16 -0.64) (0.24 -0.24) (0.16 -0.56))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingSparseCategoricalCrossEntropy [

	| loss weight optimize |

	loss := (LossBuilder for: self modelWithTwoOutputUnits) buildSparseCategoricalCrossEntropy.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedLabels.
	
	self
		assertOutputOf: weight
		isMatrixCloseTo: #(
			(6.45656362175942e-2 -6.45656287670136e-2) (1.45656336098909e-2 -1.45656289532781e-2)
			(4.68484535813332e-2 -4.68484424054623e-2))
]

{ #category : 'Test - Optimizer' }
LossBuilderTest >> testOptimizeModelMinimizingSparseCategoricalCrossEntropyWithoutReducing [

	| loss weight optimize |

	loss :=
		(LossBuilder for: self modelWithTwoOutputUnits)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.
	weight := self weight.
	optimize := self gradientDescentOf: loss withRespectTo: weight.
	tf compute: optimize feedingInputsWith: self inputAndExpectedLabels.
	
	self
		assertOutputOf: weight
		isMatrixCloseTo: #(
			(0.2582634 -0.2582634) (0.058262532 -0.058262532) (0.187393808 -0.187393808))
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testSparseCategoricalCrossEntropy [

	| loss |

	loss := (LossBuilder for: self modelWithTwoOutputUnits) buildSparseCategoricalCrossEntropy.
	
	self assert: (loss computeWith: self inputAndExpectedLabels) isFloatScalarCloseTo: 0.887488
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testSparseCategoricalCrossEntropyGradient [

	| loss grads |

	loss := (LossBuilder for: self modelWithTwoOutputUnits) buildSparseCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: self weight.
	
	self
		assert: (grads computeWith: self inputAndExpectedLabels)
		isMatrixCloseTo: #(
			(-0.32282817 0.32282814) (-0.07282817 0.07282814) (-0.23424226 0.23424222))
]

{ #category : 'Test - Loss' }
LossBuilderTest >> testSparseCategoricalCrossEntropyWithoutReducing [

	| loss |

	loss :=
		(LossBuilder for: self modelWithTwoOutputUnits)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.
			
	self
		assert: (loss computeWith: self inputAndExpectedLabels)
		isFloatVectorCloseTo: #(1.0374879 0.4374879 1.0374879 1.0374879)
]

{ #category : 'Test - Gradients' }
LossBuilderTest >> testSparseCategoricalCrossEntropyWithoutReducingGradient [

	| loss grads |

	loss :=
		(LossBuilder for: self modelWithTwoOutputUnits)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: self weight.
	
	self
		assert: (grads computeWith: self inputAndExpectedLabels)
		isMatrixCloseTo: #(
			(-1.2913127 1.2913126) (-0.29131266 0.29131258) (-0.93696904 0.93696886))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilderTest >> weight [

	^tf operationNamed: 'weight'
]
