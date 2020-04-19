Class {
	#name : 'TensorboardApplication',
	#superclass : 'WAComponent',
	#category : 'TensorboardWebViews'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardApplication class >> handlerName [

	^'tensorboard'
]

{ #category : 'Registering' }
TensorboardApplication class >> registerAsApplication [

	| application |

	WAAdmin disableDevelopmentTools.
	application := WAAdmin register: self asApplicationAt: self handlerName.
	application preferenceAt: #sessionClass put: self sessionClass.
	application exceptionHandler: WADebugErrorHandler.
	^application
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardApplication class >> sessionClass [

	^WASession
]

{ #category : 'Registering' }
TensorboardApplication class >> unregisterFromApplications [

	WAEnvironment registerDefaultRequestHandlers.
	^ WAAdmin unregister: self handlerName
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardApplication >> applicationTitle [

	^'Tensorboard - VAST'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardApplication >> contentView [

	^TensorboardWebView new
]

{ #category : 'Rendering' }
TensorboardApplication >> renderContentOn: aCanvas [

	aCanvas render: self contentView.
]

{ #category : 'Rendering' }
TensorboardApplication >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot title: self applicationTitle.
	(aRoot link)
		relationship: 'icon';
		url:
			'https://www.gstatic.com/devrel-devsite/prod/v2210deb8920cd4a55bd580441aa58e7853afc04b39a9d9ac4198e1cd7fbe04ef/tensorflow/images/favicon.png'
]
