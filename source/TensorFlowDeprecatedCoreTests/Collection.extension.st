Extension {
	#name : 'Collection'
}

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcCos [
	^ self collect: [:each | each arcCos]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcSin [
	^ self collect: [:each | each arcSin]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcTan [
	^ self collect: [:each | each arcTan]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> cos [
	^ self collect: [:each | each cos]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> exp [
	^ self collect: [:each | each exp]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> min [
	| min |
	min := nil.
	self do: [:each |
		(min == nil  or: [min > each]) ifTrue: [
			min := each]].
	^ min
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> negated [
	^ self collect: [:each | each negated]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> sin [
	^ self collect: [:each | each sin]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> squared [
	^ self collect: [:each | each squared]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> standardDeviation [
	| mean std |
	mean := self mean.
	std := self inject: 0 into: [:prev :next | prev + (next - mean) squared].
	^ (std / (self size - 1)) sqrt
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> tan [
	^ self collect: [:each | each tan]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> truncated [
	^ self collect: [:each | each truncated]
]
