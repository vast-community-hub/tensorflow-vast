repoPath := (CfsPath named: CfsDirectoryDescriptor getcwd) append: 'github\tensorflow-vast'.
(TonelLoader readFromPath:  repoPath)
	beUnattended;
	useGitVersion;
	loadAllMapsWithRequiredMaps