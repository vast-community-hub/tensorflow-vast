Class {
	#name : 'TFOperationDescription',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOperationDescription class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFOperationDescription class >> new [

	^super new initialize
]

{ #category : 'accessing' }
TFOperationDescription >> add: input [
	self library description: self add: input
]

{ #category : 'inputs' }
TFOperationDescription >> addControlInput: aTFOutputOrInput [
	^ self library description: self addControlInput: aTFOutputOrInput
]

{ #category : 'inputs' }
TFOperationDescription >> addInput: aTFOutputOrInput [
	^ self library description: self addInput: aTFOutputOrInput
]

{ #category : 'inputs' }
TFOperationDescription >> addInputFromOutput: indexInteger of: aTFOperation [
	| input |
	input := aTFOperation input: indexInteger.
	[ self library description: self addInput: input ]
		ensure: [ input free ]
]

{ #category : 'inputs' }
TFOperationDescription >> addInputs: anArrayOfTFOutput [
	| inputs |
	inputs := TFOutputArray externalFromArray: anArrayOfTFOutput.
	self library
		description: self
		addInputs: inputs
		size: anArrayOfTFOutput size
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putBoolean: value [
	self library description: self set: attribute asAsciiZ toBool: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putFloat: value [
	self library
		description: self
		set: attribute asAsciiZ
		toFloat: value asFloat
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putInt: value [
	self library description: self set: attribute asAsciiZ toInt64: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putShape: aTensorShape [
	| status value |
	value := aTensorShape asInt64Array.
	status := TFStatus create.
	self library
		description: self
		set: attribute asAsciiZ
		toShape: value
		size: aTensorShape size.
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> at: aString putShapes: aListOfShapes [

	| status shapes shapeSizes |

	shapes := aListOfShapes collect: #asInt64Array.
	shapeSizes := aListOfShapes collect: #rank.
	status := TFStatus create.
	self library
		description: self
		set: aString asAsciiZ
		toShapes: (Int64Array externalFromArray: shapes)
		sizesOfEach: (Int32Array externalFromArray: shapeSizes)
		size: aListOfShapes size.
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putString: aString [
	| status |
	status := TFStatus create.
	self library
		description: self
		set: attribute asAsciiZ
		toString: aString
		size: aString size.
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putStrings: anArrayOfStrings [
	| status sizes strings pointers |
	sizes := anArrayOfStrings collect: [ :str | str size ].
	sizes := Int64Array externalFromArray: sizes.
	sizes useFinalization.
	strings := anArrayOfStrings
		collect: [ :each | (self library externalizeString: each) ].
	pointers := ByteArray new: ExternalWordArray fixedSize * strings size.
	1 to: strings size do: [:index |
			pointers pointerAt: (index - 1) * ExternalWordArray fixedSize put: (strings at: index) ].
	status := TFStatus create.
	self library
		description: self
		set: attribute asAsciiZ
		toStrings: pointers
		sizes: sizes
		count: anArrayOfStrings size.
	strings do: [:each | each free].
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putTensor: aTFTensor [
	| status |
	status := TFStatus create.
	self library
		description: self
		set: attribute asAsciiZ
		toTensor: aTFTensor
		status: status.
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putType: value [
	self library description: self set: attribute asAsciiZ toType: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: anAttributeName putTypes: aListOfTypes [

	| status |

	status := TFStatus create.
	self library
		description: self
		set: anAttributeName
		toTypes: (Int32Array externalFromArray: aListOfTypes)
		size: aListOfTypes size.
	status check
]

{ #category : 'attributes' }
TFOperationDescription >> device: aString [
	^ self library description: self setDevice: aString
]

{ #category : 'accessing' }
TFOperationDescription >> finish [
	| answer status |
	status := TFStatus create.
	answer := self library finishOperation: self status: status.
	self makeNull.
	status check.
	^ answer

]
