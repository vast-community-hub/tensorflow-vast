Class {
	#name : 'ExternalWordArray',
	#superclass : 'TFStructure',
	#category : 'TensorFlowKernelApp'
}

{
	#category : 'instance creation'
}
ExternalWordArray class >> externalFromArray: anArray [
	| answer |
	answer := self externalNew: anArray size.
	1 to: anArray size do: [:i |
		answer at: i put: (anArray at: i)].
	^ answer
]

{
	#category : 'instance creation'
}
ExternalWordArray class >> externalNew [
	^ self shouldNotImplement
]

{
	#category : 'instance creation'
}
ExternalWordArray class >> initializeAfterLoad [
	self
		members: #(value)
		types: #(pointer)
]

{
	#category : 'instance creation'
}
ExternalWordArray class >> new [
	^ self shouldNotImplement
]

{
	#category : 'accessing'
}
ExternalWordArray >> at: index [
	^ (super at: index - 1) value
	"This method was automatically generated. See PointerArray class>>fields."
"
	^ self elementAtOffset: (index - 1) * self class byteSize + 1
	"
]

{
	#category : 'accessing'
}
ExternalWordArray >> at: index put: value [
	^ super at: index-1 put: (self class value: value)

]

{
	#category : 'accessing'
}
ExternalWordArray >> first [
	^ self at: 1
]

{
	#category : 'accessing'
}
ExternalWordArray >> first: anExternalStructure [
	self at: 1 put: anExternalStructure
]

{
	#category : 'accessing'
}
ExternalWordArray >> fourth [
	^ self at: 4
]

{
	#category : 'accessing'
}
ExternalWordArray >> second [
	^ self at: 2
]

{
	#category : 'accessing'
}
ExternalWordArray >> third [
	^ self at: 3
]
