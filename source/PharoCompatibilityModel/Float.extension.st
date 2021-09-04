Extension {
	#name : 'Float'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Not categorized'] }
Float >> closeTo: num [
 	"Tell whether the receiver and arguments are close from each."
	
	^ self closeTo: num precision: 0.0001
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Not categorized'] }
Float >> closeTo: num precision: aPrecision [
	"Tell whether the receiver and arguments are close from each other given a precision"

	self = 0.0 ifTrue: [^num abs < aPrecision].
	num = 0 ifTrue: [^self abs < aPrecision].
	^self = num asFloat or: [(self - num) abs / (self abs max: num abs) < aPrecision]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo Compatibility Model'] }
Float >> literalEqual: other [

	^ (super literalEqual: other) and: [ self isZero not or: [ self signBit = other signBit ] ]
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Pharo Compatibility Model'] }
Float >> signBit [
	"Answer 1 if the receiver has sign bit set (including case of IEEE-754 negative-zero).
	Answer 0 otherwise"

	^((self at: 1) bitShift: -31)
]
