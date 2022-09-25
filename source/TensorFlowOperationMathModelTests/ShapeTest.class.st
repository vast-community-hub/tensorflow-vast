Class {
	#name : 'ShapeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
ShapeTest >> testOperationName [

	| shape |

	shape := ShapeOperation named: 'my-shape' of: (tf floatConstantWith: #((1) (2))).
	self assert: shape operationName equals: 'my-shape'.

	shape := ShapeOperation of: (tf floatConstantWith: #((1) (2))).
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

	self assertOutputOf: (ShapeOperation of: (tf constantWith: scalar)) isIntegerVectorEqualsTo: expectedShape.
	self
		assertOutputOf: (ShapeOperation of: (tf variableNamed: 'input' with: scalar))
		isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: ((ShapeOperation of: (tf floatInputNamed: 'x')))
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

	self assertOutputOf: (ShapeOperation of: (tf constantWith: scalar)) isIntegerVectorEqualsTo: expectedShape.
	self
		assertOutputOf: (ShapeOperation of: (tf variableNamed: 'input' with: scalar))
		isIntegerVectorEqualsTo: expectedShape.
	self
		assert: (
			tf
				compute: ((ShapeOperation of: (tf floatInputNamed: 'x')))
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

	shapeOfConstant := ShapeOperation of: (tf constantWith: scalar).
	shapeOfVariable := ShapeOperation of: (tf variableNamed: 'input' with: scalar).
	shapeOfInput := (ShapeOperation of: (tf floatInputNamed: 'x')).
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
