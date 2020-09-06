Class {
	#name : 'SparseCategoricalCrossEntropyTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
SparseCategoricalCrossEntropyTest >> testReducedMeanSparseCategoricalCrossEntropy [

	| logits labels logitsTensor crossEntropy |

	logits :=
		OrderedCollection new
			add: #(0.1 0.2);
			add: #(0.1 0.2);
			add: #(0 0);
			yourself.
	logitsTensor := tf variableNamed: 'features' with: logits asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0 1 0) asInt32Tensor.

	crossEntropy :=
		CrossEntropyMean
			of: (SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels).

	self
		assertOutputOf: crossEntropy
		isFloatScalarCloseTo: (
			OrderedCollection new
				add: ((logits at: 1) softmax at: 1) ln negated;
				add: ((logits at: 2) softmax at: 2) ln negated;
				add: ((logits at: 3) softmax at: 1) ln negated;
				mean).

	self
		assertOutputOf: crossEntropy backpropagatedGradient
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(-1.74993067979813e-1 1.74993067979813e-1);
				add: #(1.58340275287628e-1 -1.58340275287628e-1);
				add: #(-0.16666667163372 0.16666667163372);
				yourself)
]

{ #category : 'Test' }
SparseCategoricalCrossEntropyTest >> testReducedMeanSparseCategoricalCrossEntropyPrintString [

	| logits labels logitsTensor crossEntropy |

	logits :=
		OrderedCollection new
			add: #(0.1 0.2);
			add: #(0.1 0.2);
			add: #(0 0);
			yourself.
	logitsTensor := tf variableNamed: 'features' with: logits asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0 1 0) asInt32Tensor.

	crossEntropy :=
		CrossEntropyMean
			of: (SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels).

	self
		assert: crossEntropy printString
		equals: 'Sparse Categorical Cross Entropy (Reduced to scalar with mean)'
]
