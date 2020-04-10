Class {
	#name : 'MNISTImageFile',
	#superclass : 'MNISTFile',
	#instVars : [
		'rows',
		'columns'
	],
	#classInstVars : [
		'trainingSet',
		'testSet'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'accessing' }
MNISTImageFile class >> magic [
	^ 2051
]

{ #category : 'accessing' }
MNISTImageFile class >> testName [
	^ 't10k-images-idx3-ubyte'
]

{ #category : 'accessing' }
MNISTImageFile class >> testSet [
	
	testSet isNil ifTrue: [testSet := super testSet]. 
	^testSet
]

{ #category : 'accessing' }
MNISTImageFile class >> trainingSet [
	
	trainingSet isNil ifTrue: [trainingSet := super trainingSet]. 
	^trainingSet
]

{ #category : 'accessing' }
MNISTImageFile class >> trainName [
	^ 'train-images-idx3-ubyte'
]

{ #category : 'converting' }
MNISTImageFile >> asTensor [

	^TFTensor fromFloats: items shape: (Array with: count with: rows * columns)
]

{ #category : 'accessing' }
MNISTImageFile >> bytesAt: imageIndex [
	| size base |
	size := columns * rows.
	base := (imageIndex - 1) * size + 1.
	^ items copyFrom: base to: base + size - 1.
]

{ #category : 'accessing' }
MNISTImageFile >> bytesAt: base take: batchSize [
	^ (base to: base + batchSize -1) collect:[:index| self bytesAt: index]
]

{ #category : 'accessing' }
MNISTImageFile >> columns [
	^ columns
]

{ #category : 'initialization' }
MNISTImageFile >> parse: aReader [

	super parse: aReader.
	rows := aReader dimensionSizes second.
	columns := aReader dimensionSizes third.
	items := aReader next.
	items :=
		(items flatCollect: [:each | each] as: OrderedCollection)
			flatCollect: [:each | each value]
			as: OrderedCollection. 
	items := items collect: [:each | each value]
]

{ #category : 'accessing' }
MNISTImageFile >> rows [
	^ rows
]
