loader := TonelLoader readFromPath:  ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '..\tonel-repos\tensorflow-vast').
loader 
	beUnattended; 
	useGitVersion.
"Uncomment following line to force the creation of new editions when loading from Tonel."
 "loader forceCreationOfEditions."
loader loadAllMapsWithRequiredMaps.