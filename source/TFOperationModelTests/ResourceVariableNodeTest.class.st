Class {
	#name : 'ResourceVariableNodeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
ResourceVariableNodeTest >> assertCorrectResourceInitializationWhenTyped: dataType shaped: shape containing: content [

	| output resource |

	resource :=
		ResourceVariableNode
			on: tf
			named: 'my-resource-variable'
			of: dataType
			shaped: shape
			initializedWith:
				(ConstantInitializer with: (TFTensor newTyped: dataType containing: content)).
	output := tf compute: resource.

	self assert: output type equals: ResourceDataType new.
	self assert: output shape equals: TensorShape scalar.
	self assert: output allElements size equals: 1.

	self
		assert: (tf compute: resource assignedValue)
		isOf: dataType
		with: shape
		comparedTo: content
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Tests' }
ResourceVariableNodeTest >> testFloatResourceCreation [

	self
		assertCorrectResourceInitializationWhenTyped: FloatDataType new
		shaped: (TensorShape vectorSized: 2)
		containing: #(3 2)
]

{ #category : 'Tests' }
ResourceVariableNodeTest >> testInt32ResourceCreation [

	self
		assertCorrectResourceInitializationWhenTyped: Int32DataType new
		shaped: (TensorShape vectorSized: 2)
		containing: #(3 2)
]

{ #category : 'Tests' }
ResourceVariableNodeTest >> testInt64ResourceCreation [

	self
		assertCorrectResourceInitializationWhenTyped: Int64DataType new
		shaped: (TensorShape vectorSized: 2)
		containing: #(3 2)
]
