"
See superclass comment.
"
Class {
	#name : 'IdxUnsignedByte',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxUnsignedByte >> isUnsignedByte [

	^ true
]

{ #category : 'reading' }
IdxUnsignedByte >> readNextFrom: aReadStream [

	
	^ aReadStream next
]
