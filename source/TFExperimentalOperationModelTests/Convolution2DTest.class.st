Class {
	#name : 'Convolution2DTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFExperimentalOperationModelTests'
}

{ #category : 'Tests' }
Convolution2DTest >> testConvoluteFloatsInput [

	| inputShape filterShape input filters conv |

	inputShape := TensorShape numberOfBatches: 1 height: 2 width: 2 channels: 1.
	input := TFTensor fromFloats: #(1 1 1 1) shape: inputShape.
	
	filterShape :=
		TensorShape numberOfBatches: 1 height: 1 width: inputShape dimensionSizes last channels: 2.
	filters := TFTensor fromFloats: #(2 2) shape: filterShape.
	
	conv :=
		tf compute: (
			Convolution2D
				on: tf
				filtering: input
				with: filters
				shiftedBy: #(1 1)
				paddedAccording: Convolution2D paddingToSameInputAndOutputSize).
	
	self
		assert: conv type equals: input type;
		assert: conv shape equals: (TensorShape numberOfBatches: 1 height: 2 width: 2 channels: 2);
		assert: conv allElements equals: #(2 2 2 2 2 2 2 2)
]

{ #category : 'Tests' }
Convolution2DTest >> testConvoluteIntegersInput [

	| inputShape filterShape input filters conv |

	inputShape := TensorShape numberOfBatches: 1 height: 1 width: 1 channels: 1.
	input := TFTensor fromInt32s: #(1) shape: inputShape.
	
	filterShape :=
		TensorShape numberOfBatches: 1 height: 1 width: inputShape dimensionSizes last channels: 2.
	filters := TFTensor fromInt32s: #(2 2) shape: filterShape.
	
	conv :=
		tf compute: (
			Convolution2D
				on: tf
				filtering: input
				with: filters
				shiftedBy: #(1 1)
				paddedAccording: Convolution2D paddingToSameInputAndOutputSize).
	
	self
		assert: conv type equals: input type;
		assert: conv shape equals: (TensorShape numberOfBatches: 1 height: 1 width: 1 channels: 2);
		assert: conv allElements equals: #(2 2)
]
