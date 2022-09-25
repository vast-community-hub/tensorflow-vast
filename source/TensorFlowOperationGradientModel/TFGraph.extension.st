Extension {
	#name : 'TFGraph'
}

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['gradients'] }
TFGraph >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput [

	^ self library
		gradientsOf: yArrayOfTFOutput
		withRespectTo: xArrayOfTFOutput
		product: dxArrayOfOutput
		in: self
]
