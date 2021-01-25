Class {
	#name : 'TFInputArray',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowCore'
}

{ #category : 'initialization' }
TFInputArray class >> fields [
	"self initialize"

	^ #(#(template 'TFInput'))
]

{ #category : 'initialization' }
TFInputArray class >> initializeAfterLoad [
	"Set layout."

	self members: #(value) types: #(TFInput).

]

{ #category : 'accessing' }
TFInputArray >> at: anInteger [
	| size |
	size := self class fixedSize.
	^self
		arrayAt: anInteger - 1 * size
		type: TFInput 
]

{ #category : 'accessing' }
TFInputArray >> at: anInteger put: aTFInput [
	| size |
	size := self class fixedSize.
	^self
		arrayAt: anInteger - 1 * size
		put: aTFInput
		size: 1
]
