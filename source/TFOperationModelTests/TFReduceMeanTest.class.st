Class {
	#name : 'TFReduceMeanTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReduceMeanTest >> testReduceAlongsideAxis [

	| a mean0 mean01 mean1 meanNone |

	a :=
		tf
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean0 := TFReduceMean ofValuesIn: a alongside: #(0).
	mean1 := TFReduceMean ofValuesIn: a alongside: #(1).
	mean01 := TFReduceMean ofValuesIn: a alongside: #(0 1).
	meanNone := TFReduceMean ofValuesIn: a alongside: #().

	self assertOutputOf: mean0 isFloatVectorCloseTo: #(2.1 1.2).
	self assertOutputOf: mean1 isFloatVectorCloseTo: #(1.15 2.15 1.65).
	self assertOutputOf: mean01 isScalarCloseTo: 1.65.
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
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean01 := TFReduceMean ofValuesIn: a alongside: #(0 1).
	meanNone := TFReduceMean ofValuesIn: a.

	self assertOutputOf: mean01 isScalarCloseTo: 1.65.
	self assertOutputOf: meanNone isScalarCloseTo: 1.65
]