Class {
	#name : 'ObjectDetectionImageResults',
	#superclass : 'Object',
	#instVars : [
		'count',
		'boxes',
		'scores',
		'classes'
	],
	#category : 'TensorFlowExamplesApp'
}

{
	#category : 'instance creation'
}
ObjectDetectionImageResults class >> from: graphResults [

	^self new
		initializeFrom: graphResults;
		yourself
]

{
	#category : 'instance creation'
}
ObjectDetectionImageResults class >> new [
	"Answer a new, initialized instance"

	^super new
		initialize;
		yourself
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> boxes [
	^boxes
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> boxes: anObject [
	boxes := anObject
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> classes [
	^classes
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> classes: anObject [
	classes := anObject
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> count [
	^count
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> count: anObject [
	count := anObject
]

{
	#category : 'initialization'
}
ObjectDetectionImageResults >> initializeFrom: graphResults [

	count := graphResults first asNumbers first asInteger.
	boxes := graphResults second asNumbers first first: count.
	scores := graphResults third asNumbers first first: count.
	classes := graphResults fourth asNumbers first first: count
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> scores [
	^scores
]

{
	#category : 'accessing'
}
ObjectDetectionImageResults >> scores: anObject [
	scores := anObject
]
