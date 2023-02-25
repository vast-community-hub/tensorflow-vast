Extension {
	#name : 'ByteArray'
}

{ #category : 'Compatibility' }
ByteArray >> doubleAt: index bigEndian: bool [

	^(FloatingPointNumberParser from: self)
		doublePrecisionAt: index
		bigEndianStored: bool
		
]

{ #category : 'Compatibility' }
ByteArray >> floatAt: index bigEndian: boolean [

	^(FloatingPointNumberParser from: self)
		singlePrecisionAt: index
		bigEndianStored: boolean
]

{ #category : 'Compatibility' }
ByteArray >> longAt: index bigEndian: aBool [
	"Return a 32bit integer quantity starting from the given byte index"
	| b0 b1 b2 w h |
	aBool ifTrue:[
		b0 := self at: index.
		b1 := self at: index+1.
		b2 := self at: index+2.
		w := self at: index+3.
	] ifFalse:[
		w := self at: index.
		b2 := self at: index+1.
		b1 := self at: index+2.
		b0 := self at: index+3.
	].
	"Minimize LargeInteger arithmetic"
	h := ((b0 bitAnd: 16r7F) - (b0 bitAnd: 16r80) bitShift: 8) + b1.
	b2 = 0 ifFalse:[w := (b2 bitShift: 8) + w].
	h = 0 ifFalse:[w := (h bitShift: 16) + w].
	^w
]

{ #category : 'Compatibility' }
ByteArray >> shortAt: index bigEndian: aBool [
	"Return a 16 bit integer quantity starting from the given byte index"

	| uShort |

	uShort := self unsignedShortAt: index bigEndian: aBool.
	^(uShort bitAnd: 16r7FFF) - (uShort bitAnd: 16r8000)
]

{ #category : 'Compatibility' }
ByteArray >> unsignedLongAt: index bigEndian: aBool [
	"Return a 32bit unsigned integer quantity starting from the given byte index"

	| b0 b1 b2 w |

	aBool
		ifTrue: [
			b0 := self at: index.
			b1 := self at: index + 1.
			b2 := self at: index + 2.
			w := self at: index + 3]
		ifFalse: [
			w := self at: index.
			b2 := self at: index + 1.
			b1 := self at: index + 2.
			b0 := self at: index + 3].
	"Minimize LargeInteger arithmetic"
	b2 = 0 ifFalse: [w := (b2 bitShift: 8) + w].
	b1 = 0 ifFalse: [w := (b1 bitShift: 16) + w].
	b0 = 0 ifFalse: [w := (b0 bitShift: 24) + w].
	^w
]

{ #category : 'Compatibility' }
ByteArray >> unsignedShortAt: index bigEndian: aBool [
	"Return a 16 bit unsigned integer quantity starting from the given byte index"

	^aBool
		ifTrue: [((self at: index) bitShift: 8) + (self at: index + 1)]
		ifFalse: [((self at: index + 1) bitShift: 8) + (self at: index)]
]
