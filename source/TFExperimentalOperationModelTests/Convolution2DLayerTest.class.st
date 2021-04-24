Class {
	#name : 'Convolution2DLayerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFExperimentalOperationModelTests'
}

{ #category : 'Tests' }
Convolution2DLayerTest >> testInitializingKernelWithFixedTensor [

	| input layer output filter |

	input :=
		tf constantWith: (
			TFTensor
				fromFloats: #(11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44)
				shape: (TensorShape numberOfBatches: 1 height: 4 width: 4 channels: 1)).
	filter :=
		TFTensor
			fromFloats: #(0.11 0.12 0.21 0.22 1.11 1.12 1.21 1.22)
			shape: (TensorShape numberOfBatches: 2 height: 2 width: 1 channels: 2).

	layer :=
		Convolution2DLayer
			filtering: input
			withKernelLike: (
				ConvolutionKernelSpecification
					totalFilters: 2
					sized: (TensorShape matrixSized: 2 by: 2)
					initializedWith: (ConstantInitializer with: filter)).

	output := tf compute: layer.
	self assert: output shape equals: #(1 3 3 2) asTensorShape.
	self
		assert: output allElements
		isArrayCloseTo: (
			OrderedCollection new
				addAll: #(53.660004 54.32 56.300003 57 58.940002 59.68);
				addAll: #(80.06 81.12 82.700005 83.8 85.34 86.48);
				addAll: #(106.46001 107.92 109.100006 110.600006 111.740005 113.28);
				yourself)
]

{ #category : 'Tests' }
Convolution2DLayerTest >> testInitializingKernelWithGlorotNormalRandom [

	| input layer output |

	input :=
		tf constantWith: (
			TFTensor
				fromFloats: #(11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44)
				shape: (TensorShape numberOfBatches: 1 height: 4 width: 4 channels: 1)).
	layer :=
		Convolution2DLayer
			filtering: input
			withKernelLike: (
				ConvolutionKernelSpecification
					totalFilters: 2
					sized: (TensorShape matrixSized: 2 by: 2)
					initializedWith: GlorotNormalInitializer new).

	output := tf compute: layer.
	self assert: output shape equals: #(1 3 3 2) asTensorShape
]
