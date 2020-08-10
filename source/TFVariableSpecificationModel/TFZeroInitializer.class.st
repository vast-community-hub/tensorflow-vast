Class {
	#name : 'TFZeroInitializer',
	#superclass : 'TFVariableInitializer',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Evaluating' }
TFZeroInitializer >> applyTo: aTFVariable [

	| initialValue |

	initialValue := TFConstant like: aTFVariable filledWith: 0.

	aTFVariable assign: initialValue value
]
