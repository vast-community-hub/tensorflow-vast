Class {
	#name : 'Conv2DTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFExperimentalOperationModelTests'
}

{ #category : 'Testing' }
Conv2DTest >> testConvoluteFloatsInput [

	| inputShape filterShape input filters conv strides anOutput |

	inputShape := TensorShape numberOfBatches: 1 height: 2 width: 2 channels: 1.
	input := ConstantNode on: tf named: 'input' shaped: inputShape filledWith: 1.0.

	filterShape :=
		TensorShape numberOfBatches: 1 height: 1 width: inputShape dimensionSizes last channels: 2.
	filters := ConstantNode on: tf named: 'filters' shaped: filterShape filledWith: 2.0.
	strides := #(1 1).
	conv :=
		Conv2D
			on: tf
			applying: filters
			to: input
			shiftingBy: strides
			paddedBy: Conv2D paddingToSameInputAndOutputSize.

	anOutput := tf compute: conv.
	self
		assert: anOutput type equals: TFTensor typeFloat;
		assert: anOutput shape
			equals: (
				Array
					with: inputShape dimensionSizes first
					with: inputShape dimensionSizes second
					with: inputShape dimensionSizes third
					with: filterShape dimensionSizes last);
		assert: anOutput allElements equals: #(2 2 2 2 2 2 2 2)
]

{ #category : 'Testing' }
Conv2DTest >> testConvoluteIntegersInput [

	| inputShape filterShape input filters conv strides anOutput |

	inputShape := TensorShape numberOfBatches: 1 height: 1 width: 1 channels: 1.
	input := ConstantNode on: tf named: 'input' shaped: inputShape filledWith: 1.

	filterShape :=
		TensorShape numberOfBatches: 1 height: 1 width: inputShape dimensionSizes last channels: 2.
	filters := ConstantNode on: tf named: 'filters' shaped: filterShape filledWith: 2.
	strides := #(1 1).
	conv :=
		Conv2D
			on: tf
			applying: filters
			to: input
			shiftingBy: strides
			paddedBy: Conv2D paddingToSameInputAndOutputSize.

	anOutput := tf compute: conv.
	self
		assert: anOutput type equals: TFTensor typeInt32;
		assert: anOutput shape
			equals: (
				Array
					with: inputShape dimensionSizes first
					with: inputShape dimensionSizes second
					with: inputShape dimensionSizes third
					with: filterShape dimensionSizes last);
		assert: anOutput allElements equals: #(2 2)
]
