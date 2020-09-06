Class {
	#name : 'ReduceMeanTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
ReduceMeanTest >> testOperationName [

	| a |

	a := tf constantWith: #(1.1) asFloatTensor.

	self assert: (ReduceMean ofValuesIn: a) isNamedInGraphAs: 'Mean'.
	self assert: (ReduceMean ofValuesIn: a) isNamedInGraphAs: 'Mean_1'.
	self assert: (ReduceMean named: 'output' ofValuesIn: a) isNamedInGraphAs: 'output'.
	self assert: (ReduceMean named: 'output' ofValuesIn: a) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ReduceMeanTest >> testReduceAlongsideAxis [

	| a mean0 mean01 mean1 meanNone |

	a :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean0 := a meanAlongside: #(0).
	mean1 := a meanAlongside: #(1).
	mean01 := a meanAlongside: #(0 1).
	meanNone := a meanAlongside: #().

	self assertOutputOf: mean0 isFloatVectorCloseTo: #(2.1 1.2).
	self assertOutputOf: mean1 isFloatVectorCloseTo: #(1.15 2.15 1.65).
	self assertOutputOf: mean01 isFloatScalarCloseTo: 1.65.
	self
		assertOutputOf: meanNone
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1.1 1.2);
				add: #(2.1 2.2);
				add: #(3.1 0.2);
				yourself)
]

{ #category : 'Test' }
ReduceMeanTest >> testReducePlaceholder [

	| inputValue constant inputWithSize inputWithoutShape |

	inputValue :=
		(OrderedCollection new)
			add: #(1.1 1.2);
			add: #(2.1 2.2);
			add: #(3.1 0.2);
			yourself.

	constant := tf floatConstantWith: inputValue.
	inputWithoutShape := tf floatInputNamed: 'input'.
	inputWithSize := InputNode on: tf named: 'inputWithSize' of: TFTensor typeFloat sized: 2.

	self assert: constant mean compute isFloatScalarCloseTo: 1.65.
	self
		assert: (
			inputWithSize mean computeWith: (
				Dictionary new
					at: 'inputWithSize' put: inputValue asFloatTensor;
					yourself))
		isFloatScalarCloseTo: 1.65. 
	
	" If the Input doesn't have the information of the shape, then the creation of the mean won't know
	 how many axis to reduce, and just won't reduce "
	self
		assert: (
			inputWithoutShape mean computeWith: (
				Dictionary new
					at: 'input' put: inputValue asFloatTensor;
					yourself))
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1.1 1.2);
				add: #(2.1 2.2);
				add: #(3.1 0.2);
				yourself)
]

{ #category : 'Test' }
ReduceMeanTest >> testReduceWithoutAxis [

	| a mean01 meanNone |

	a :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean01 := a meanAlongside: #(0 1).
	meanNone := a mean.

	self assertOutputOf: mean01 isFloatScalarCloseTo: 1.65.
	self assertOutputOf: meanNone isFloatScalarCloseTo: 1.65
]
