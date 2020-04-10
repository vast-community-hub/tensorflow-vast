"
See superclass comment.
"
Class {
	#name : 'IdxInt',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxInt >> isInt [
	
	^ true
]

{ #category : 'reading' }
IdxInt >> readNextFrom: aReadStream [

	
	^ (aReadStream next: 4) longAt: 1 bigEndian: true
]
