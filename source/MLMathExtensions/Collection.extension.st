Extension {
	#name : 'Collection'
}

{ #category : '*MLMathExtensions',
 #vaCategories : ['*Math-Numerical'] }
Collection >> mean [

	^self sum / self size
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
