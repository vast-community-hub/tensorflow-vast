Class {
	#name : 'TFOutput',
	#superclass : 'TFStructure',
	#instVars : [
		'graph'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'field definition' }
TFOutput class >> fields [
	"self initialize.
	self defineFields"

	^ #(#(operation 'TFOperation*') #(index 'long') #(pad 'long'))
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOutput class >> initializeAfterLoad [
	"Set layout."

	self members: #(operation index) types: #(pointer int32) alignmentType: Align16
]

{ #category : 'instance creation' }
TFOutput class >> new [

	^super new initialize
]

{ #category : 'instance creation' }
TFOutput class >> onOperation: aTFOperation index: anInteger [

	^self externalNew
		operation: aTFOperation;
		index: anInteger;
		graph: aTFOperation graph;
		yourself
]

{ #category : 'accessing' }
TFOutput >> graph [

	^graph
]

{ #category : 'accessing' }
TFOutput >> graph: aTFGraph [

	
	graph := aTFGraph
]

{ #category : 'accessing' }
TFOutput >> index [
	^ self int32At: #index
]

{ #category : 'accessing' }
TFOutput >> index: anObject [
	self int32At: #index put: anObject
]

{ #category : 'accessing' }
TFOutput >> operation [
	^ TFOperation address: (self pointerAt: #operation)
]

{ #category : 'accessing' }
TFOutput >> operation: anObject [
	^ self pointerAt: #operation put: anObject

]

{ #category : 'accessing' }
TFOutput >> operationOn: aTFGraph [

	| answer |

	answer := self operation.
	answer graph: aTFGraph.
	^answer
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFOutput >> tensorflowTypeFrom: aProtobufferType [

	| mapping |

	"Ref: https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/types.proto"

	mapping :=
		Dictionary new
			at: 101 put: FloatDataType new;
			at: 102 put: FloatDataType new;
			at: 103 put: Int32DataType new;
			at: 109 put: Int64DataType new; 
			at: 120 put: ResourceDataType new;
			at: 121 put: VariantDataType new;
			yourself.

	^mapping
		at: aProtobufferType
		ifAbsent: [
			self error:
				('No mapping found for the Protobuffer data type %1' bindWith: aProtobufferType)]
]

{ #category : 'accessing' }
TFOutput >> type [

	| type |

	type := self library operationOutputType: self.
	" When querying the type of a Variable node output, TF_OperationOutputType is
	 returning the protobuf DataType enum 
	Ref: https://github.com/tensorflow/tensorflow/issues/5409. "
	^self operation type = 'Variable'
		ifTrue: [self tensorflowTypeFrom: type]
		ifFalse: [TensorDataType identifiedWith: type]
]
