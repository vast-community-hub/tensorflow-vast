Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFOperationDescription class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperationDescription >> add: input [
	self library description: self add: input
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['inputs'] }
TFOperationDescription >> addControlInput: aTFOutputOrInput [
	^ self library description: self addControlInput: aTFOutputOrInput
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['inputs'] }
TFOperationDescription >> addInput: aTFOutputOrInput [
	^ self library description: self addInput: aTFOutputOrInput
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['inputs'] }
TFOperationDescription >> addInputFromOutput: indexInteger of: aTFOperation [
	| input |
	input := aTFOperation input: indexInteger.
	[ self library description: self addInput: input ]
		ensure: [ input free ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['inputs'] }
TFOperationDescription >> addInputs: anArrayOfTFOutput [
	| inputs |
	inputs := TFOutputArray externalFromArray: anArrayOfTFOutput.
	self library
		description: self
		addInputs: inputs
		size: anArrayOfTFOutput size
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> at: attribute putBoolean: value [
	self library description: self set: attribute asAsciiZ toBool: value
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> at: attribute putFloat: value [
	self library
		description: self
		set: attribute asAsciiZ
		toFloat: value asFloat
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> at: attribute putInt: value [
	self library description: self set: attribute asAsciiZ toInt64: value
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> at: attribute putShape: anIntegerArray [
	| status value |
	value := Int64Array externalFromArray: anIntegerArray.
	status := TFStatus create.
	self library
		description: self
		set: attribute asAsciiZ
		toShape: value
		size: anIntegerArray size.
	status check
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> at: attribute putType: value [
	self library description: self set: attribute asAsciiZ toType: value
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
TFOperationDescription >> device: aString [
	^ self library description: self setDevice: aString
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperationDescription >> finish [
	| answer status |
	status := TFStatus create.
	answer := self library finishOperation: self status: status.
	self makeNull.
	status check.
	^ answer

]
