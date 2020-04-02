Extension {
	#name : 'CgScreen'
}

{ #category : '*TensorFlowVASTApp',
 #vaCategories : ['CG-Internal'],
  #vaVisibility : 'private' }
CgScreen >> osGetImageData2: osDrawable x: x y: y width: w height: h pad: pad [
	"Answer a ByteArray containing the image data of the given area
of an OSDrawable.  Answer nil if the data could not be copied."

	| imagePtr srcBpl srcDataPtr destBpl destBpp destData destIndex srcX srcY |

	imagePtr :=
		self display handle
			xGetImage: osDrawable
			x: x
			y: y
			width: w
			height: h
			planeMask: -1
			format: ZPixmap.
	imagePtr isNull ifTrue: [^nil].
	srcBpl := imagePtr bytesPerLine.
	srcDataPtr := imagePtr data.
	destBpl := w * imagePtr depth + 7 // 8.
	destBpl := (destBpl + pad - 1) // pad * pad.
	destBpp := (imagePtr depth) / 8.
	destData := ByteArray new: destBpl * h.
	srcX := 0.
	srcY := 0.
	destIndex := 0.
	h timesRepeat: [| destOffset |
		destOffset := 0.
		w timesRepeat: [| valPx r g b |
			valPx := imagePtr xGetPixel: srcX y: srcY.

			b := valPx bitAnd: 16rFF.
			g := (valPx bitAnd: 16rFF00) bitShift: -8.
			r := (valPx bitAnd: 16rFF0000) bitShift: -16.

			destData at: (destIndex + destOffset + 1) put: r asInteger.
			destData at: (destIndex + destOffset + 2) put: g asInteger.
			destData at: (destIndex + destOffset + 3) put: b asInteger.

			destOffset := destOffset + destBpp.
			srcX := srcX + 1].
		destIndex := destIndex + destBpl.
		srcY := srcY + 1.
		srcX := 0

		].
	imagePtr xDestroyImage.
	^destData
]
