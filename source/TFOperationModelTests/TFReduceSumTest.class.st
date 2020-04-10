Class {
	#name : 'TFReduceSumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReduceSumTest >> testReduceAlongsideAxis [

	| tensor sum0 sum01 sum1 sumNone |

	tensor :=
		tf
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	sum0 := TFReduceSum valuesIn: tensor alongside: #(0).
	sum1 := TFReduceSum valuesIn: tensor alongside: #(1).
	sum01 := TFReduceSum valuesIn: tensor alongside: #(0 1).
	sumNone := TFReduceSum valuesIn: tensor alongside: #().

	self assertOutputOf: sum0 isFloatVectorCloseTo: #(6.3 3.6).
	self assertOutputOf: sum1 isFloatVectorCloseTo: #(2.3 4.3 3.3).
	self assertOutputOf: sum01 isScalarCloseTo: 9.9.
	self
		assertOutputOf: sumNone
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1.1 1.2);
				add: #(2.1 2.2);
				add: #(3.1 0.2);
				yourself)


]

{ #category : 'Test' }
TFReduceSumTest >> testReduceWithoutAxis [

	| tensor sum sum01 |

	tensor :=
		tf
			defineFloatTensorWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	sum01 := TFReduceSum valuesIn: tensor alongside: #(0 1).
	sum := TFReduceSum valuesIn: tensor.

	self assertOutputOf: sum01 isScalarCloseTo: 9.9.
	self assertOutputOf: sum isScalarCloseTo: 9.9
]
