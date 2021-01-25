Class {
	#name : 'TFBufferTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'Tests' }
TFBufferTest >> testNewFree [

	| buffer |

	buffer := TFBuffer new.
	self assert: buffer data isNull.
	self assert: buffer length = 0.
	buffer free.
	self assert: buffer isUndefined
]

{ #category : 'Tests' }
TFBufferTest >> testNewFromFree [

	| buffer |

	buffer := TFBuffer fromString: 'Test Data'.
	self assert: (buffer data memcpyStringFrom: 0 to: buffer length - 1) = 'Test Data'.
	self assert: buffer length = 9.
	buffer free.
	self assert: buffer isUndefined
]
