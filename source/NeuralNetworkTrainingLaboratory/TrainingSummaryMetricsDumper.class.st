Class {
	#name : 'TrainingSummaryMetricsDumper',
	#superclass : 'Object',
	#category : 'NeuralNetworkTrainingLaboratory'
}

{ #category : 'Accessing' }
TrainingSummaryMetricsDumper >> dumpMetricsIn: aTrainingSummary knownAs: aMetricKeyCollection on: aStream [

	aMetricKeyCollection do: [:metricKey |
		aStream
			nextPutAll: metricKey;
			tab].
	aStream cr.

	1 to: aTrainingSummary epochsTrained do: [:i |
		aMetricKeyCollection do: [:metricKey |
			aStream
				print: ((aTrainingSummary trainingMetricKnownAs: metricKey) at: i);
				tab;
				print: ((aTrainingSummary validationMetricKnownAs: metricKey) at: i);
				tab].
		aStream cr]


]

{ #category : 'Accessing' }
TrainingSummaryMetricsDumper >> stringOfMetricsIn: aTrainingSummary knownAs: aMetricKeyCollection [

	^String streamContents: [:stream |
		self dumpMetricsIn: aTrainingSummary knownAs: aMetricKeyCollection on: stream]
]
