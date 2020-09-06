Class {
	#name : 'OptimizationAlgorithm',
	#superclass : 'Object',
	#category : 'TFOptimizerModel'
}

{ #category : 'Applying' }
OptimizationAlgorithm >> apply: aGradient to: aVariable [

	self subclassResponsibility
]

{ #category : 'Applying' }
OptimizationAlgorithm >> shortName [

	self subclassResponsibility
]
