
	" Generate the prerequisites graph for the selected cms "
	
	| apps allDependents dependentsOf cms |
	
	cms := #(
		'Machine Learning TF | Runtime'
		"'Machine Learning TF | Development'"
		'Machine Learning TF | Experimental'
		'Pharo Compatibility | Runtime'
		"'Pharo Compatibility | Development'"
		'TensorFlow' 
		'TensorFlow | Environment' 
	).
	
	apps := cms 
		flatCollect: [:cm | 
			(EmConfigurationMap editionsFor: cm) first shadowApplications 
				collect: #residentApplication]
		as: OrderedCollection.
		
	dependentsOf := [:app | app prerequisites select: [:pr | apps includes: pr]].

	allDependents := Set new.
	[apps isEmpty] whileFalse: [
		allDependents addAll: (
			apps
				flatCollect: [:app |
					(dependentsOf value: app) collect: [:dependent | dependent -> app]]
				as: Set).
		apps := apps flatCollect: [:app | dependentsOf value: app] as: Set].

	String streamContents: [:stream | 
		stream nextPutAll: 'digraph G {'; cr.
		 
		allDependents asArray collect: [:dependent |
			stream
				nextPutAll: ('"%1" -> "%2"' bindWith: dependent value with: dependent key );
				cr].
			
		stream nextPutAll: '}'.	
	]

	