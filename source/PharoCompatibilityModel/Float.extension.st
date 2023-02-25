Extension {
	#name : 'Float'
}

{ #category : 'Pharo Compatibility Model' }
Float >> literalEqual: other [

	^ (super literalEqual: other) and: [ self isZero not or: [ self signBit = other signBit ] ]
]

{ #category : 'Pharo Compatibility Model' }
Float >> signBit [
	"Answer 1 if the receiver has sign bit set (including case of IEEE-754 negative-zero).
	Answer 0 otherwise"

	^((self at: 1) bitShift: -31)
]
