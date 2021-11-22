Class {
	#name : 'VariableInitializerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFVariableSpecificationModelTests'
}

{ #category : 'Accessing' }
VariableInitializerTest class >> isAbstract [

	^self = VariableInitializerTest
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> createCustomInitializer [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> createDefaultInitializer [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> createInitializerWithRandomSeed [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> expectedMatrixValues [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> expectedScalarValue [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableInitializerTest >> expectedVectorValues [

	self subclassResponsibility
]

{ #category : 'Test' }
VariableInitializerTest >> testInitializeMatrixVariable [

	| variable |

	variable :=
		VariableNode
			on: tf
			named: 'input'
			forFloatsShaped: (TensorShape matrixSized: 2 by: 3)
			initializedWith: self createDefaultInitializer.
			
	self assertOutputOf: variable isMatrixCloseTo: self expectedMatrixValues
]

{ #category : 'Test' }
VariableInitializerTest >> testInitializeScalarVariable [

	| variable |

	variable :=
		VariableNode
			on: tf
			named: 'input'
			forFloatsShaped: TensorShape scalar
			initializedWith: self createDefaultInitializer.
			
	self assertOutputOf: variable isFloatScalarCloseTo: self expectedScalarValue
]

{ #category : 'Test' }
VariableInitializerTest >> testInitializeScalarVariableWithRandomSeed [

	| variable output |

	variable :=
		VariableNode
			on: tf
			named: 'input'
			forFloatsShaped: TensorShape scalar
			initializedWith: self createInitializerWithRandomSeed.
	
	output := tf compute: variable.
	
	self assert: output type equals: FloatDataType new.
	self assert: output shape equals: TensorShape scalar.
	
]

{ #category : 'Test' }
VariableInitializerTest >> testInitializeVectorVariable [

	| variable |

	variable :=
		VariableNode
			on: tf
			named: 'input'
			forFloatsShaped: (TensorShape vectorSized: 3)
			initializedWith: self createCustomInitializer.
			
	self assertOutputOf: variable isFloatVectorCloseTo: self expectedVectorValues
]
