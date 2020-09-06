Class {
	#name : 'CategoricalCrossEntropyTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testCategoricalCrossEntropy [

	| labels logits crossEntropy |

	labels :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).
					
	logits :=
		tf
			variableNamed: 'features'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).
					
	crossEntropy :=
		CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels.
		
	self
		assertOutputOf: crossEntropy loss
		isFloatVectorCloseTo: #(
			0.715673923492432 0.698368966579437 0.715673923492432 0.988751113414764).
	self
		assertOutputOf: crossEntropy backpropagatedGradient
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(-0.362361133098602 0.2107844799757 0.141576707363129);
				add: #(0.21906889975071 0.142108589410782 -0.361177444458008);
				add: #(-0.362361133098602 0.2107844799757 0.141576707363129);
				add: #(0.0333333313465118 0.0333333313465118 0.0333333313465118);
				yourself)
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testCategoricalCrossEntropyOperationName [

	| labels logits |

	labels := tf constantWith: #((0.9 0.01 0.1)) asFloatTensor.
	logits := tf constantWith: #((0.9 0.01 0.1)) asFloatTensor.

	self
		assert: (
				CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels)
			isNamedInGraphAs: 'SoftmaxCrossEntropyWithLogits';
		assert: (
				CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels)
			isNamedInGraphAs: 'SoftmaxCrossEntropyWithLogits_1';
		assert: (
				CategoricalCrossEntropy
					named: 'loss'
					of: logits
					whenExpectedProbabilityIs: labels)
			isNamedInGraphAs: 'loss';
		assert: (
				CategoricalCrossEntropy
					named: 'loss'
					of: logits
					whenExpectedProbabilityIs: labels)
			isNamedInGraphAs: 'loss_1'
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testCategoricalCrossEntropyPrintString [

	| labels logits |

	labels :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	logits :=
		tf
			variableNamed: 'features'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	self
		assert: (CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels) printString
		equals: 'Categorical Cross Entropy'
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testFromTensorflowExamplesForCategoricalCrossEntropy [
	"\tensorflow\compiler\tests\binary_ops_test.py"

	| labelsProbability logits crossEntropy |

	logits :=
		tf
			variableNamed: 'logits'
			with: (
				(OrderedCollection new)
					add: #(1 2 3 4);
					add: #(5 6 7 8);
					asFloatTensor).
	labelsProbability :=
		tf
			variableNamed: 'labels'
			with: (
				(OrderedCollection new)
					add: #(0.1 0.2 0.3 0.4);
					add: #(0.4 0.3 0.2 0.1);
					asFloatTensor).
					
	crossEntropy :=
		CategoricalCrossEntropy
			of: logits
			whenExpectedProbabilityIs: labelsProbability.
			
	self assertOutputOf: crossEntropy loss isFloatVectorCloseTo: #(1.44019 2.44019).
	self
		assertOutputOf: crossEntropy backpropagatedGradient
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(-0.067941 -0.112856 -0.063117 0.243914);
				add: #(-0.367941 -0.212856 0.036883 0.543914);
				yourself)
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testReduceMeanCategoricalCrossEntropy [

	| labels logits crossEntropy |

	labels :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	logits :=
		tf
			variableNamed: 'features'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	crossEntropy :=
		CrossEntropyMean
			of: (CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels).

	self
		assertOutputOf: crossEntropy
		isFloatScalarCloseTo:
			#(0.715673923492432 0.698368966579437 0.715673923492432 0.988751113414764) mean.
	self
		assertOutputOf: crossEntropy backpropagatedGradient
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(-9.05902832746506e-2 5.26961199939251e-2 3.53941768407822e-2);
				add: #(5.47672249376774e-2 3.55271473526955e-2 -9.0294361114502e-2);
				add: #(-9.05902832746506e-2 5.26961199939251e-2 3.53941768407822e-2);
				add: #(8.33333283662796e-3 8.33333283662796e-3 8.33333283662796e-3);
				yourself)
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testReduceMeanCategoricalCrossEntropyPrintString [

	| labels logits crossEntropy |

	labels :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	logits :=
		tf
			variableNamed: 'features'
			with: (
				(OrderedCollection new)
					add: #(0.9 0.01 0.1);
					add: #(0.0 0.1 0.9);
					add: #(0.9 0.01 0.1);
					add: #(0.3 0.3 0.3);
					asFloatTensor).

	crossEntropy :=
		CrossEntropyMean
			of: (CategoricalCrossEntropy of: logits whenExpectedProbabilityIs: labels).

	self
		assert: crossEntropy printString
		equals: 'Categorical Cross Entropy (Reduced to scalar with mean)'
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testSparseCategoricalCrossEntropy [

	| logits labels logitsTensor crossEntropy |

	logits :=
		OrderedCollection new
			add: #(0.1 0.2);
			add: #(0.1 0.2);
			add: #(0 0);
			yourself.
	logitsTensor := tf variableNamed: 'features' with: logits asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0 1 0) asInt32Tensor.

	crossEntropy := SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels.

	self
		assertOutputOf: crossEntropy loss
		isFloatVectorCloseTo: (
			OrderedCollection new
				add: ((logits at: 1) softmax at: 1) ln negated;
				add: ((logits at: 2) softmax at: 2) ln negated;
				add: ((logits at: 3) softmax at: 1) ln negated;
				yourself).

	self
		assertOutputOf: crossEntropy backpropagatedGradient
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(-0.524979174137 0.52497917413711);
				add: #(0.4750208258628 -0.4750208258628);
				add: #(-0.5 0.5);
				yourself)
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testSparseCategoricalCrossEntropyOperationName [

	| labels logitsTensor |

	logitsTensor := tf variableNamed: 'features' with: #((0.1 0.2)) asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0) asInt32Tensor.

	self
		assert: (SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels)
			isNamedInGraphAs: 'SparseSoftmaxCrossEntropyWithLogits';
		assert: (SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels)
			isNamedInGraphAs: 'SparseSoftmaxCrossEntropyWithLogits_1';
		assert: (SparseCategoricalCrossEntropy named: 'loss' of: logitsTensor whenExpectedIs: labels)
			isNamedInGraphAs: 'loss';
		assert: (SparseCategoricalCrossEntropy named: 'loss' of: logitsTensor whenExpectedIs: labels)
			isNamedInGraphAs: 'loss_1'
]

{ #category : 'Test' }
CategoricalCrossEntropyTest >> testSparseCategoricalCrossEntropyPrintString [

	| logits labels logitsTensor |

	logits :=
		OrderedCollection new
			add: #(0.1 0.2);
			add: #(0.1 0.2);
			add: #(0 0);
			yourself.
	logitsTensor := tf variableNamed: 'features' with: logits asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0 1 0) asInt32Tensor.

	self
		assert: (SparseCategoricalCrossEntropy of: logitsTensor whenExpectedIs: labels) printString
		equals: 'Sparse Categorical Cross Entropy'
]
