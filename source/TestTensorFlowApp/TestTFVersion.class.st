Class {
	#name : 'TestTFVersion',
	#superclass : 'TensorFlowTestCase',
	#category : 'TestTensorFlowApp'
}

{ #category : 'Tests' }
TestTFVersion >> testEqual [
	| v1 v2 |
	v1 := TFVersion fromString: '1.2.3'.
	v2 := TFVersion immediate: 16r001002003.
	self assert: v1 equals: v2

]

{ #category : 'Tests' }
TestTFVersion >> testGreaterThanOrEqual [
	| v1 v2 |
	v1 := TFVersion fromString: '1.2.3'.
	v2 := TFVersion immediate: 16r001002003.	"1.2.3"
	self assert: (v1 >= v2).
	self assert: (v2 >= v1).
	
	v1 := TFVersion fromString: '1.2.3'.
	self assert: (v1 >= v2).
	self assert: (v2 >= v1).
		
	v1 := TFVersion fromString: '1.2.4'.
	self assert: (v1 >= v2).
	self deny: (v2 >= v1).
		
	v1 := TFVersion fromString: '1.3.3'.
	self assert: (v1 >= v2).
	self deny: (v2 >= v1).
	
	v1 := TFVersion fromString: '1.3.4'.
	self assert: (v1 >= v2).
	self deny: (v2 >= v1).
	
	v1 := TFVersion fromString: '1.3.2'.
	self assert: (v1 >= v2).
	self deny: (v2 >= v1).
	
	

]

{ #category : 'Tests' }
TestTFVersion >> testLessThan [
	| v1 v2 |
	v1 := TFVersion fromString: '1.2.3'.
	v2 := TFVersion immediate: 16r001002003.	"1.2.3"
	self deny: (v1 < v2).
	self deny: (v2 < v1).
	
	v1 := TFVersion fromString: '1.2.4'.
	self assert: (v2 < v1).
	self deny: (v1 < v2).
		
	v1 := TFVersion fromString: '1.3.3'.
	self assert: (v2 < v1).
	self deny: (v1 < v2).
	
	v1 := TFVersion fromString: '1.3.4'.
	self assert: (v2 < v1).
	self deny: (v1 < v2).
	
	v1 := TFVersion fromString: '1.3.2'.
	self assert: (v2 < v1).
	self deny: (v1 < v2).
	
	

]

{ #category : 'Tests' }
TestTFVersion >> testVersion [
	
	| libVersion bindingVersion expected |
	
	libVersion := TFVersion getLibraryVersion.
	bindingVersion := TFVersion getBindingVersion.
	expected := TFVersion fromString: '1.13.1'.
	
	self assert: libVersion >= expected.
	
	self assert: bindingVersion>= expected.
]
