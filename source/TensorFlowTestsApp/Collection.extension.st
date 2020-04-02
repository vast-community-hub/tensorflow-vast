Extension {
	#name : 'Collection'
}

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> * aCollection [
	^ self with: aCollection collect: [:a :b | a * b].
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> + aCollection [
	^ self with: aCollection collect: [:a :b | a + b].
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> - aCollection [
	^ self with: aCollection collect: [:a :b | a - b].
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> / aCollection [
	^ self with: aCollection collect: [:a :b | a / b].
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> \\ aCollection [
	^ self with: aCollection collect: [:a :b | a \\ b].
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> abs [
	^ self collect: [:each | each abs]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcCos [
	^ self collect: [:each | each arcCos]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcSin [
	^ self collect: [:each | each arcSin]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcTan [
	^ self collect: [:each | each arcTan]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> cos [
	^ self collect: [:each | each cos]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> exp [
	^ self collect: [:each | each exp]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> max [
	| max |
	max := nil.
	self do: [:each |
		(max == nil  or: [max < each]) ifTrue: [
			max := each]].
	^ max
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> mean [
	^ self sum asFloat / self size
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> min [
	| min |
	min := nil.
	self do: [:each |
		(min == nil  or: [min > each]) ifTrue: [
			min := each]].
	^ min
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> negated [
	^ self collect: [:each | each negated]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> sin [
	^ self collect: [:each | each sin]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> squared [
	^ self collect: [:each | each squared]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> standardDeviation [
	| mean std |
	mean := self mean.
	std := self inject: 0 into: [:prev :next | prev + (next - mean) squared].
	^ (std / (self size - 1)) sqrt
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> sum [
	| any answer |
	any := self detect: [:_ | true].
	answer := self inject: any into: [:prev :next | prev + next].
	^ answer - any
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> tan [
	^ self collect: [:each | each tan]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> truncated [
	^ self collect: [:each | each truncated]
]

{ #category : '*TensorFlowTestsApp',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> with: aCollection collect: twoArgumentsBlock [
	| other |
	other := ReadStream on: aCollection.
	^ self collect: [:each | twoArgumentsBlock value: each value: other next]
]
