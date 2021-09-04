Class {
	#name : 'FloatingPointNumberParser',
	#superclass : 'Object',
	#instVars : [
		'bytes'
	],
	#category : 'IdxReaderApp'
}

{ #category : 'Instance Creation' }
FloatingPointNumberParser class >> from: aByteArray [

	^ self new initializeFrom: aByteArray
]

{ #category : 'Parsing' }
FloatingPointNumberParser >> doublePrecisionAt: index bigEndianStored: useBigEndian [
		
	"Return a 64 bit float starting from the given byte index"

	| sign  exponent mantissa  |
	
	sign := useBigEndian 
		ifTrue: [(bytes at: index) bitAt: 8]
		ifFalse: [(bytes at: index+7) bitAt: 1].
	exponent := useBigEndian
		ifTrue: [(((bytes at: index) bitAnd: 16r7F) * 16) + (((bytes at: index+1) bitAnd: 16rF0) // 16)]
		ifFalse: [(((bytes at: index+7) bitAnd: 16r7F) * 16) + (((bytes at: index+6) bitAnd: 16rF0) // 16)].
	mantissa := useBigEndian
		 ifTrue: [ 
			((bytes at: index+1) bitAnd: 16r0F) * 256 + 
			(bytes at: index+2) * 256 + 
			(bytes at: index+3) * 256 + 
			(bytes at: index+4) * 256 + 
			(bytes at: index+5) * 256 + 
			(bytes at: index+6) * 256 + 
			(bytes at: index+7)]
		ifFalse: [ 
			((bytes at: index+6) bitAnd: 16r0F) * 256 + 
			(bytes at: index+5) * 256 + 
			(bytes at: index+4) * 256 + 
			(bytes at: index+3) * 256 + 
			(bytes at: index+2) * 256 + 
			(bytes at: index+1) * 256 + 
			(bytes at: index)].
				
	^(-1 raisedTo: sign) * (1+mantissa) * (2 raisedTo: (exponent - 1023) ) 
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
FloatingPointNumberParser >> initializeFrom: aByteArray [

	bytes := aByteArray
]

{ #category : 'Parsing' }
FloatingPointNumberParser >> singlePrecisionAt: anIndex bigEndianStored: useBigEndian [

	"Convert the given 32 bit word (which is supposed to be a positive 32-bit value) from
	 a 32 bit IEEE floating point representation into an actual Squeak float object (being
	 64 bits wide). Should only be used for conversion in FloatArrays or likewise objects."
	
	| word sign mantissa exponent delta |
	
	word := bytes unsignedLongAt: anIndex bigEndian: useBigEndian.
	
	word <= 0 ifTrue: [
		^word negative
			ifTrue: [self error: 'Cannot deal with negative numbers']
			ifFalse: [0.0]].
			
	sign := (word bitAnd: 16r80000000).
	word = sign ifTrue: [^Float negativeZero].
	
	exponent := ((word bitShift: -23) bitAnd: 16rFF) - 127.
	mantissa := word bitAnd:  16r7FFFFF.

	exponent = 128 ifTrue: [
		"Either NAN or INF"
		^mantissa = 0
			ifTrue: [sign = 0 ifTrue: [Float infinity] ifFalse: [Float negativeInfinity]]
			ifFalse: [Float nan]].

	exponent = -127 ifTrue: [
		"gradual underflow (denormalized number)
		 Remove first bit of mantissa and adjust exponent"
		delta := mantissa highBit.
		mantissa := (mantissa bitAnd: (1 bitShift: delta - 1) - 1) bitShift: 24 - delta.
		exponent := exponent + delta - 23].
	
	"Create new float"
	^(-1 raisedTo: (sign bitAt: 32)) * (1 +mantissa) * (2 raisedTo: exponent)
]
