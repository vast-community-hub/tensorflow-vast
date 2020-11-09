"
This is a Tensorflow detection model zoo, a pre-trained on the COCO dataset, 
the Kitti dataset, the Open Images dataset, the AVA v2.1 dataset 
and the iNaturalist Species Detection Dataset. 
For more details see: 
https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md

You can see a Python code for it in this jupyter notebook:
https://github.com/tensorflow/models/blob/477ed41e7e4e8a8443bc633846eb01e2182dc68a/object_detection/object_detection_tutorial.ipynb

You can download extra models from here:
https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md#coco-trained-models


One image image example:

```
ObjectDetectionZoo new
	imageFiles: OrderedCollection new;
	addImageFile: 'examples\objectDetectionZoo\images\000000562059.jpg';
	prepareImageInput;
	prepareSession;
	predict;
	openPictureWithBoundingBoxesAndLabel
```

Multi-image example:

```
ObjectDetectionZoo new
	imageFiles: OrderedCollection new;
	addImageFile: 'examples\objectDetectionZoo\images\000000562059.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000560256.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000581615.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000579635.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000581357.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000569059.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000553221.jpg';
	prepareImageInput;
	prepareSession;
	predict;
	openPictureWithBoundingBoxesAndLabel
```	

Multi-image and another downloaded model (this one is slower but has better results):

```
ObjectDetectionZoo new
	imageFiles: OrderedCollection new;
	graphFile: 'z:\Instantiations\TensorFlow\faster_rcnn_inception_resnet_v2_atrous_coco_2018_01_28\frozen_inference_graph.pb';
	addImageFile: 'examples\objectDetectionZoo\images\000000463849.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000102331.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000079651.jpg';
	addImageFile: 'examples\objectDetectionZoo\images\000000045472.jpg';
	prepareImageInput;
	prepareSession;
	predict;
	openPictureWithBoundingBoxesAndLabel
```	



"
Class {
	#name : 'ObjectDetectionZoo',
	#superclass : 'FrozenImagePredictor',
	#instVars : [
		'results'
	],
	#category : 'TensorFlowExamplesApp'
}

{ #category : 'helpers' }
ObjectDetectionZoo >> colorToArray: aColor [
	^Array 
		with: aColor red // 16r100
		with: aColor green // 16r100
		with: aColor blue // 16r100
]

{ #category : 'helpers' }
ObjectDetectionZoo >> imageToArray: image [

	| answer |

	answer := OrderedCollection new: imageSize y * imageSize x.
	0 to: imageSize x - 1 do: [:x | | p |
		0 to: imageSize y - 1 do: [:y |
			p := image getColor: x y: y.
			answer add: (self colorToArray: p)]].

	^answer
]

{ #category : 'initialization' }
ObjectDetectionZoo >> initialize [
	"Be careful because imageSize depends on the proto buffer used,
	so you must check its documentation for a correct size"

	super initialize. 
	graphFile := 'examples\objectDetectionZoo\ssd_mobilenet_v1_coco_2018_01_28\frozen_inference_graph.pb'.
	labelsFile := 'examples\objectDetectionZoo\mscoco_label_map.pbtxt'.
	self addImageFile: 'examples\objectDetectionZoo\images\000000581615.jpg'


]

{ #category : 'run' }
ObjectDetectionZoo >> openPictureWithBoundingBoxesAndLabel [

	| labels |

	labels := self readLabels.
	imageFiles doWithIndex: [:imageFile :index | | imageResults imageRenderer |
		imageResults := ObjectDetectionImageResults new.
		imageResults
			count: (results first asNumbers at: index) asInteger;
			boxes: ((results second asNumbers at: index) first: imageResults count);
			scores: ((results third asNumbers at: index) first: imageResults count);
			classes: (
				((results fourth asNumbers at: index) first: imageResults count)
					collect: [:each | labels at: each asInteger]).
		imageRenderer := ObjectDetectionImageRenderer new.
		imageRenderer
			imageFile: imageFile;
			imageSize: imageSize;
			imageResults: imageResults;
			displayImageInWindow]
]

{ #category : 'run' }
ObjectDetectionZoo >> predict [
	" see https://github.com/tensorflow/models/blob/master/research/object_detection/object_detection_tutorial.ipynb
	 Specially run_inference_for_single_image()
	 
	 This implementation can only handle box outputs (not mask outputs),
	 as such,  'detection_masks' is not a valid operation name.
	 It should be used for mask outputs.
	 
	 This depends on the model you use
	"

	| inputs outputs |

	inputs := Array with: ((graph operationNamed: 'image_tensor') input: 0).
	outputs := #('num_detections' 'detection_boxes' 'detection_scores' 'detection_classes').
	outputs := outputs collect: [:name | (graph operationNamed: name) output: 0].
	results := graph runInputs: inputs values: (Array with: inputValues) outputs: outputs.
	^results
]

{ #category : 'initialization' }
ObjectDetectionZoo >> prepareImageInput [

	| images |

	"If the user supplies more than one image, then we scale all of them to be 
	 640@480 because we can't specify multiple image sizes to TensorFlow. 
	 If the user specified only image, then we don't scale it and we pass
	 its original size to TensorFlow"

	self imageFiles size > 1
		ifTrue: [
			imageSize := 640 @ 480.
			images := self scaledImages]
		ifFalse: [| image |
			image := CgPixmap imageFromFile: self imageFiles first.
			imageSize := image width @ image height.
			images := self images].
	inputValues :=
		TFTensor
			fromNumbers: images
			type: TFTensor typeUInt8
			shape: (Array with: images size with: imageSize x with: imageSize y with: 3 "RGB")


]

{ #category : 'helpers' }
ObjectDetectionZoo >> readLabels [

	| labelsDict |

	labelsDict := Dictionary new.
	labelsFile asPath readStreamDo: [:stream |
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
					stream nextLine "}"]

			]].
	^labelsDict
]
