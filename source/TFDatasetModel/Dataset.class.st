Class {
	#name : 'Dataset',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'cardinality'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Accessing' }
Dataset >> cardinality [

	cardinality isNil
		ifTrue: [
			cardinality :=
				self currentComputation
					newOperationOf: 'DatasetCardinality'
					namePrefixed: 'cardinality'
					with: self].
	^cardinality
]

{ #category : 'Accessing' }
Dataset >> outputDomains [

	self subclassResponsibility
]
