Class {
	#name : 'TFSynchronousCallEngine',
	#superclass : 'TFCallEngine',
	#category : 'TensorFlowApp'
}

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction [
	"Perform 0-arg sync call"

	^aPlatformFunction call
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 [
	"Perform 1-arg sync call"

	^aPlatformFunction callWith: arg1
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 [
	"Perform 2-arg sync call"

	^aPlatformFunction callWith: arg1 with: arg2
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 [
	"Perform 3-arg sync call"

	^aPlatformFunction callWith: arg1 with: arg2 with: arg3
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 [
	"Perform 4-arg sync call"

	^aPlatformFunction callWith: arg1 with: arg2 with: arg3 with: arg4
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 [
	"Perform 5-arg sync call"

	^aPlatformFunction callWith: arg1 with: arg2 with: arg3 with: arg4 with: arg5
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 [
	"Perform 6-arg sync call"

	^aPlatformFunction callWith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 [
	"Perform 7-arg sync call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 [
	"Perform 8-arg sync call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 [
	"Perform 9-arg call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
		with: arg9
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 [
	"Perform 10-arg call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
		with: arg9
		with: arg10
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 [
	"Perform 11-arg call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
		with: arg9
		with: arg10
		with: arg11
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 [
	"Perform 12-arg call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
		with: arg9
		with: arg10
		with: arg11
		with: arg12
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 with: arg13 [
	"Perform 13-arg call"

	^aPlatformFunction
		callWith: arg1
		with: arg2
		with: arg3
		with: arg4
		with: arg5
		with: arg6
		with: arg7
		with: arg8
		with: arg9
		with: arg10
		with: arg11
		with: arg12
		with: arg13
]

{ #category : 'API' }
TFSynchronousCallEngine >> call: aPlatformFunction withAll: anArrayOfArguments returnInto: anOSStructure [
	"Perform n-arg sync call that returns a struct by value"

	^aPlatformFunction callWithArguments: anArrayOfArguments returnValue: anOSStructure
]
