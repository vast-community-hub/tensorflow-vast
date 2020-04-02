writer := TonelWriter new.
writer 
	addLatestConfigurationMapNamed: 'TensorFlow';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '..\tonel-repos\tensorflow-vast').

