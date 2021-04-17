Class {
	#name : 'NeuralNetworkBuilder',
	#superclass : 'Object',
	#instVars : [
		'stopCondition',
		'afterTrainingCallback',
		'epoch'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Instance Creation' }
NeuralNetworkBuilder class >> new [

	^ super new initialize
]

{ #category : 'Configuring' }
NeuralNetworkBuilder >> afterEveryTrainingDo: aBlock [

	
	afterTrainingCallback := aBlock
]

{ #category : 'Processing' }
NeuralNetworkBuilder >> buildBasedOn: aModel toFitPredictionFrom: aFeaturesCollection to: aTarget [

	^self
		train: aModel
		doing: [:trainedModel | aModel updateWeightsToFitPredictionFrom: aFeaturesCollection to: aTarget]
]

{ #category : 'Accessing' }
NeuralNetworkBuilder >> epochsTrained [

	^epoch
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
NeuralNetworkBuilder >> initialize [

	super initialize.

	self afterEveryTrainingDo: [:iter :model | ]
]

{ #category : 'Configuring' }
NeuralNetworkBuilder >> stopTrainingWhen: aStopCondition [

	stopCondition := aStopCondition
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
NeuralNetworkBuilder >> train: anInitialModel doing: aTraining [

	| trainedModel |

	epoch := 1.
	trainedModel := anInitialModel.
	afterTrainingCallback value: 0 value: trainedModel.

	[
		trainedModel := aTraining value: trainedModel.
		epoch := epoch + 1.
		afterTrainingCallback value: epoch value: trainedModel.
		stopCondition isModelWellTrainedAccording: self]
			whileFalse.

	^trainedModel
]

{ #category : 'Configuring' }
NeuralNetworkBuilder >> trainingIterations: aTrainingTimes [

	self stopTrainingWhen: (CompletedNumberOfTraining after: aTrainingTimes)
]
