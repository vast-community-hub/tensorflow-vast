Class {
	#name : 'ValidationStage',
	#superclass : 'NeuralNetworkFittingStage',
	#classInstVars : [
		'default'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
ValidationStage class >> default [

	default ifNil: [default := super new].
	^default
]

{ #category : 'Instance Creation' }
ValidationStage class >> new [

	^self default
]

{ #category : 'Not categorized' }
ValidationStage >> computeBatchStepUsing: anInputAndTargetSet aggregatingLossTo: aLossCollection within: aTrainingContext [

	^aTrainingContext
		computeValidationBatchStepUsing: anInputAndTargetSet
		aggregatingLossTo: aLossCollection
]

{ #category : 'Accessing' }
ValidationStage >> description [

	^'validation'
]

{ #category : 'Testing' }
ValidationStage >> shouldBeExecutedFor: aSampleDataset [

	^aSampleDataset hasValidationSetConfigured
]

{ #category : 'Accessing' }
ValidationStage >> withSuitableSetIn: aSampleDataset do: aBlock [

	aSampleDataset withValidationDatasetDo: aBlock
]
