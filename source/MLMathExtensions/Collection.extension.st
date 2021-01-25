Extension {
	#name : 'Collection'
}

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcCos [
	^ self collect: [:each | each arcCos]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcSin [
	^ self collect: [:each | each arcSin]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> arcTan [
	^ self collect: [:each | each arcTan]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> cos [
	^ self collect: [:each | each cos]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> exp [
	^ self collect: [:each | each exp]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['*Math-Numerical'] }
Collection >> mean [

	^self sum / self size
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> min [
	| min |
	min := nil.
	self do: [:each |
		(min == nil  or: [min > each]) ifTrue: [
			min := each]].
	^ min
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> negated [
	^ self collect: [:each | each negated]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> sin [
	^ self collect: [:each | each sin]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Not categorized'] }
Collection >> softmax [
	" This assumes self represents a Matrix (is a collection of collection of numbers)
	 To make our softmax function numerically stable, we simply normalize the values in the vector, 
	 by multiplying the numerator and denominator with a constant C. We can choose an arbitrary 
	 value for log(C) term, but generally log(C)=-max(a) is chosen, as it shifts all of elements in the 
	 vector to negative to zero, and negatives with large exponents saturate to zero rather than 
	 the infinity, avoiding overflowing - (Taken from PolyMath)"

	| total max |

	max := self max.
	total := (self collect: [:x | (x - max) exp]) sum.
	^self collect: [:x | (x - max) exp / total]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> squared [
	^ self collect: [:each | each squared]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> standardDeviation [
	| mean std |
	mean := self mean.
	std := self inject: 0 into: [:prev :next | prev + (next - mean) squared].
	^ (std / (self size - 1)) sqrt
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> tan [
	^ self collect: [:each | each tan]
]

{ #category : '*MLMathExtensions',
 #vaCategories : ['Squeak Family compatibility'] }
Collection >> truncated [
	^ self collect: [:each | each truncated]
]
