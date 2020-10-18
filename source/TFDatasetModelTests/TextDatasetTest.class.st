Class {
	#name : 'TextDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
TextDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| fileName |

	fileName := 'testIterateThroughDataset.csv'.
	[| dataset iterator |
		fileName asFileReference writeStreamDo: [:stream |
			stream
				nextPutAll: '1,2,3,4';
				cr;
				nextPutAll: 'you''ve got the wrong dude'].
		dataset := TextDataset on: tf readingFrom: fileName withBufferSized: 8 * 1024 * 1024.

		self assertDatasetHasExpectedOutput: dataset.

		iterator :=
			DatasetIterator
				on: tf
				iterating: dataset
				knowingOutputIsTyped: TFTensor typeString
				withShape: TensorShape scalar.
		self assertOutputOf: iterator next isAStringEqualTo: '1,2,3,4'.
		self assertOutputOf: iterator next isAStringEqualTo: 'you''ve got the wrong dude'.
		self assertReachedEnd: iterator]
			ensure: [fileName asFileReference delete]
]
