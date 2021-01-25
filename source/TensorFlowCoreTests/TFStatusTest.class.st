Class {
	#name : 'TFStatusTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'Tests' }
TFStatusTest >> testAccessors [

	| status |

	status := TFStatus new.
	status code: 1 message: 'I cancelled this'.
	self deny: status isOk.
	self assert: status message = 'I cancelled this'.
	self assert: status code = 1.
	status free
]

{ #category : 'Tests' }
TFStatusTest >> testNewFree [

	| status |

	status := TFStatus new.
	self assert: status isOk.
	self assert: status message isEmpty.
	status free.
	self assert: status isUndefined
]
