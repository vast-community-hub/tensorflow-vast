Extension {
	#name : 'TFGraph'
}

{ #category : '*TensorboardWebViews',
 #vaCategories : ['debugging'] }
TFGraph >> analyzeWithTensorboard [

	GraphUnderAnalysisHolder current analyze: self
]
