Class {
	#name : 'ShapeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
ShapeTest >> testOperationName [

	| shape |

	shape := Shape named: 'my-shape' of: (tf floatConstantWith: #((1) (2))).
	self assert: shape operationName equals: 'my-shape'.

	shape := Shape of: (tf floatConstantWith: #((1) (2))).
	self assert: shape operationName equals: 'Shape'


]

{ #category : 'Test' }
ShapeTest >> testShapeOfColumnVector [

	| scalar expectedShape |

	scalar := #((1.0) (2.0)) asFloatTensor.
	expectedShape := #(2 1).

	self assertOutputOf: (tf constantWith: scalar) shape isIntegerVectorEqualsTo: expectedShape.
	self
		assertOutputOf: (tf variableNamed: 'input' with: scalar) shape
		isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: (tf floatInputNamed: 'x') shape
				feedingInputsWith: (
					Dictionary new
						at: 'x' put: scalar;
						yourself))
		isIntegerVectorEqualsTo: expectedShape
]

{ #category : 'Test' }
ShapeTest >> testShapeOfMatrix [

	| scalar expectedShape |

	scalar := #((1.0 3.0 4.0) (2.0 0.5 -0.1)) asFloatTensor.
	expectedShape := #(2 3).

	self assertOutputOf: (Shape of: (tf constantWith: scalar)) isIntegerVectorEqualsTo: expectedShape.
	self
		assertOutputOf: (Shape of: (tf variableNamed: 'input' with: scalar))
		isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: ((Shape of: (tf floatInputNamed: 'x')))
				feedingInputsWith: (
					Dictionary new
						at: 'x' put: scalar;
						yourself))
		isIntegerVectorEqualsTo: expectedShape
]

{ #category : 'Test' }
ShapeTest >> testShapeOfRowVector [

	| scalar expectedShape |

	scalar := #(1.0 2.0) asFloatTensor.
	expectedShape := #(2).

	self assertOutputOf: (Shape of: (tf constantWith: scalar)) isIntegerVectorEqualsTo: expectedShape.
	self
		assertOutputOf: (Shape of: (tf variableNamed: 'input' with: scalar))
		isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: ((Shape of: (tf floatInputNamed: 'x')))
				feedingInputsWith: (
					Dictionary new
						at: 'x' put: scalar;
						yourself))
		isIntegerVectorEqualsTo: expectedShape
]

{ #category : 'Test' }
ShapeTest >> testShapeOfScalar [

	| scalar expectedShape shapeOfConstant shapeOfVariable shapeOfInput |

	scalar := 1.0 asFloatTensor.
	expectedShape := #().

	shapeOfConstant := Shape of: (tf constantWith: scalar).
	shapeOfVariable := Shape of: (tf variableNamed: 'input' with: scalar).
	shapeOfInput := (Shape of: (tf floatInputNamed: 'x')).
	self assertOutputOf: shapeOfConstant isIntegerVectorEqualsTo: expectedShape.
	self assertOutputOf: shapeOfVariable isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: shapeOfInput
				feedingInputsWith: (
					Dictionary new
						at: 'x' put: scalar;
						yourself))
		isIntegerVectorEqualsTo: expectedShape
]
