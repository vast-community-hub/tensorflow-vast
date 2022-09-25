Class {
	#name : 'ObjectInImageDetector',
	#superclass : 'StaticImageAnalizer',
	#instVars : [
		'labelsFile',
		'imageEncoder',
		'tf'
	],
	#category : 'NeuralNetworkTrainedExamples'
}

{ #category : 'Instance Creation' }
ObjectInImageDetector class >> example [

	ObjectInImageDetector new
		displayObjectsDetectedIn: #(
			'examples\objectDetectionZoo\images\000000560256.jpg'
			'examples\objectDetectionZoo\images\000000553221.jpg'
		)
]

{ #category : 'Instance Creation' }
ObjectInImageDetector class >> new [

	^self usingGraphDefinedIn:
		'examples\objectDetectionZoo\ssd_mobilenet_v1_coco_2018_01_28\frozen_inference_graph.pb'
]

{ #category : 'Instance Creation' }
ObjectInImageDetector class >> usingGraphDefinedIn: aProtoBufferFilePath [

	^super new initializeUsingGraphDefinedIn: aProtoBufferFilePath
]

{ #category : 'Processing' }
ObjectInImageDetector >> analizeAll: aFileNameCollection [

	^tf
		computeAllNamed: #('num_detections' 'detection_boxes' 'detection_scores' 'detection_classes')
		feedingInputsWith: (
			Dictionary new
				at: 'image_tensor' put: (imageEncoder encodeAll: aFileNameCollection);
				yourself)
]

{ #category : 'Processing' }
ObjectInImageDetector >> displayObjectsDetectedIn: aFilePathCollection [

	^self displayObjectsDetectedIn: aFilePathCollection usingLabelsDefinedIn: labelsFile
]

{ #category : 'Processing' }
ObjectInImageDetector >> displayObjectsDetectedIn: aFilePathCollection usingLabelsDefinedIn: aLabelsFile [

	| labels myResults detections detectionBoxes detectionScores detectionClasses |

	myResults := self analizeAll: aFilePathCollection.
	detections := (myResults at: 'num_detections') asNumbers.
	detectionBoxes := (myResults at: 'detection_boxes') asNumbers.
	detectionScores := (myResults at: 'detection_scores') asNumbers.
	detectionClasses := (myResults at: 'detection_classes') asNumbers.

	labels := self parseLabelsIn: aLabelsFile.
	aFilePathCollection doWithIndex: [:imageFile :index | | imageResults count |
		imageResults := ObjectDetectionImageResults new.
		count := (detections at: index) asInteger.
		imageResults
			count: count;
			boxes: ((detectionBoxes at: index) first: count);
			scores: ((detectionScores at: index) first: count);
			classes: (
				((detectionClasses at: index) first: count)
					collect: [:each | labels at: each asInteger]).
		(ObjectDetectionImageRenderer new)
			imageFile: imageFile;
			imageSize: imageEncoder imageSize;
			imageResults: imageResults;
			displayImageInWindow]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ObjectInImageDetector >> initializeUsingGraphDefinedIn: aGraphFile [

	super initialize.

	tf := TensorFlowComputation on: (TFGraph fromFileNamed: aGraphFile).
	labelsFile := 'examples\objectDetectionZoo\mscoco_label_map.pbtxt'.

	imageEncoder :=
		ImageTensorEncoder new
			encodingToUnsignedSmallIntegerTensor;
			scalingImagesTo: 640 @ 480;
			vectorizingImageHorizontally;
			vectorizingColorsUsing: [:color |
				Array
					with: color red // 16r100
					with: color green // 16r100
					with: color blue // 16r100]
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
ObjectInImageDetector >> parseLabelsIn: aLabelsFile [

	| labelsDict |

	labelsDict := Dictionary new.
	aLabelsFile asPath readStreamDo: [:stream |
		[stream atEnd] whileFalse: [| line |
			line := stream nextLine trimBoth: [:char | char isSeparator].
			line = 'item {'
				ifTrue: [| id displayName |
					stream nextLine. "name"
					id :=
						((stream nextLine readStream "id"
							upTo: $:;
							upToEnd)
								trimBoth: [:char | char isSeparator])
									asNumber.
					displayName :=
						(stream nextLine readStream "display_name"
							upTo: $:;
							upToEnd)
								copyWithout: $".
					labelsDict at: id put: displayName.
					stream nextLine "}"]]].
	^labelsDict
]
