Extension {
	#name : 'TFGraph'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['gradients'] }
TFGraph >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput [

	^self gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: nil
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['gradients'] }
TFGraph >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput [

	^ self library
		gradientsOf: yArrayOfTFOutput
		withRespectTo: xArrayOfTFOutput
		product: dxArrayOfOutput
		in: self
]
