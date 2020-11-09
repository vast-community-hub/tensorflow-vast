Class {
	#name : 'ObjectDetectionImageRenderer',
	#superclass : 'Object',
	#instVars : [
		'imageFile',
		'imageSize',
		'imageResults'
	],
	#pools : [
		'CgConstants'
	],
	#category : 'TensorFlowExamplesApp'
}

{ #category : 'run' }
ObjectDetectionImageRenderer >> displayImageInWindow [

	| pixmap |

	pixmap := self processResultsAndDrawBoxes.

	"Hack..on Linux we have an issue with images being displayed as black and white
	 so we added this new method (suffix 2) as a temporal workaround. For more details
	 ask Mariano and check email '[IMPORTANT] PLEASE HELP on image for ESUG DEMO' "
	System osType = 'Linux'
		ifTrue: [
			CgImageViewer new
				viewImage: (pixmap getDeviceIndependentImage2: pixmap rectangle);
				open]
		ifFalse: [
			CgImageViewer new
				viewImage: (pixmap getDeviceIndependentImage: pixmap rectangle);
				open]
]

{ #category : 'run' }
ObjectDetectionImageRenderer >> dumpImageToNewFile [

	| pixmap |

	pixmap := self processResultsAndDrawBoxes.
	pixmap
		wbSaveToFile: ((self imageFile splitOn: $\) last readStream upTo: $.) , '_boxes.jpg'
		usingFormat: CgJPEGFileFormat
		depth: 24
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageFile [
	^imageFile
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageFile: anObject [
	imageFile := anObject
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageResults [
	^imageResults
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageResults: anObject [
	imageResults := anObject
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageSize [
	^imageSize
]

{ #category : 'accessing' }
ObjectDetectionImageRenderer >> imageSize: anObject [
	imageSize := anObject
]

{ #category : 'run' }
ObjectDetectionImageRenderer >> printImageDetails [

	Transcript
		cr;
		show: 'Image: ' , imageFile asString;
		cr;
		show: 'Used image size: ' , imageSize printString;
		cr;
		show: 'Objects detected: ' , imageResults count printString;
		cr;
		show: 'Labels: ' , imageResults classes printString;
		cr;
		show: 'Scores: ' , imageResults scores printString;
		cr
]

{ #category : 'processing' }
ObjectDetectionImageRenderer >> processResultsAndDrawBoxes [

	| image pixmap gc boxesAndHigherScore |

	boxesAndHigherScore := Dictionary new.
	image := (CgPixmap imageFromFile: imageFile) scaledTo: imageSize.
	pixmap := CgPixmap fromImage: image.
	gc :=
		pixmap
			createGC: ((GCForeground bitOr: GCBackground) bitOr: GCLineWidth)
			values: (
				CgGCValues new
					lineWidth: 4;
					foreground: (image palette nearestPixelValue: Color green);
					background: (image palette nearestPixelValue: Color red)).

	gc setForeground: (CgIndexedPalette default nearestPixelValue: Color green).

	"This is a complete hack...but the thing is that if an object is recognized 
	 with multiple different labels/scores, I just want to render the highest one
	 because else it uses too much space of the image."
	imageResults boxes doWithIndex: [:each :index |
		boxesAndHigherScore at: each ifAbsentPut: [imageResults scores at: index].
		(imageResults scores at: index) > (boxesAndHigherScore at: each)
			ifTrue: [boxesAndHigherScore at: each put: (imageResults scores at: index)]].

	imageResults boxes doWithIndex: [:aBox :index |
		"read above comment...we only want to render the highest score"
		((imageResults scores at: index) = (boxesAndHigherScore at: aBox))
			ifTrue: [
				pixmap
					drawString: gc
					x: (aBox first * imageSize x) asInteger
					y: (aBox second * imageSize y) asInteger - 10
					string:
						(imageResults classes at: index) , ' %' ,
							((imageResults scores at: index) * 100 roundTo: 0.01) asString.
				pixmap
					drawRectangle: gc
					x: (aBox first * imageSize x) asInteger
					y: (aBox second * imageSize y) asInteger
					width: (aBox third - aBox first * imageSize x) abs asInteger
					height: (aBox fourth - aBox second * imageSize y) abs asInteger

				]].
	^pixmap
]
