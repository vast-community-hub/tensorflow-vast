Class {
	#name : 'TruncatedNormalInitializer',
	#superclass : 'VariableNodeInitializer',
	#instVars : [
		'mean',
		'standardDeviation',
		'seeds'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TruncatedNormalInitializer class >> defaultMean [

	^0.0
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TruncatedNormalInitializer class >> defaultStandardDeviation [

	^1.0
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> deviatedBy: aStandardDeviation [

	^self meanOn: self defaultMean deviatedBy: aStandardDeviation
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	^self meanOn: self defaultMean deviatedBy: aStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> meanOn: aMeanValue deviatedBy: aStandardDeviation [

	^self meanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: nil
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> meanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	^super new initializeMeanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> new [

	^self meanOn: self defaultMean deviatedBy: self defaultStandardDeviation
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> withSeeds: aSeedsArray [

	^self meanOn: self defaultMean deviatedBy: self defaultStandardDeviation withSeeds: aSeedsArray
]

{ #category : 'Evaluating' }
TruncatedNormalInitializer >> applyTo: aTFVariable [

	| graph shape initialValue rnd devTensor meanTensor |

	graph := aTFVariable graph.
	shape := graph shapeOf: aTFVariable firstOutput.

	rnd :=
		seeds
			ifNil: [graph truncatedNormalRandomShaped: shape]
			ifNotNil: [graph statelessNormalRandomShaped: shape withSeeds: seeds].

	meanTensor := graph const: mean asTensor.
	devTensor := graph const: standardDeviation asTensor.

	initialValue := (ElementWiseMultiplication of: rnd and: devTensor) + meanTensor.

	aTFVariable assign: initialValue value
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TruncatedNormalInitializer >> initializeMeanOn: aMeanValue deviatedBy: aStandardDeviation withSeeds: aSeedsArray [

	mean := aMeanValue.
	standardDeviation := aStandardDeviation.
	seeds := aSeedsArray
]
