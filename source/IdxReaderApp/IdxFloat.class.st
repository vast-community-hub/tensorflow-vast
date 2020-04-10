"
See superclass comment.
"
Class {
	#name : 'IdxFloat',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxFloat >> isFloat [

	^ true
]

{ #category : 'reading' }
IdxFloat >> readNextFrom: aReadStream [

	
	^ (aReadStream next: 4) floatAt: 1 bigEndian: true
]
