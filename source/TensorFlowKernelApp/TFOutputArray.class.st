Class {
	#name : 'TFOutputArray',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowKernelApp'
}

{ #category : 'Not categorized' }
TFOutputArray class >> fields [
	"self initialize"

	^ #(#(template 'TFOutput'))
]

{ #category : 'Not categorized' }
TFOutputArray class >> initializeAfterLoad [
	"Set layout."

	self members: #(value) types: #(TFOutput).

]

{ #category : 'accessing' }
TFOutputArray >> at: anInteger [
	| size |
	size := self class fixedSize.
	^self
		arrayAt: anInteger - 1 * size
		type: TFOutput 
]

{ #category : 'accessing' }
TFOutputArray >> at: anInteger put: aTFOutput [
	| size |
	size := self class fixedSize.
	^self
		arrayAt: anInteger - 1 * size
		put: aTFOutput
		size: 1
]
