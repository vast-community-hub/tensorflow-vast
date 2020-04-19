Class {
	#name : 'TensorboardWebViews',
	#superclass : 'Application',
	#category : 'TensorboardWebViews'
}

{ #category : 'EM-API' }
TensorboardWebViews class >> startUp [
		
	super startUp. 
	
	GraphUnderAnalysisHolder clearCurrent
]
