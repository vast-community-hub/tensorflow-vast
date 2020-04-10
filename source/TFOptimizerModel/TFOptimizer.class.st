Class {
	#name : 'TFOptimizer',
	#superclass : 'Object',
	#category : 'TFOptimizerModel'
}

{ #category : 'Applying' }
TFOptimizer >> apply: aGradient to: aVariable [

	self subclassResponsibility
]
