Class {
	#name : 'FlattenLayerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkLayerModelTests'
}

{ #category : 'Test' }
FlattenLayerTest >> testFlatten1DimensionTensor [

	| input layer result expectedOutput |

	input :=
		InputTensor on: tf named: 'flatten_input' of: FloatDataType new shaped: #(4) asTensorShape.

	layer := FlattenLayer receiving: input.
	result :=
		tf
			compute: layer
			feedingInputsWith: (
				(Dictionary new)
					at: 'flatten_input' put: #(1 2 3 4) asFloatTensor;
					yourself).

	expectedOutput := #((1) (2) (3) (4)).

	self assert: result isFloatTensorClosedTo: expectedOutput
]

{ #category : 'Test' }
FlattenLayerTest >> testFlatten3DimensionTensor [

	| input layer result expectedOutput |

	input :=
		InputTensor
			on: tf
			named: 'flatten_input'
			of: FloatDataType new
			shaped: #(-1 2 2) asTensorShape.

	layer := FlattenLayer receiving: input.

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'flatten_input' put: #((
	((1.11 1.12) (1.21 1.22))
	((2.11 2.12) (2.21 2.22))
	((3.11 3.12) (3.21 3.22))
)) asFloatTensor;
					yourself).
	
	expectedOutput := #(
	(1.11 1.12 1.21 1.22)
	(2.11 2.12 2.21 2.22)
	(3.11 3.12 3.21 3.22)
).

	self assert: result isFloatTensorClosedTo: expectedOutput
]

{ #category : 'Test' }
FlattenLayerTest >> testFlatten3DimensionTensorCase1 [

	| input layer result expectedOutput |

	input :=
		InputTensor
			on: tf
			named: 'flatten_input'
			of: FloatDataType new
			shaped: #(3 2 1) asTensorShape.

	layer := FlattenLayer receiving: input.

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'flatten_input' put: #(
 ((0)
  (1))
 ((2)
  (3))
 ((4)
  (5))
) asFloatTensor;
					yourself).
	
	expectedOutput := #((0 1)
 (2 3)
 (4 5)
).

	self assert: result isFloatTensorClosedTo: expectedOutput
]

{ #category : 'Test' }
FlattenLayerTest >> testFlattenMatrix [

	| input layer result |

	input :=
		InputTensor
			on: tf
			named: 'flatten_input'
			of: FloatDataType new
			shaped: #(-1 2 1) asTensorShape.

	layer := FlattenLayer receiving: input.

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'flatten_input' put: #(
	((1.1) (1.2)) 
	((2.1) (2.2))
) asFloatTensor;
					yourself).

	self assert: result isMatrixCloseTo: #((1.1 1.2) (2.1 2.2))


]
