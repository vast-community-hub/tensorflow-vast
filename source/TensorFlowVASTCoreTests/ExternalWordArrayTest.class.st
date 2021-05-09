Class {
	#name : 'ExternalWordArrayTest',
	#superclass : 'TensorFlowTestCase',
	#instVars : [
		'library'
	],
	#category : 'TensorFlowVASTCoreTests'
}

{ #category : 'instance creation' }
ExternalWordArrayTest class >> new [

	^super new initialize
]

{ #category : 'testing' }
ExternalWordArrayTest >> testArray: anExternalWordArraySubclass sampleElement: anObject [
	| array size |
	size := 4.
	array := anExternalWordArraySubclass new: 4.
"	self assert: size * Smalltalk wordSize = array getHandle size.	This isn't dialect independent
"	self assert: (array first isKindOf: anObject class).
	1 to: size do: [ :index | self assert: ((array at: index) isKindOf: anObject class) ]
]

{ #category : 'testing' }
ExternalWordArrayTest >> testArrayAtPutFor: anExternalWordArraySubclass elementSample: anObject [
	| array size one |
	size := 4.
	array := anExternalWordArraySubclass externalFromArray: (Array with: anObject).
	one := array first.
	array first: anObject.
	self assert: array first equals: anObject.
	self assert: (array first isKindOf: anObject class).
	array first: one.
	self assert: array first equals: one.
	1 to: size do: [:index |
		array at: index put: anObject.
		self assert: (array at: index) equals: anObject.
		self assert: ((array at: index) isKindOf: anObject class).
		array at: index put: one.
		self assert: (array at: index) equals: one]
]

{ #category : 'testing' }
ExternalWordArrayTest >> testExternalFromArrayOperation [
	| op1 op2 array |
	op1 := TFOperation externalNew.
	op2 := TFOperation externalNew.
	array := TFOperationPtrArray
		externalFromArray: (Array with: op1 with: op2).
	self assert: array first address = op1 address.
	self assert: (array at: 2) address = op2 address.
	op1 free.
	op2 free.
]

{ #category : 'testing' }
ExternalWordArrayTest >> testExternalFromArrayOutput [
	| o1 o2 array |
	o1 := TFOutput new index: 16r40302010.
	o2 := TFOutput new index: 16r76543210.
	array := TFOutputArray externalFromArray: (Array with: o1 with: o2).
	self assert: array first index = o1 index.
	self assert: (array at: 2) index = o2 index
]

{ #category : 'testing' }
ExternalWordArrayTest >> testExternalFromArrayTensor [
	| t1 t2 array |
	t1 := TFTensor fromInt64: 16r8070605040302010.
	t2 := TFTensor fromInt64: 16rFEDCBA9876543210.
	array := TFTensorPtrArray
		externalFromArray: (Array with: t1 with: t2).
	self assert: array first address = t1 address.
	self assert: (array at: 2) address = t2 address
]

{ #category : 'testing' }
ExternalWordArrayTest >> testOperationArrayAtPut [

	| graph sample |

	graph := TFGraph create.
	sample :=
		graph
			newOperation: 'Placeholder'
			named: 'var'
			described: [:description | description at: 'dtype' putType: TFTensor typeInt64].
	self testArrayAtPutFor: TFOperationPtrArray elementSample: sample
]

{ #category : 'testing' }
ExternalWordArrayTest >> testOperationArrayElementsOfRightClass [
	^ self testArray: TFOperationPtrArray sampleElement: TFOperation new
]

{ #category : 'testing' }
ExternalWordArrayTest >> testOutputArrayAtPut [
	| array size one other operation |
	size := 4.
	array := TFOutputArray externalNew: size.
	operation := TFOperation externalNew.
	one := TFOutput externalNew.
	one index: 16r75F6F7F8.
	one operation: operation.
	other := array first.
	array first: one.
	self deny: one address = other address.
	self assert: one index = other index.
	self assert: one operation = other operation.
	operation free.
	
	operation := TFOperation externalNew.
	one index: 16r75F6F7F8.
	one operation: operation.
	1 to: size do: [ :index | 
		other := array at: index.
		array at: index put: one.
		self deny: one address = other address.
		self assert: one index = other index.
		self assert: one operation = other operation ].
	operation free.
	one free.
]

{ #category : 'testing' }
ExternalWordArrayTest >> testOutputArrayElementsAreAliases [
	| array size one other |
	size := 4.
	array := TFOutputArray externalNew: size.
	one := array first.
	other := array at: 1.
	one index: 12345678.
	self assert: one index = 12345678.
	self assert: other index = 12345678.
	other index: 77665544.
	self assert: one index = 77665544.
	self assert: other index = 77665544.
	1 to: size do: [ :index | 
		one := array at: index.
		other := array at: index.
		one index: 12348765.
		self assert: one index = 12348765.
		self assert: other index = 12348765.
		other index: 77222244.
		self assert: one index = 77222244.
		self assert: other index = 77222244 ]
]

{ #category : 'testing' }
ExternalWordArrayTest >> testOutputArrayElementsOfRightClass [
	| array size |
	size := 4.
	array := TFOutputArray externalNew: size.
	self assert: (array first isKindOf: TFOutput).
	1 to: size do: [ :index | self assert: ((array at: index) isKindOf: TFOutput) ]
]

{ #category : 'testing' }
ExternalWordArrayTest >> testTensorArrayAtPut [
	| sample |
	sample := TFTensor fromInt64: 16r12341234.
	self testArrayAtPutFor: TFTensorPtrArray elementSample: sample
]

{ #category : 'testing' }
ExternalWordArrayTest >> testTensorArrayElementsOfRightClass [
	^ self testArray: TFTensorPtrArray sampleElement: TFTensor new
]

{ #category : 'testing' }
ExternalWordArrayTest >> testUIn64ArrayfromArray [
	self testUIn64ArrayfromArray: #(1).
	self
		testUIn64ArrayfromArray: #(16r12345678 2 16r76543210 4 16rDEADBEAF 6 16rFFFFFFFF)
]

{ #category : 'testing' }
ExternalWordArrayTest >> testUIn64ArrayfromArray: template [
	| array |
	array := Int64Array externalFromArray: template.
	1 to: template size do: [:index |
		self assert: (template at: index) = (array at: index) ].
]

{ #category : 'testing' }
ExternalWordArrayTest >> testUInt64ArrayAtPut [
	self testArrayAtPutFor: Int64Array elementSample: 12345.
	self testArrayAtPutFor: Int64Array elementSample: 16rFE00FE00.
	self testArrayAtPutFor: Int64Array elementSample: 16r7E00FE00FE00FE00.
	self
		testArrayAtPutFor: Int64Array
		elementSample: 16r-7E00FE00FE00FE00
]

{ #category : 'testing' }
ExternalWordArrayTest >> testUInt64ArrayElementsOfRightClass [
	^ self testArray: Int64Array sampleElement: 1234
]
