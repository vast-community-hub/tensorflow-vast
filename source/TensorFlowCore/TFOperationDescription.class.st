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

	self library description: self addInputs: anArrayOfTFOutput
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putBoolean: value [
	self library description: self set: attribute asAsciiZ toBool: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putFloat: value [

	self library description: self set: attribute asAsciiZ toFloat: value asFloat
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putInt: value [
	self library description: self set: attribute asAsciiZ toInt64: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putInts: aListOfIntegers [

	^ self library description: self set: attribute asAsciiZ toInts: aListOfIntegers
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putShape: aTensorShape [

	self library description: self set: attribute asAsciiZ toShape: aTensorShape
]

{ #category : 'attributes' }
TFOperationDescription >> at: aString putShapes: aListOfShapes [

	self library description: self set: aString asAsciiZ toShapes: aListOfShapes
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putString: aString [

	self library description: self set: attribute asAsciiZ toString: aString
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putStrings: anArrayOfStrings [

	self library description: self set: attribute asAsciiZ toStrings: anArrayOfStrings
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putTensor: aTFTensor [

	self library description: self set: attribute asAsciiZ toTensor: aTFTensor
]

{ #category : 'attributes' }
TFOperationDescription >> at: attribute putType: value [
	self library description: self set: attribute asAsciiZ toType: value
]

{ #category : 'attributes' }
TFOperationDescription >> at: anAttributeName putTypes: aListOfTypes [

	self library description: self set: anAttributeName toTypes: aListOfTypes
]

{ #category : 'attributes' }
TFOperationDescription >> device: aString [
	^ self library description: self setDevice: aString
]

{ #category : 'accessing' }
TFOperationDescription >> finish [

	^self library finishOperation: self
]
