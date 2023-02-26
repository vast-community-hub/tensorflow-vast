AbtFeatureLoader new 
	loadFeatureMapsNamed: #(
		'z.ST: Refactoring Browser'
		'z.ST: Server Smalltalk (SST) - Seaside'
		'z.ST: Tonel Support'
		'z.ST: SUnit'
	).

repoPath := (CfsPath named: CfsDirectoryDescriptor getcwd) append: 'github\tensorflow-vast'.
(TonelLoader readFromPath: repoPath)
	beUnattended;
	useGitVersion;
	loadAllMapsWithRequiredMaps