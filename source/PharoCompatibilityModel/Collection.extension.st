Extension {
	#name : 'Collection'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> * arg [

	^ arg adaptToCollection: self andSend: #*
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> + arg [

	^ arg adaptToCollection: self andSend: #+
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> - arg [

	^ arg adaptToCollection: self andSend: #-
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> / arg [

	^ arg adaptToCollection: self andSend: #/
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> // arg [

	^ arg adaptToCollection: self andSend: #//
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> \\ arg [

	^ arg adaptToCollection: self andSend: #\\
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> abs [
	"Absolute value of all elements in the collection"

	^self collect: [:a | a abs]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> adaptToCollection: rcvr andSend: selector [
	"If I am involved in arithmetic with another Collection, return a Collection of
	the results of each element combined with the scalar in that expression."

	(rcvr isSequenceable and: [self isSequenceable])
		ifFalse: [self error: 'Only sequenceable collections may be combined arithmetically'].
	^rcvr
		with: self
		collect: [:rcvrElement :myElement | rcvrElement perform: selector with: myElement]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> anyOne [
	"Answer a representative sample of the receiver. It raises an error when the collection is empty. This method can be helpful when needing to preinfer the nature of the contents of semi-homogeneous collections."
	"#(1 2 3) anyOne >>> 1"
	"
	([#() anyOne] on: SubscriptOutOfBounds do: [ :ex | 'whatever' ]) >>> 'whatever'
	"

	self isEmpty ifTrue: [AssertionFailure signal: 'Collection is empty'].
	self do: [:each | ^each]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> errorSizeMismatch [
	"Signal a SizeMismatch exception"

	SizeMismatch signal
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> flatCollect: aBlock [

	^self flatCollect: aBlock as: self species
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> flatCollect: aBlock as: aCollectionClass [
	"Evaluate aBlock for each of the receiver's elements and answer the
	list of all resulting values flatten one level. Assumes that aBlock returns some kind
	of collection for each element. Equivalent to the lisp's mapcan"

	| col |

	col := aCollectionClass new: self size.
	self do: [:each | col addAll: (aBlock value: each)].
	^col
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo-API'] }
Collection >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise"
	" If the notEmptyBlock has an argument, eval with the receiver as its argument"

	self isEmpty ifTrue: [^emptyBlock value].
	^notEmptyBlock cull: self
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> max [
	^ self inject: self anyOne into: [:max :each | max max: each]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> sign [
	"Answer 1 if the receiver is greater than 0, -1 if less than 0, else 0."
	"5 sign >>> 1"
	"-3 sign >>> -1"
	^self collect: [:each | each sign]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> sqrt [
	^ self collect: [:each | each sqrt]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Collections-Arithmetic'] }
Collection >> sum [
	"This is implemented using a variant of the normal inject:into: pattern. 
	The reason for this is that it is not known whether we're in the normal 
	number line, i.e. whether 0 is a good initial value for the sum. 
	Consider a collection of measurement objects, 0 would be the unitless 
	value and would not be appropriate to add with the unit-ed objects."

	| sum sample |

	sample := self anyOne.
	sum := self inject: sample into: [:accum :each | accum + each].
	^sum - sample
]
