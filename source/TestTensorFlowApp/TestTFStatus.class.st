Class {
	#name : 'TestTFStatus',
	#superclass : 'TensorFlowTestCase',
	#category : 'TestTensorFlowApp'
}

{
	#category : 'Tests'
}
TestTFStatus >> testAccessors [

	| status |

	status := TFStatus new.
	status code: TF_CANCELLED message: 'I cancelled this'. 
	self deny: status isOk.
	self assert: status message = 'I cancelled this'.
	self assert: status code = TF_CANCELLED.
	status free.
]

{
	#category : 'Tests'
}
TestTFStatus >> testNewFree [

	| status |

	status := TFStatus new.
	self assert: status isOk.
	self assert: status message isEmpty.
	status free.
	self assert: status isUndefined
]
