Class {
	#name : 'ZeroInitializer',
	#superclass : 'VariableNodeInitializer',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Evaluating' }
ZeroInitializer >> applyTo: aTFVariable [

	| initialValue |

	initialValue := ConstantNode like: aTFVariable filledWith: 0.

	aTFVariable assign: initialValue value
]
