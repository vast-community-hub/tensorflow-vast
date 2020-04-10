"
See superclass comment.
"
Class {
	#name : 'IdxSignedByte',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxSignedByte >> isSignedByte [

	^ true
]

{ #category : 'reading' }
IdxSignedByte >> readNextFrom: aReadStream [

	
	| byte |
	byte := aReadStream next.
	"decode negative 32-bit integer"
	byte >= 128 ifTrue: [ byte := -256 + byte ].
	^ byte
]
