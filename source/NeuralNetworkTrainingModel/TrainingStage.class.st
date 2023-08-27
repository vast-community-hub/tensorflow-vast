Class {
	#name : 'TrainingStage',
	#superclass : 'NeuralNetworkFittingStage',
	#classInstVars : [
		'default'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
TrainingStage class >> default [

	default ifNil: [default := super new].
	^default
]

{ #category : 'Instance Creation' }
TrainingStage class >> new [

	^self default
]

{ #category : 'Computing' }
TrainingStage >> computeBatchStepUsing: anInputAndTargetSet aggregatingLossTo: aLossCollection within: aTrainingContext [

	^aTrainingContext
		computeTrainingBatchStepUsing: anInputAndTargetSet
		aggregatingLossTo: aLossCollection
]

{ #category : 'Accessing' }
TrainingStage >> description [

	^'training'
]

{ #category : 'Testing' }
TrainingStage >> shouldBeExecutedFor: aSampleDataset [

	^aSampleDataset hasTrainingSetConfigured
]

{ #category : 'Not categorized' }
TrainingStage >> whenTrainDo: aTrainBlock whenValidationDo: aValidationBlock [

	^aTrainBlock value
]

{ #category : 'Accessing' }
TrainingStage >> withSuitableSetIn: aSampleDataset do: aBlock [

	aSampleDataset withTrainingDatasetDo: aBlock
]