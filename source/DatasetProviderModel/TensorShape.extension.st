Extension {
	#name : 'TensorShape'
}

{ #category : '*DatasetProviderModel',
 #vaCategories : ['Testing'] }
TensorShape >> isCompatibleWithNHWShapes [
	
	"NHW shape is those with (number of images in the batch, height, width) shape "
	
	^self rank = 3
]
