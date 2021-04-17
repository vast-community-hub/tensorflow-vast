Class {
	#name : 'TensorFlowCAPISlowTests',
	#superclass : 'TensorFlowTestCase',
	#instVars : [
		'library'
	],
	#category : 'TensorFlowCoreTests'
}

{ #category : 'test support',
  #vaVisibility : 'private' }
TensorFlowCAPISlowTests >> assertCreating: anAmount of: aTensorFlowObjectCreator releasesExternalMemoryRepeatingUpTo: timesRepeat [

	| total handles |

	total := 0.
	handles := Set new.
	timesRepeat timesRepeat: [
		total := total + anAmount.
		handles addAll: (
			(1 to: anAmount) collect: [:i |
				self garbageCollect.
				aTensorFlowObjectCreator value address]).
		handles size < total ifTrue: [^self]].
	self assert: handles size < total
]

{ #category : 'testing session' }
TensorFlowCAPISlowTests >> testDeviceListFinalizationReleasesExternalMemory [

	| session graph |

	graph := TFGraph create.
	session := TFSession on: graph.
	self assertCreating: 20 of: [TFDeviceList on: session] releasesExternalMemoryRepeatingUpTo: 20
]

{ #category : 'testing graph' }
TensorFlowCAPISlowTests >> testGraphFinalizationReleasesExternalMemory [

	self
		assertCreating: 10
		of: [TFGraph create useFinalization]
		releasesExternalMemoryRepeatingUpTo: 20
]

{ #category : 'testing session' }
TensorFlowCAPISlowTests >> testSessionFinalizationReleasesExternalMemory [

	| graph |

	graph := TFGraph create.
	self assertCreating: 20 of: [TFSession on: graph] releasesExternalMemoryRepeatingUpTo: 20
]

{ #category : 'testing options' }
TensorFlowCAPISlowTests >> testSessionOptionFinalizationReleasesExternalMemory [

	self assertCreating: 10 of: [TFSessionOptions create] releasesExternalMemoryRepeatingUpTo: 20
]

{ #category : 'testing status' }
TensorFlowCAPISlowTests >> testStatusFinalizationReleasesExternalMemory [

	self assertCreating: 11 of: [TFStatus create] releasesExternalMemoryRepeatingUpTo: 1
]

{ #category : 'testing tensor' }
TensorFlowCAPISlowTests >> testTensorFinalizationReleasesExternalMemory [

	| template |

	template :=
		(Array new: 3)
			at: 1 put: (String new: 10);
			at: 2 put: (String new: 100);
			at: 3 put: (String new: 1000);
			yourself.
	self
		assertCreating: 20
		of: [TFTensor fromStringArray: template]
		releasesExternalMemoryRepeatingUpTo: 20
]
