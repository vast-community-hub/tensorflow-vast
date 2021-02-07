Class {
	#name : 'SampleDatasetDumper',
	#superclass : 'Object',
	#category : 'DatasetProviderModel'
}

{ #category : 'Transforming' }
SampleDatasetDumper >> dump: aSampleDataset to: aTensorFlowComputation [

	| adapter |

	adapter := SampleDatasetComputationAware new.
	aSampleDataset withTrainingDatasetDo: [:features :labels | | featuresNode labelsNode |
		featuresNode :=
			((aTensorFlowComputation constantWith: features) reshapeTo: features shape flattened) /
				255.0 asTensor.
		labelsNode := aTensorFlowComputation constantWith: labels.

		adapter bindTrainingDatasetTo: (
			(TensorDataset
				on: aTensorFlowComputation
				slicingAll: (Array with: featuresNode with: labelsNode))
					inBatchesOf: 32)].
	^adapter
]
