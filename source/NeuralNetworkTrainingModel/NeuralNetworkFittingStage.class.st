Class {
	#name : 'NeuralNetworkFittingStage',
	#superclass : 'Object',
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Computing' }
NeuralNetworkFittingStage >> computeBatchStepUsing: anInputAndTargetSet aggregatingLossTo: aLossCollection within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Accessing' }
NeuralNetworkFittingStage >> description [


	self subclassResponsibility
]

{ #category : 'Accessing' }
NeuralNetworkFittingStage >> metricKeyNamed: aMetricKey [

	^'<1s>-<2s>' expandMacrosWith: self description with: aMetricKey
]

{ #category : 'Testing' }
NeuralNetworkFittingStage >> shouldBeExecutedFor: aSampleDataset [

	self subclassResponsibility
	
]

{ #category : 'Testing' }
NeuralNetworkFittingStage >> wasMetricMeasuredDuringStage: aMetricName [

	^aMetricName beginsWith: self description
]

{ #category : 'Testing' }
NeuralNetworkFittingStage >> whenTrainDo: aTrainBlock whenValidationDo: aValidationBlock [

	self subclassResponsibility
]

{ #category : 'Accessing' }
NeuralNetworkFittingStage >> withSuitableSetIn: aSampleDataset do: aBlock [

	self subclassResponsibility
]
