Class {
	#name : 'TensorDomainTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'tests' }
TensorDomainTest >> testFloatMatrixDomain [

	| domain |

	domain := TensorDomain ofFloatMatrixSized: 2 by: 1.

	self
		assert: domain shape equals: #(2 1) asTensorShape;
		assert: domain type equals: TFTensor typeFloat;
		assert: domain printString equals: 'Float 2x1 matrix'.

	self
		assert: domain withNewUnknownDimension shape equals: #(-1 2 1) asTensorShape;
		assert: domain withNewUnknownDimension type equals: TFTensor typeFloat.

	self
		assert: domain withSlicedShape shape equals: ( TensorShape vectorSized: 1 );
		assert: domain withSlicedShape type equals: TFTensor typeFloat
]

{ #category : 'tests' }
TensorDomainTest >> testFloatScalarDomain [

	| domain |

	domain := TensorDomain ofFloatScalar.

	self
		assert: domain shape representsScalar;
		assert: domain type equals: TFTensor typeFloat;
		assert: domain printString equals: 'Float Scalar'.

	self
		assert: domain withNewUnknownDimension shape equals: TensorShape unknown;
		assert: domain withNewUnknownDimension type equals: TFTensor typeFloat.

	self
		should: [ domain withSlicedShape ]
		raise: AssertionFailure
		withDescription: 'A scalar shaped can''t be sliced'
]

{ #category : 'tests' }
TensorDomainTest >> testFloatVectorDomain [

	| domain |

	domain := TensorDomain ofFloatVectorSized: 3.

	self
		assert: domain shape equals: ( TensorShape vectorSized: 3 );
		assert: domain type equals: TFTensor typeFloat;
		assert: domain printString equals: 'Float Vector size 3'.

	self
		assert: domain withNewUnknownDimension shape equals: #(-1 3) asTensorShape;
		assert: domain withNewUnknownDimension type equals: TFTensor typeFloat.

	self
		assert: domain withSlicedShape shape equals: TensorShape scalar;
		assert: domain withSlicedShape type equals: TFTensor typeFloat
]

{ #category : 'tests' }
TensorDomainTest >> testIntegerScalarDomain [

	| domain |

	domain := TensorDomain ofIntegerScalar.

	self
		assert: domain shape representsScalar;
		assert: domain type equals: TFTensor typeInt32;
		assert: domain printString equals: 'Int32 Scalar'.

	self
		assert: domain withNewUnknownDimension shape equals: TensorShape unknown;
		assert: domain withNewUnknownDimension type equals: TFTensor typeInt32.

	self
		should: [ domain withSlicedShape ]
		raise: AssertionFailure
		withDescription: 'A scalar shaped can''t be sliced'
]

{ #category : 'tests' }
TensorDomainTest >> testLargeIntegerScalarDomain [

	| domain |

	domain := TensorDomain ofLargeIntegerScalar.

	self
		assert: domain shape representsScalar;
		assert: domain type equals: TFTensor typeInt64;
		assert: domain printString equals: 'Int64 Scalar'.

	self
		assert: domain withNewUnknownDimension shape equals: TensorShape unknown;
		assert: domain withNewUnknownDimension type equals: TFTensor typeInt64.

	self
		should: [ domain withSlicedShape ]
		raise: AssertionFailure
		withDescription: 'A scalar shaped can''t be sliced'
]
