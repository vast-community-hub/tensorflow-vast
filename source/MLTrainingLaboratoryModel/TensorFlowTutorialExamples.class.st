Class {
	#name : 'TensorFlowTutorialExamples',
	#superclass : 'Object',
	#category : 'MLTrainingLaboratoryModel'
}

{ #category : 'Examples' }
TensorFlowTutorialExamples class >> classifyingClothesImages [
	" Example from https://www.tensorflow.org/tutorials/keras/classification"

	| tf sample model summary |

	tf := TensorFlowComputation new.

	sample := DatasetProvider current fashionDatasetOn: tf.

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 128
				builtWith: [:layer |
					layer
						inputSize: 28 * 28;
						activatedByRelu];
			addDenseLayerSized: 10 builtWith: [:layer | ];
			buildApplyingToLogits: [:logits | logits softmax argMaxOnRows].

	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: AdaptiveGradient new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			train: model toFit: sample.

	^TrainingSummaryMetricsDumper new
		stringOfMetricsIn: summary
		knownAs: #('training-loss' 'training-accuracy')
]
