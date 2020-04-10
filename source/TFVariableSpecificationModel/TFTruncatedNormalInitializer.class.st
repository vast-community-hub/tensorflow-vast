Class {
	#name : 'TFTruncatedNormalInitializer',
	#superclass : 'TFVariableInitializer',
	#instVars : [
		'mean',
		'standardDeviation',
		'seeds'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFTruncatedNormalInitializer class >> defaultMean [

	^0.0
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFTruncatedNormalInitializer class >> defaultStandardDeviation [

	^1.0
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> deviatedBy: aStandardDeviation [

	^self meanOn: self defaultMean deviatedBy: aStandardDeviation
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	^self meanOn: self defaultMean deviatedBy: aStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> meanOn: aMeanValue deviatedBy: aStandardDeviation [

	^self meanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: nil
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> meanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	^super new initializeMeanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> new [

	^self meanOn: self defaultMean deviatedBy: self defaultStandardDeviation
]

{ #category : 'Instance Creation' }
TFTruncatedNormalInitializer class >> withSeeds: aSeedsArray [

	^self meanOn: self defaultMean deviatedBy: self defaultStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Evaluating' }
TFTruncatedNormalInitializer >> applyTo: aTFVariable [

	| graph shape initialValue rnd devTensor meanTensor |

	graph := aTFVariable graph.
	shape := graph shapeOf: aTFVariable firstOutput.

	rnd :=
		seeds
			ifNil: [graph truncatedNormalRandomShaped: shape]
			ifNotNil: [graph statelessNormalRandomShaped: shape withSeeds: seeds].
			
	meanTensor := graph const: mean asTensor.
	devTensor := graph const: standardDeviation asTensor.

	initialValue := TFSum of: (TFElementWiseMultiplication of: rnd and: devTensor) plus: meanTensor.

	aTFVariable assign: initialValue value
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTruncatedNormalInitializer >> initializeMeanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	mean := aMeanValue.
	standardDeviation := aStandardDeviation.
	seeds := aSeedsArray
]
