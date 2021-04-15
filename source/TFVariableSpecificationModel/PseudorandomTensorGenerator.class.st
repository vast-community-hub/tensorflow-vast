Class {
	#name : 'PseudorandomTensorGenerator',
	#superclass : 'Object',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
PseudorandomTensorGenerator >> glorotFactorBasedOn: aTensorShape [

	| fanOut fanIn |

	fanIn := fanOut := nil.
	aTensorShape representsScalar ifTrue: [fanIn := fanOut := 1].
	aTensorShape representsVector ifTrue: [fanIn := fanOut := aTensorShape dimensionSizes first].
	aTensorShape representsMatrix
		ifTrue: [
			fanIn := aTensorShape dimensionSizes first.
			fanOut := aTensorShape dimensionSizes second].
	fanIn isNil ifTrue: [AssertionFailure signal: 'Shape still not supported']. 
	
	^2 / (fanIn + fanOut)
]

{ #category : 'Accessing' }
PseudorandomTensorGenerator >> glorotNormalTensorOn: aComputation shaped: aTensorShape [

	| scale stddev |

	scale := self glorotFactorBasedOn: aTensorShape.
	stddev := scale sqrt / 0.87962566103423978. " Constant from https://github.com/tensorflow/tensorflow/blob/master/tensorflow/python/ops/init_ops_v2.py#L593 "
	
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

	mean := ConstantNode on: aComputation with: aMeanValue asFloatTensor.
	stddev := ConstantNode on: aComputation with: aStandardDeviation asFloatTensor.
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
