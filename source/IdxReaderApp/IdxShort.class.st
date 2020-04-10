"
See superclass comment.
"
Class {
	#name : 'IdxShort',
	#superclass : 'IdxType',
	#category : 'IdxReaderApp'
}

{ #category : 'testing' }
IdxShort >> isShort [
	
	^ true
]

{ #category : 'reading' }
IdxShort >> readNextFrom: aReadStream [

	
	^ (aReadStream next: 2) shortAt: 1 bigEndian: true
]
