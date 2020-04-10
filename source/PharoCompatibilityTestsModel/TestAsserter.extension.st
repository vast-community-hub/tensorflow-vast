Extension {
	#name : 'TestAsserter'
}

{ #category : '*PharoCompatibilityTestsModel',
 #vaCategories : ['Asserting'] }
TestAsserter >> assert: actualNumber closeTo: expectedNumber [
	"Tell whether the actualNumber and expectedNumber are close from each with a margin of 0.0001"

	^ self
		assert: (actualNumber closeTo: expectedNumber)
		description: [ self comparingStringBetween: actualNumber and: expectedNumber ]
]

{ #category : '*PharoCompatibilityTestsModel',
 #vaCategories : ['Private'],
  #vaVisibility : 'private' }
TestAsserter >> comparingStringBetween: actual and: expected [

	^String streamContents: [:stream |
		stream
			nextPutAll: 'Got ';
			nextPutAll: actual printString;
			nextPutAll: ' instead of ';
			nextPutAll: expected printString;
			nextPutAll: '.']
]
