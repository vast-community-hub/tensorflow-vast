Class {
	#name : 'TFDeviceList',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFDeviceList class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'Instance creation' }
TFDeviceList class >> on: aTFSession [
	| answer status |
	status := TFStatus create.
	answer := TensorFlowCAPI current deviceListForSession: aTFSession status: status.
	status check.
	answer useFinalization.
	^ answer
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
	| answer status |
	status := TFStatus new.
	answer := self library deviceList: self incarnationAt: anInteger-1 status: status.
	status check.
	^ answer
]

{ #category : 'Accesssing' }
TFDeviceList >> memoryAt: anInteger [
	| answer status |
	status := TFStatus new.
	answer := self library deviceList: self memoryAt: anInteger-1 status: status.
	status check.
	^ answer
]

{ #category : 'Accesssing' }
TFDeviceList >> nameAt: anInteger [
	| external status |
	status := TFStatus new.
	external := self library deviceList: self nameAt: anInteger-1 status: status.
	status check.
	^ external
]

{ #category : 'Accesssing' }
TFDeviceList >> names [
	^ (1 to: self count) collect: [:i |
		self nameAt: i]
]

{ #category : 'Accesssing' }
TFDeviceList >> typeAt: anInteger [
	| answer status |
	status := TFStatus new.
	answer := self library deviceList: self typeAt: anInteger-1 status: status.
	status check.
	^ answer
]
