Extension {
	#name : 'TFSession'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFSession class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFSession class >> on: aTFGraph [
	| options status answer |
	options := TFSessionOptions create.
	status := TFStatus create.
	answer := TensorFlowCAPI current
		newSession: aTFGraph
		options: options
		status: status.
	status check.
	answer useFinalization.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['release'] }
TFSession >> basicDelete [
	| status |
	status := TFStatus create.
	self close.
	self library deleteSession: self status: status.
	status check
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['release'] }
TFSession >> close [
	| status |
	status := TFStatus create.
	self library closeSession: self status: status.
	status check
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> devices [
	^ (TFDeviceList on: self) devices
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> run [
	| status |
	status := TFStatus create.
	self library
		runSession: self
		options: nil
		inputs: nil
		values: nil
		count: 0
		outputs: nil
		values: nil
		count: 0
		targets: nil
		count: 0
		metadata: nil
		status: status.
	status check
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runInputs: inArrayOfTFOutputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [
	| inputs invalues outputs outvalues status |
	status := TFStatus create.
	inputs := TFOutputArray externalFromArray: inArrayOfTFOutputs.
	invalues := TFTensorPtrArray externalFromArray: inArrayOfTFTensor.
	outputs := TFOutputArray externalFromArray: outArrayOfTFOutputs.
	outvalues := TFTensorPtrArray new: outArrayOfTFOutputs size.
	self library
		runSession: self
		options: nil
		inputs: inputs
		values: invalues
		count: inArrayOfTFOutputs size
		outputs: outputs
		values: outvalues
		count: outArrayOfTFOutputs size
		targets: nil
		count: 0
		metadata: nil
		status: status.
	status check.
	^ outvalues
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperation: aTFOperation [
	^ self runOperations: (Array with: aTFOperation)
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperation: aTFOperation input: inTFOutputOrInput value: inTFTensor output: outTFOutput [
	| inputs invalues operations outputs outvalues tensor |
	inputs := Array with: inTFOutputOrInput.
	invalues := Array with: inTFTensor.
	outputs := Array with: outTFOutput.
	operations := Array with: aTFOperation.
	outvalues := self
		runOperations: operations
		inputs: inputs
		values: invalues
		outputs: outputs.
	tensor := outvalues first.
	^ tensor
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperation: aTFOperation output: aTFOutput [
	| operations answer outputs |
	operations := TFOperationPtrArray externalNew: 1.
	outputs := TFOutputArray externalNew: 1.
	outputs first: aTFOutput.
	operations first: aTFOperation.
	answer := self runOperations: operations outputs: outputs size: 1.
	^ answer first
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperations: anArrayOfTFOperations [
	| status operations |
	status := TFStatus create.
	operations := TFOperationPtrArray
		externalFromArray: anArrayOfTFOperations.
	self library
		runSession: self
		options: nil
		inputs: nil
		values: nil
		count: 0
		outputs: nil
		values: nil
		count: 0
		targets: operations
		count: anArrayOfTFOperations size
		metadata: nil
		status: status.
	status check
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperations: anArrayOfTFOperations inputs: inArrayOfTFOutputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [
	| operations inputs invalues outputs outvalues status |
	status := TFStatus create.
	operations := TFOperationPtrArray
		externalFromArray: anArrayOfTFOperations.
	inputs := TFOutputArray externalFromArray: inArrayOfTFOutputs.
	invalues := TFTensorPtrArray externalFromArray: inArrayOfTFTensor.
	outputs := TFOutputArray externalFromArray: outArrayOfTFOutputs.
	outvalues := TFTensorPtrArray new: outArrayOfTFOutputs size.
	self library
		runSession: self
		options: nil
		inputs: inputs
		values: invalues
		count: inArrayOfTFOutputs size
		outputs: outputs
		values: outvalues
		count: outArrayOfTFOutputs size
		targets: operations
		count: anArrayOfTFOperations size
		metadata: nil
		status: status.
	status check.
	^ outvalues
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOperations: aTFOperationArray outputs: aTFOutputArray size: anInteger [
	| status outvalues |
	status := TFStatus create.
	outvalues := TFTensorPtrArray new: anInteger.
	self library
		runSession: self
		options: nil
		inputs: nil
		values: nil
		count: 0
		outputs: aTFOutputArray
		values: outvalues
		count: anInteger
		targets: aTFOperationArray
		count: 1
		metadata: nil
		status: status.
	status check.
	^ outvalues
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOutput: aTFOutput [
	| results |
	results := self
		runOutputs:
			((Array new: 1)
				at: 1 put: aTFOutput;
				yourself).
	^ results first
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOutputs: anArrayOfTFOutputs [
	| outputs |
	outputs := TFOutputArray externalFromArray: anArrayOfTFOutputs.
	^ self runOutputs: outputs size: anArrayOfTFOutputs size
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['running'] }
TFSession >> runOutputs: aTFOutputArray size: anInteger [
	| status outvalues |
	status := TFStatus create.
	outvalues := TFTensorPtrArray new: anInteger.
	self library
		runSession: self
		options: nil
		inputs: nil
		values: nil
		count: 0
		outputs: aTFOutputArray
		values: outvalues
		count: anInteger
		targets: nil
		count: 0
		metadata: nil
		status: status.
	status check.
	^ outvalues
]
