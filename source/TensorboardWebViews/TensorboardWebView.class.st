Class {
	#name : 'TensorboardWebView',
	#superclass : 'WAPainter',
	#category : 'TensorboardWebViews'
}

{ #category : 'Accessing - JS',
  #vaVisibility : 'private' }
TensorboardWebView >> checkSiteIntegrityJs [

	^'
	var checkSiteIntegrity = (text) => {
		var hashOf = (str) => { return Array.from(str).reduce((s, c) => Math.imul(31, s) + c.charCodeAt(0) | 0, 0) }
		if( hashOf(text) != 456863669 )  console.log("Content of fetched site changed!"); 
		return text;
	}'
]

{ #category : 'Accessing - JS',
  #vaVisibility : 'private' }
TensorboardWebView >> createGraphComponentJs [

	| functionStream |

	functionStream := JSStream new.
	functionStream nextPutAll: (
		' 
	var createGraphComponent = (text) => {
		var frame = document.getElementById( "%1" );
		frame.srcdoc = text.replace(/tf-graph-basic.build.js/, "%2");'
			bindWith: self tensorboardFrameId
			with: self tfGraphBasicBuildJsUrl).

	GraphUnderAnalysisHolder current withDefinitionTextDo: [:def |
		functionStream nextPutAll: (
			'
		frame.onload = function(){
			var ifrDoc = frame.contentDocument;
			var elem = ifrDoc.createElement("tf-graph-basic");
			elem.pbtxt = ''%1'';
			ifrDoc.body.appendChild(elem);
		}'
				bindWith: def)].

	functionStream nextPutAll: '}'.
	^functionStream contents
]

{ #category : 'Accessing - JS',
  #vaVisibility : 'private' }
TensorboardWebView >> fetchGraphBasicBuildHtml [

	^'	
	fetch("%1").
		then(response => { if(!response.ok) throw Error(response.statusText); return response.text() }).
		then(checkSiteIntegrity).
		then(createGraphComponent).
		catch(error => console.log(error) );'
		bindWith: self tfGraphBasicBuildHtmlUrl
]

{ #category : 'Rendering' }
TensorboardWebView >> renderContentOn: aCanvas [

	aCanvas document addLoadScript: (
		JSScript new
			<< (JSStream new
					nextPutAll: self checkSiteIntegrityJs;
					nextPutAll: self createGraphComponentJs;
					nextPutAll: self fetchGraphBasicBuildHtml;
					yourself);
			yourself).

	aCanvas iframe
		attributeAt: 'seamless' put: true;
		style: 'width:800px;height:620px;border:0';
		id: 'tb-frame'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardWebView >> tensorboardFrameId [

	^'tb-frame'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardWebView >> tfGraphBasicBuildHtmlUrl [

	^'https://tensorboard.appspot.com/tf-graph-basic.build.html'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardWebView >> tfGraphBasicBuildJsUrl [

	^'https://tensorboard.appspot.com/tf-graph-basic.build.js'
]
