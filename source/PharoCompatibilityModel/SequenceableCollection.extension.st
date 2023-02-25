Extension {
	#name : 'SequenceableCollection'
}

{ #category : 'Pharo-API' }
SequenceableCollection >> atRandom [

	^self atRandom: EsRandom new
]

{ #category : 'Pharo-API' }
SequenceableCollection >> beginsWith: aSequenceableCollection [
	"Answer true if the receiver starts with the argument collection"

	(aSequenceableCollection isEmpty or: [self size < aSequenceableCollection size]) ifTrue: [^false].
	aSequenceableCollection withIndexDo: [:each :index | (self at: index) ~= each ifTrue: [^false]].
	^true
]

{ #category : 'Pharo-API' }
SequenceableCollection >> endsWith: aSequenceableCollection [
	"Answer true if the receiver ends with the argument collection"

	| start |

	(aSequenceableCollection isEmpty or: [self size < aSequenceableCollection size]) ifTrue: [^false].
	start := self size - aSequenceableCollection size.
	aSequenceableCollection
		withIndexDo: [:each :index | (self at: start + index) ~= each ifTrue: [^false]].
	^true
]

{ #category : 'Enumerating' }
SequenceableCollection >> reverseWith: aSequenceableCollection do: aBlock [

	"Evaluate aBlock with each of the receiver's elements, in reverse order, 
	along with the  corresponding element, also in reverse order, from 
	aSequencableCollection. "

	self size ~= aSequenceableCollection size ifTrue: [^ self errorSizeMismatch].
	self size to: 1 by: -1 do: [:index | 
			aBlock 
				value: (self at: index)
				value: (aSequenceableCollection at: index)]
]

{ #category : 'Pharo-API' }
SequenceableCollection >> shuffle [

	^self shuffleBy: EsRandom new
]

{ #category : 'Pharo-API' }
SequenceableCollection >> shuffleBy: aRandom [
	"Durstenfeld's version of the Fisher-Yates shuffle"

	self size to: 2 by: -1 do: [:i | self swap: i with: (aRandom nextInt: i)]
]

{ #category : 'Pharo-API' }
SequenceableCollection >> shuffled [

	^self shuffle
]

{ #category : 'Pharo-API' }
SequenceableCollection >> with: otherCollection collect: twoArgBlock [
	"Collect and return the result of evaluating twoArgBlock with corresponding elements from this collection and otherCollection."

	| result |

	otherCollection size = self size ifFalse: [self errorSizeMismatch].
	result := self species new: self size.
	1 to: self size do: [:index |
		result
			at: index
			put: (twoArgBlock value: (self at: index) value: (otherCollection at: index))].
	^result
]

{ #category : 'ES-Portability' }
SequenceableCollection >> withIndexDo: aBlock [


	self doWithIndex: aBlock
]
