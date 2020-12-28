Class {
	#name : 'RandomUniformInitializerTest',
	#superclass : 'VariableInitializerTest',
	#category : 'TFVariableSpecificationModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> createCustomInitializer [

	^RandomUniformInitializer upperBoundedBy: 2 withSeed: 3
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> createDefaultInitializer [

	^RandomUniformInitializer withSeed: 1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> createInitializerWithRandomSeed [

	^RandomUniformInitializer new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> expectedMatrixValues [

	^(OrderedCollection new)
		add: #(0.037849 -0.004002 0.010029);
		add: #(-0.01074 -0.024681 -0.00557);
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> expectedScalarValue [

	^0.03784882
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomUniformInitializerTest >> expectedVectorValues [

	^#(0.351621 1.875658 1.041164)
]
