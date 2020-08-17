Class {
	#name : 'TFReduceMeanTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReduceMeanTest >> testOperationName [

	| a |

	a := tf constantWith: #(1.1) asFloatTensor.

	self assert: (TFReduceMean ofValuesIn: a) isNamedInGraphAs: 'Mean'.
	self assert: (TFReduceMean ofValuesIn: a) isNamedInGraphAs: 'Mean_1'.
	self assert: (TFReduceMean named: 'output' ofValuesIn: a) isNamedInGraphAs: 'output'.
	self assert: (TFReduceMean named: 'output' ofValuesIn: a) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFReduceMeanTest >> testReduceAlongsideAxis [

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
TFReduceMeanTest >> testReduceWithoutAxis [

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
