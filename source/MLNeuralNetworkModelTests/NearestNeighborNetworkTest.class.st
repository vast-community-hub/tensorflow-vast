Class {
	#name : 'NearestNeighborNetworkTest',
	#superclass : 'TestCase',
	#category : 'MLNeuralNetworkModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
NearestNeighborNetworkTest >> tensorFrom: points [

	| rank transposed |

	rank := points first size.
	transposed := OrderedCollection new.
	(1 to: rank) do: [:i | transposed add: OrderedCollection new].
	points do: [:point |
		point withIndexDo: [:value :coordinate | (transposed at: coordinate) add: value]].
	^TFTensor fromFloats: transposed
]

{ #category : 'Tests' }
NearestNeighborNetworkTest >> testNearestNeighborWithOperations [

	| plan first second third closest references tensorReference tensors predictor |

	plan := NearestNeighborNetwork new.
	first := #(0 0 0 0 0).
	second := #(1 1 3 4 2).
	third := #(8 1 3 4 2).
	
	references := Array with: first with: second with: third.
	tensorReference := self tensorFrom: references.
	tensors := references collect: [:point | self tensorFrom: (Array with: point)].
	
	predictor := [:unknown | | result |
		result := plan predict: unknown from: tensorReference.
		result first].
	
	closest := predictor value: tensors first.
	self assert: closest equals: 1.
	
	closest := predictor value: tensors second.
	self assert: closest equals: 2.
	
	closest := predictor value: tensors third.
	self assert: closest equals: 3
]
