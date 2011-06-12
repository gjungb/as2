class com.adgamewonderland.test.XMLLoader {
	/**Attributes: */
	var myCaller:Object;
	var myCallback:String;
	var serverXML:XML = new XML();
	var fileXML:String;
	/** Public methods: */
	// function loadXML laedt uebergebenes XML
	function loadXML(filename:String, caller:Object, callback:String):Void {
		trace(filename);
		// datei oder skript
		fileXML = filename;
		// caller
		myCaller = caller;
		// callback
		myCallback = callback;
		// referenz auf loader
		serverXML.caller = this;
		// callback nach laden
		serverXML.onLoad = function() {
			// geladenes XML uebergeben
			caller.XMLloaded(this);
		};
		// laden
		serverXML.load(fileXML);
	}
	// function XMLLoaded reicht geladenes XML an caller zurueck
	function XMLLoaded(xmlobj:XML):Void {
		// uebergebenes XML weiter reichen
		myCaller[myCallback](xmlobj);
	}
}
