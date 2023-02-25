Extension {
	#name : 'TFGraph'
}

{ #category : 'debugging' }
TFGraph >> analyzeWithTensorboard [

	GraphUnderAnalysisHolder current analyze: self
]
