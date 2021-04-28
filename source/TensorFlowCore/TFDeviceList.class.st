Class {
	#name : 'TFDeviceList',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFDeviceList class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'Instance creation' }
TFDeviceList class >> on: aTFSession [

	^TensorFlowCAPI current deviceListForSession: aTFSession
]

{ #category : 'Accesssing' }
TFDeviceList >> at: anInteger [
	^ TFDevice
		name: (self nameAt: anInteger)
		type: (self typeAt: anInteger)
		memory: (self memoryAt: anInteger)
		incarnation: (self incarnationAt: anInteger)
		
]

{ #category : 'Accesssing' }
TFDeviceList >> basicDelete [
	^ self library deleteDeviceList: self
]

{ #category : 'Accesssing' }
TFDeviceList >> count [
	^ self library deviceListCount: self
]

{ #category : 'Accesssing' }
TFDeviceList >> devices [
	^ (1 to: self count) collect: [:i |
		self at: i]
]

{ #category : 'Accesssing' }
TFDeviceList >> incarnationAt: anInteger [

	^self library deviceList: self incarnationAt: anInteger - 1
]

{ #category : 'Accesssing' }
TFDeviceList >> memoryAt: anInteger [
	
	^ self library deviceList: self memoryAt: anInteger-1 
]

{ #category : 'Accesssing' }
TFDeviceList >> nameAt: anInteger [

	^self library deviceList: self nameAt: anInteger - 1
]

{ #category : 'Accesssing' }
TFDeviceList >> names [
	^ (1 to: self count) collect: [:i |
		self nameAt: i]
]

{ #category : 'Accesssing' }
TFDeviceList >> typeAt: anInteger [

	^self library deviceList: self typeAt: anInteger - 1
]
