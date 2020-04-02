Extension {
	#name : 'TFAttrMetadata'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFAttrMetadata >> _type [
	^ self uint32At: #type
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isBoolean [
	^ self type = 3
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isFloat [
	^ self type = 2
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isFunc [
	^ self type = 8
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isInt [
	^ self type = 1
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFAttrMetadata >> isList [

	^self bool8At: #is_list
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isPlaceholder [
	^ self type = 7
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isShape [
	^ self type = 5
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isString [
	^ self type = 0
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isTensor [
	^ self type = 6
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFAttrMetadata >> isType [
	^ self type = 4
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFAttrMetadata >> listSize [
	^ self int64At: #list_size
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFAttrMetadata >> totalSize [
	^ self int64At: #total_size
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFAttrMetadata >> type [
	"This method was automatically generated. See TFAttrMetadata class>>fields."

	^ self _type \\ 256
]
