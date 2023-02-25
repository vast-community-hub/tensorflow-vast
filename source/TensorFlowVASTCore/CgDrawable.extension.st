Extension {
	#name : 'CgDrawable'
}

{ #category : 'CG-Internal',
  #vaVisibility : 'private' }
CgDrawable >> getDeviceIndependentImage2: rectangle [

	"Answer a CgDeviceIndependentImage copied from the
specified area of the receiver.  The origin of the image is
at the top left, with x and y coordinates of 0.  
The rectangle must be entirely contained in the receiver's
bounds.  The width and height of the rectangle must be positive.

ARGUMENTS
rectangle	A Rectangle specifying the area to copy.

RESULT
A CgDeviceIndependentImage.
"

	| result |

	(rectangle width >= 1 and: [rectangle height >= 1])
		ifFalse: [^self error: (NlsCatCGa indexedMsg: 4)]. "$NLS$ Rectangle width and height must be positive."
	((0 @ 0 extent: self extent) contains: rectangle)
		ifFalse: [^self error: (NlsCatCGa indexedMsg: 5)]. "$NLS$ Rectangle argument must be contained in the receiver's bounds."

	server beginRequest.
	result := self osGetDeviceIndependentImage2: rectangle.
	server endRequest.
	^result
]

{ #category : 'CG-Internal',
  #vaVisibility : 'private' }
CgDrawable >> osGetDeviceIndependentImage2: rectangle [
	"Answer a CgDeviceIndependentImage copied from the area
specified by the given rectangle in the receiver.  
The rectangle must be entirely contained in the receiver's bounds.
The width and height of the rectangle must be non-negative."

	| w h d data |

	w := rectangle width.
	h := rectangle height.
	d := self depth.
	data :=
		self screen
			osGetImageData2: self handle
			x: rectangle left
			y: rectangle top
			width: w
			height: h
			pad: 4.
	data == nil ifTrue: [data := ByteArray new: (w * d + 31) // 32 * 4].
	^CgDeviceIndependentImage
		width: w
		height: h
		depth: d
		palette: self osQuerySystemPalette
		scanlinePad: 4
		data: data
]
