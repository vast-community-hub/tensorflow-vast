Class {
	#name : 'MNISTFile',
	#superclass : 'Object',
	#instVars : [
		'count',
		'items'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'instance creation' }
MNISTFile class >> fromFile: aString [

	| file filename datasetURL |

	filename := aString , '.gz'.
	file := (FileSystemAPI current directoryNamed: 'datasets/mnist-handwritten') / filename.
	datasetURL := 'https://raw.githubusercontent.com/jvanecek/datasets/main/mnist-handwritten/' , filename.
	file := FileSystemAPI current downloadFileAt: datasetURL to: file.
	^self fromReader: (FileSystemAPI current idxReaderOn: file)
]

{ #category : 'instance creation' }
MNISTFile class >> fromReader: aReader [
	| answer |
	answer := self new.
	^ answer parse: aReader
]

{ #category : 'instance creation' }
MNISTFile class >> new [

	^super new initialize
]

{ #category : 'accessing' }
MNISTFile class >> testName [
	^ self subclassResponsibility 
]

{ #category : 'instance creation' }
MNISTFile class >> testSet [
	^self fromFile: self testName
	
]

{ #category : 'instance creation' }
MNISTFile class >> trainingSet [
	^self fromFile: self trainName
	
]

{ #category : 'accessing' }
MNISTFile class >> trainName [
	^ self subclassResponsibility 
]

{ #category : 'converting' }
MNISTFile >> asTensor [
	^ self subclassResponsibility 
]

{ #category : 'accessing' }
MNISTFile >> count [
	^ count
]

{ #category : 'accessing' }
MNISTFile >> items [
	^ items
]

{ #category : 'initialization' }
MNISTFile >> parse: aReader [
	count := (aReader dimensionSizes) at:1
]
