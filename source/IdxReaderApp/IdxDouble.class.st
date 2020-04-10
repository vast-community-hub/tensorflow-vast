"
See superclass comment.
"
Class {
	#name : 'IdxDouble',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxDouble >> isDouble [
	
	^ true
]

{ #category : 'reading' }
IdxDouble >> readNextFrom: aReadStream [

	
	^ (aReadStream next: 8) doubleAt: 1 bigEndian: true
]
