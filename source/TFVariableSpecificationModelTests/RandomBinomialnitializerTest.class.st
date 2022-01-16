Class {
	#name : 'RandomBinomialnitializerTest',
	#superclass : 'VariableInitializerTest',
	#category : 'TFVariableSpecificationModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> createCustomInitializer [

	^RandomBinomialInitializer withProbabilityOfSuccess: 0.6 in: 10 withSeed: 1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> createDefaultInitializer [

	^RandomBinomialInitializer withSeed: 1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> createInitializerWithRandomSeed [

	^RandomBinomialInitializer new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> expectedMatrixValues [

	^ #( ( 1 0 0 ) ( 1 0 0 )  )
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> expectedScalarValue [
	
	^ 1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomBinomialnitializerTest >> expectedVectorValues [

	^#(7 7 6)
]
