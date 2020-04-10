Class {
	#name : 'TFZeroInitializer',
	#superclass : 'TFVariableInitializer',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Evaluating' }
TFZeroInitializer >> applyTo: aTFVariable [

	| initialValue |

	initialValue := aTFVariable currentComputation zerosShapedFor: aTFVariable.

	aTFVariable assign: initialValue
]
