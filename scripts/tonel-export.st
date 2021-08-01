TonelWriter new
	dontClearSourcesDirectory;
	useLfEOL;
	addLatestConfigurationMapNamed: 'Machine Learning TF | Runtime';
	addLatestConfigurationMapNamed: 'Machine Learning TF | Development';
	addLatestConfigurationMapNamed: 'Machine Learning TF | Experimental';
	addLatestConfigurationMapNamed: 'Pharo Compatibility | Runtime';
	addLatestConfigurationMapNamed: 'Pharo Compatibility | Development';
	addLatestConfigurationMapNamed: 'TensorFlow';
	addLatestConfigurationMapNamed: 'TensorFlow | Environment';
	addLatestConfigurationMapNamed: 'TensorFlow | Visualization';
	addApplicationsFromConfigurationMaps;
	writeProjectInto: ((CfsPath named: CfsDirectoryDescriptor getcwd) append: 'github\tensorflow-vast').