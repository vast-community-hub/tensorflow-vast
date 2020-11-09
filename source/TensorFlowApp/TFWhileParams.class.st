Class {
	#name : 'TFWhileParams',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFWhileParams class >> initializeAfterLoad [
	"Set an opaque layout."

	self 
		members: #(#ninputs #cond_graph #cond_inputs #cond_output #body_graph #body_inputs #body_outputs #name)
		types:  #(#int32 #pointer #pointer #TFOutput #pointer #pointer #pointer #pointer)
]

{ #category : 'Accessing' }
TFWhileParams >> bodyGraph [

	^TFGraph address: (self pointerAt: #body_graph)
]

{ #category : 'Accessing' }
TFWhileParams >> bodyInputs [

	^TFOutput address: (self pointerAt: #body_inputs)
]

{ #category : 'Accessing' }
TFWhileParams >> bodyOutputs [

	^TFOutput address: (self pointerAt: #body_outputs)
]

{ #category : 'Accessing' }
TFWhileParams >> condGraph [

	^TFGraph address: (self pointerAt: #cond_graph)
]

{ #category : 'Accessing' }
TFWhileParams >> condInputs [

	^TFOutput address: (self pointerAt: #cond_inputs)
]

{ #category : 'Accessing' }
TFWhileParams >> condOutput [

	^self structAt: #cond_output type: TFOutput
]

{ #category : 'Accessing' }
TFWhileParams >> name [

	^(OSStringZ address: (self pointerAt: #name)) asString 
]

{ #category : 'Accessing' }
TFWhileParams >> ninputs [

	^self int32At: #ninputs
]
