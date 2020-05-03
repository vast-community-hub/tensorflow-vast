Class {
	#name : 'TFCrossEntropyErrorTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFCrossEntropyErrorTest >> testSoftmaxCrossEntropyWithLogits [

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
		TFCrossEntropyErrorAgainstProbabilities of: logits whenExpectedProbabilityIs: labels.
		
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
TFCrossEntropyErrorTest >> testSoftmaxCrossEntropyWithLogitsFromTensorflow [
	"\tensorflow\compiler\tests\binary_ops_test.py"

	| labelsProbability logits crossEntropy |

	logits :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(1 2 3 4);
					add: #(5 6 7 8);
					asFloatTensor).
	labelsProbability :=
		tf
			variableNamed: 'features'
			with: (
				(OrderedCollection new)
					add: #(0.1 0.2 0.3 0.4);
					add: #(0.4 0.3 0.2 0.1);
					asFloatTensor).
					
	crossEntropy :=
		TFCrossEntropyErrorAgainstProbabilities
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
TFCrossEntropyErrorTest >> testSparseSoftmaxCrossEntropyWithLogits [

	| logits labels logitsTensor crossEntropy |

	logits :=
		OrderedCollection new
			add: #(0.1 0.2);
			add: #(0.1 0.2);
			add: #(0 0);
			yourself.
	logitsTensor := tf variableNamed: 'features' with: logits asFloatTensor.
	labels := tf variableNamed: 'expected' with: #(0 1 0) asInt32Tensor.

	crossEntropy := TFCrossEntropyError of: logitsTensor whenExpectedIs: labels.

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
