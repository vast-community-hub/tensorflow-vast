Class {
	#name : 'TFAttributeName',
	#superclass : 'Object',
	#category : 'TFOperationModel'
}

{ #category : 'Accessing' }
TFAttributeName class >> dataType [

	^'dtype' 
]

{ #category : 'Accessing' }
TFAttributeName class >> shape [

	^'shape'
]

{ #category : 'Accessing' }
TFAttributeName class >> transposeA [

	^'transpose_a'
]

{ #category : 'Accessing' }
TFAttributeName class >> transposeB [

	^'transpose_b'
]

{ #category : 'Accessing' }
TFAttributeName class >> value [

	^'value' 
]
