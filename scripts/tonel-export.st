TonelWriter new
	dontClearSourcesDirectory;
	useLfEOL;
	addLatestConfigurationMapNamed: 'Pharo Compatibility | Runtime';
	addLatestConfigurationMapNamed: 'TensorFlow';
	addLatestConfigurationMapNamed: 'TensorFlow Computation | Runtime';
	addLatestConfigurationMapNamed: 'TensorFlow Computation | Development';
	addLatestConfigurationMapNamed: 'TensorFlow | Visualization';
	addLatestConfigurationMapNamed: 'Machine Learning TF | Runtime';
	addLatestConfigurationMapNamed: 'Machine Learning TF | Development';
	addLatestConfigurationMapNamed: 'Machine Learning TF | Experimental';	
	addApplicationsFromConfigurationMaps;
	writeProjectInto: ((CfsPath named: CfsDirectoryDescriptor getcwd) append: 'github\tensorflow-vast').
	