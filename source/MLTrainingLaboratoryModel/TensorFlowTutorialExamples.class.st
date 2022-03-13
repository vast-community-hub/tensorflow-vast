Class {
	#name : 'TensorFlowTutorialExamples',
	#superclass : 'Object',
	#category : 'MLTrainingLaboratoryModel'
}

{ #category : 'Examples' }
TensorFlowTutorialExamples class >> classifyingClothesImages [
		" Example from https://www.tensorflow.org/tutorials/keras/classification.
	The idea is to get the same results as the Experiment 2 in
	https://colab.research.google.com/drive/1wC0GzDcgHwf227Ivs5TIbirBPD3BqBdg#scrollTo=4M3Oli63F06p
	https://tensorboard.dev/experiment/u0UOLBLHQlmFDn1XEPfLBA/#scalars
	"

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
			minimizeSparseCategoricalCrossEntropyUsing: AdaptiveMomentEstimation new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			trackMetricWith: (TensorboardExperimentTracker storingTo: 'experiment-logs');
			train: model toFit: sample.
	
	summary inspect. 
	
	^TrainingSummaryMetricsDumper new
		stringOfMetricsIn: summary
		knownAs: #('loss' 'accuracy')
]
