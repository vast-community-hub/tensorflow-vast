Class {
	#name : 'TensorShapeTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'Tests' }
TensorShapeTest >> testMatrixShape [

	| shape |

	shape := TensorShape matrixSized: 2 by: 3.

	self
		assert: shape dimensionSizes equals: #(2 3);
		deny: shape representsScalar;
		deny: shape representsVector;
		assert: shape representsMatrix;
		assert: shape totalAmountOfElements equals: 6;
		assert: shape size equals: 2;
		assert: shape rank equals: 2;
		assert: shape description equals: '2x3 matrix';
		deny: shape isCompatibleWithNHWShapes;
		assert: shape flattened equals: (TensorShape vectorSized: 6);
		assert: shape withUnknowBatchDimension equals: (TensorShape withDimensionsSized: { -1. 2. 3 })
]

{ #category : 'Tests' }
TensorShapeTest >> testScalarShape [

	| shape |

	shape := TensorShape scalar.

	self
		assert: shape dimensionSizes isEmpty;
		assert: shape representsScalar;
		deny: shape representsVector;
		deny: shape representsMatrix;
		assert: shape totalAmountOfElements equals: 1;
		assert: shape size equals: 0;
		assert: shape rank equals: 0;
		assert: shape description equals: 'Scalar';
		deny: shape isCompatibleWithNHWShapes;
		assert: shape flattened equals: TensorShape scalar;
		assert: shape withUnknowBatchDimension equals: (TensorShape withDimensionsSized: { -1 })
]

{ #category : 'Tests' }
TensorShapeTest >> testThreeDimensionalShape [

	| shape |

	shape := TensorShape withDimensionsSized: #(5 2 3).

	self
		assert: shape dimensionSizes equals: #(5 2 3);
		deny: shape representsScalar;
		deny: shape representsVector;
		deny: shape representsMatrix;
		assert: shape totalAmountOfElements equals: 30;
		assert: shape size equals: 3;
		assert: shape rank equals: 3;
		assert: shape description equals: '(5 2 3)';
		assert: shape isCompatibleWithNHWShapes;
		assert: shape flattened equals: (TensorShape matrixSized: 5 by: 6); 
		assert: shape batchDimension equals: 5; 
		assert: shape nonBatchDimensions equals: { 2. 3 }; 
		assert: shape nonBatchDimensionsSize equals: 2*3
]

{ #category : 'Tests' }
TensorShapeTest >> testVectorShape [

	| shape |

	shape := TensorShape vectorSized: 4.

	self
		assert: shape dimensionSizes equals: #(4);
		deny: shape representsScalar;
		assert: shape representsVector;
		deny: shape representsMatrix;
		assert: shape totalAmountOfElements equals: 4;
		assert: shape size equals: 1;
		assert: shape rank equals: 1;
		assert: shape description equals: 'Vector size 4';
		deny: shape isCompatibleWithNHWShapes;
		assert: shape flattened equals: (TensorShape vectorSized: 4)
]
