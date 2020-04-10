Class {
	#name : 'MNISTLabelFile',
	#superclass : 'MNISTFile',
	#classInstVars : [
		'trainingSet',
		'testSet'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'accessing' }
MNISTLabelFile class >> magic [
	^ 2049
]

{ #category : 'accessing' }
MNISTLabelFile class >> testName [
	^ 't10k-labels-idx1-ubyte'
]

{ #category : 'accessing' }
MNISTLabelFile class >> testSet [
	
	testSet isNil ifTrue: [testSet := super testSet]. 
	^testSet
]

{ #category : 'accessing' }
MNISTLabelFile class >> trainingSet [
	
	trainingSet isNil ifTrue: [trainingSet := super trainingSet]. 
	^trainingSet
]

{ #category : 'accessing' }
MNISTLabelFile class >> trainName [
	^ 'train-labels-idx1-ubyte'
]

{ #category : 'converting' }
MNISTLabelFile >> asTensor [
	^ items asInt32Tensor 
]

{ #category : 'accessing' }
MNISTLabelFile >> at: index [
	^ items at: index
]

{ #category : 'accessing' }
MNISTLabelFile >> at: base take: batchSize [
	^ (base to: base + batchSize - 1) collect:[:index| self at: index]
]

{ #category : 'initialization' }
MNISTLabelFile >> parse: aReader [

	super parse: aReader.
	items := aReader next collect: [:each | each value]
]
