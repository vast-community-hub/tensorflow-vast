Class {
	#name : 'PseudorandomTensorGenerator',
	#superclass : 'Object',
	#category : 'TensorFlowOperationRandomModel'
}

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> binomialTensorOn: aTensorFlowComputation shaped: aTensorShape withProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
PseudorandomTensorGenerator >> glorotFactorBasedOn: aTensorShape [

	| fanOut fanIn |

	fanIn := fanOut := nil.
	aTensorShape representsScalar
		ifTrue: [fanIn := fanOut := 1]
		ifFalse: [
			aTensorShape representsVector
				ifTrue: [fanIn := fanOut := aTensorShape dimensionSizes first]
				ifFalse: [
					aTensorShape representsMatrix
						ifTrue: [
							fanIn := aTensorShape dimensionSizes first.
							fanOut := aTensorShape dimensionSizes second]
						ifFalse: [| receptiveFieldSize inputDepth outputDepth |
							"Copied from https://github.com/tensorflow/tensorflow/blob/8cae746d8449c7dda5298327353d68613f16e798/tensorflow/python/keras/initializers/initializers_v2.py#L991 # Assuming convolution kernels shape (2D, 3D, or more). kernel shape: (..., input_depth, depth)"
							receptiveFieldSize :=
								(1 to: aTensorShape dimensionSizes size - 2)
									inject: 1
									into: [:receptiveSize :size | receptiveSize * size].
							inputDepth :=
								aTensorShape dimensionSizes
									at: (aTensorShape dimensionSizes size - 2).
							outputDepth := aTensorShape dimensionSizes last.
							fanIn := receptiveFieldSize * inputDepth.
							fanOut := receptiveFieldSize * outputDepth]]].
	^2 / (fanIn + fanOut)
]

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> glorotNormalTensorOn: aComputation shaped: aTensorShape [

	| scale stddev |

	scale := self glorotFactorBasedOn: aTensorShape.
	stddev := scale sqrt / 0.87962566103423978. " Constant from https://github.com/tensorflow/tensorflow/blob/8cae746d8449c7dda5298327353d68613f16e798/tensorflow/python/ops/init_ops_v2.py#L593 "
	
	^self truncatedNormalTensorOn: aComputation shaped: aTensorShape centeredOn: 0 spreadedBy: stddev
]

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> glorotUniformTensorOn: aComputation shaped: aTensorShape [

	| scale stddev |

	scale := self glorotFactorBasedOn: aTensorShape.
	stddev := (3 * scale) sqrt.
	
	^self
		uniformTensorOn: aComputation
		shaped: aTensorShape
		boundedBetween: stddev negated
		and: stddev
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
PseudorandomTensorGenerator >> rescale: aTensor centeredTo: aMeanValue spreadedBy: aStandardDeviation on: aComputation [


	| stddev mean |

	mean := ConstantTensor on: aComputation with: aMeanValue asFloatTensor.
	stddev := ConstantTensor on: aComputation with: aStandardDeviation asFloatTensor.
	^ ( ElementWiseMultiplication of: aTensor and: stddev ) + mean
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
PseudorandomTensorGenerator >> truncatedNormalTensorOn: aComputation shaped: aTensorShape [

	self subclassResponsibility
]

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> truncatedNormalTensorOn: aComputation shaped: aTensorShape centeredOn: aMeanValue spreadedBy: aStandardDeviation [


	^self
		rescale: (self truncatedNormalTensorOn: aComputation shaped: aTensorShape)
		centeredTo: aMeanValue
		spreadedBy: aStandardDeviation
		on: aComputation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
PseudorandomTensorGenerator >> uniformTensorOn: aComputation shaped: aTensorShape [

	self subclassResponsibility
]

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> uniformTensorOn: aComputation shaped: aTensorShape boundedBetween: aMinimumValue and: aMaximumValue [

	^self
		rescale: (self uniformTensorOn: aComputation shaped: aTensorShape)
		centeredTo: aMinimumValue
		spreadedBy: (aMaximumValue - aMinimumValue)
		on: aComputation
]
