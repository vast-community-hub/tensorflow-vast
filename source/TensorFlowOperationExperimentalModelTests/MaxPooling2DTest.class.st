Class {
	#name : 'MaxPooling2DTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationExperimentalModelTests'
}

{ #category : 'Tests' }
MaxPooling2DTest >> testMaxPooling3x3Input [

	| inputShape input maxPooled |

	inputShape := TensorShape numberOfBatches: 1 height: 3 width: 3 channels: 1.
	input := TFTensor fromFloats: #(1 2 3 4 5 6 7 8 9) shape: inputShape.

	maxPooled :=
		tf compute: (
			MaxPooling2D
				on: tf
				reducing: input
				inWindowsOf: #(2 2)
				shiftedBy: #(1 1)
				paddingAccording: 'VALID').
	self
		assert: maxPooled type equals: input type;
		assert: maxPooled shape
			equals: (TensorShape numberOfBatches: 1 height: 2 width: 2 channels: 1);
		assert: maxPooled allElements equals: #(5 6 8 9)
]

{ #category : 'Tests' }
MaxPooling2DTest >> testMaxPooling3x4Input [

	| inputShape input maxPooled |

	inputShape := TensorShape numberOfBatches: 1 height: 3 width: 4 channels: 1.
	input := TFTensor fromFloats: #(1 2 3 4 5 6 7 8 9 10 11 12) shape: inputShape.

	maxPooled :=
		tf compute: (
			MaxPooling2D
				on: tf
				reducing: input
				inWindowsOf: #(2 2)
				shiftedBy: #(1 1)
				paddingAccording: 'VALID').
	self
		assert: maxPooled type equals: input type;
		assert: maxPooled shape
			equals: (TensorShape numberOfBatches: 1 height: 2 width: 3 channels: 1);
		assert: maxPooled allElements equals: #(6 7 8 10 11 12)
]

{ #category : 'Tests' }
MaxPooling2DTest >> testMaxPooling4x4Input [

	| inputShape input maxPooled |

	inputShape := TensorShape numberOfBatches: 1 height: 4 width: 4 channels: 1.
	input := TFTensor fromFloats: #(1 0 2 3 4 6 6 8 3 1 1 0 1 2 2 4) shape: inputShape.

	maxPooled :=
		tf compute: (
			MaxPooling2D
				on: tf
				reducing: input
				inWindowsOf: #(2 2)
				shiftedBy: #(2 2)
				paddingAccording: 'VALID').
	self
		assert: maxPooled type equals: input type;
		assert: maxPooled shape
			equals: (TensorShape numberOfBatches: 1 height: 2 width: 2 channels: 1);
		assert: maxPooled allElements equals: #(6 8 3 4)
]

{ #category : 'Tests' }
MaxPooling2DTest >> testPaddingToSameInputAndOutputSize [

	| inputShape input maxPooled |

	inputShape := TensorShape numberOfBatches: 1 height: 3 width: 3 channels: 1.
	input := TFTensor fromFloats: #(1 2 3 4 5 6 7 8 9) shape: inputShape.

	maxPooled :=
		tf compute: (
			MaxPooling2D
				on: tf
				reducing: input
				inWindowsOf: #(2 2)
				shiftedBy: #(1 1)
				paddingAccording: Conv2D paddingToSameInputAndOutputSize).
				
	self
		assert: maxPooled type equals: input type;
		assert: maxPooled shape
			equals: (TensorShape numberOfBatches: 1 height: 3 width: 3 channels: 1);
		assert: maxPooled allElements equals: #(5 6 6 8 9 9 8 9 9)
]
