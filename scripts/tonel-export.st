| writer path |
path := (CfsPath named: '<insert path to root tensorflow-vast local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'TensorFlow';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
