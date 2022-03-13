Class {
	#name : 'TFString',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Instance Creation' }
TFString class >> with: aContent [


	^ TensorFlowCAPI current newStringWith: aContent
]

{ #category : 'accessing' }
TFString >> basicDelete [

	Transcript
		show: 'Deleted TFString';
		cr.
	^TensorFlowCAPI current deleteString: self
]

{ #category : 'accessing' }
TFString >> capacity [


	^ TensorFlowCAPI current stringGetCapacityOf: self
]

{ #category : 'accessing' }
TFString >> content [


	^ TensorFlowCAPI current stringGetDataOf: self
]

{ #category : 'accessing' }
TFString >> size [

	^TensorFlowCAPI current stringGetSizeOf: self
]

{ #category : 'accessing' }
TFString >> stringType [

	^ TensorFlowCAPI current stringGetTypeOf: self
]
