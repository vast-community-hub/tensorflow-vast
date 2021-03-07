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
OptimizationAlgorithm >> considerCurrentEpochIn: anEpochHolder [

	" Optimizers should reimplement this method if they wanna do something 
	with the current epoch "


]

{ #category : 'Applying' }
OptimizationAlgorithm >> shortName [

	self subclassResponsibility
]
