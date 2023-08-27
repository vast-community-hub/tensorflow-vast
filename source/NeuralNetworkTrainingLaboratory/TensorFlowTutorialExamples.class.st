Class {
	#name : 'TensorFlowTutorialExamples',
	#superclass : 'Object',
	#category : 'NeuralNetworkTrainingLaboratory'
}

{ #category : 'Examples' }
TensorFlowTutorialExamples class >> classifyingClothesImages [
	" Example from https://www.tensorflow.org/tutorials/keras/classification.
	The idea is to get the same results as the Experiment 2 in
	https://colab.research.google.com/drive/1wC0GzDcgHwf227Ivs5TIbirBPD3BqBdg#scrollTo=4M3Oli63F06p
	"

	| tf sample model summary |

	tf := TensorFlowComputation new.

	sample :=
		(SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features / 255.0]
			transformingLabelsWith: [:labels | labels]
			applying: [:dataset | dataset inBatchesOf: 32])
				bindSetsFrom: DatasetProvider current fashionDataset.

	model :=
		(SequentialModelBuilder on: tf)
			addFlattenLayerSized: #(28 28) asTensorShape;
			addDenseLayerSized: 128 builtWith: [:layer | layer activatedByRelu];
			addDenseLayerSized: 10 builtWith: [:layer | ];
			buildApplyingToLogits: [:logits | logits].

	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: Adam new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			trackMetricWith: SparseCategoricalPredictionAccuracyTracker new;
			trackMetricWith: (TensorboardExperimentTracker storingTo: 'experiment-2/vast');
			train: model toFit: sample.

	summary inspect.

	^TrainingSummaryMetricsDumper new
		stringOfMetricsIn: summary
		knownAs: { 'loss' .  SparseCategoricalPredictionAccuracyTracker metricKey } 
]
