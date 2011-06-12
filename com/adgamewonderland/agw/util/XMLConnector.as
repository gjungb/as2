/*
klasse:			XMLConnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		21.04.2004
zuletzt bearbeitet:	22.05.2004
durch			gj
status:			final
*/

class com.adgamewonderland.agw.util.XMLConnector {

	// Attributes
	
	private var myCaller:Object;
	
	private var myCallback:String;
	
	private var myUrl:String;
	
	// Operations
	
	public function XMLConnector(caller:Object , url:String )
	{
		// object, das den connector instantiiert
		myCaller = caller;
		// url, mit dem die xml-daten ausgetauscht werden
		myUrl = url;
	}
	
	public function onXMLLoaded(xmlobj:XML ):Void
	{
		// uebergebenes XML weiter reichen
		myCaller[myCallback](xmlobj);
	}
	
	public function sendXML(xmlobj:XML , callback:String ):Void
	{
		// falls callback nicht leer, senden und empfangen
		if (callback != "") {
			// callback
			myCallback = callback;
			// xml-object, das bei sendAndLoad daten empfaengt
			var receiver:XML = new XML();
			// ohne leerzeichen
			receiver.ignoreWhite = true;
			// caller
			receiver["caller"] = this;
			// callback nach laden
			receiver.onLoad = function() {
				// geladenes XML uebergeben
				this.caller.onXMLLoaded(this);
			};
			// senden und laden
			xmlobj.sendAndLoad(myUrl, receiver);
		
		// nur senden
		} else {
			// senden
			xmlobj.send(myUrl, "_blank");
		}
	}
	
	public function loadXML(callback:String ):Void
	{
		// callback
		myCallback = callback;
		// XML object
		var xmlobj:XML = new XML();
		// ohne leerzeichen
		xmlobj.ignoreWhite = true;
		// caller
		xmlobj["caller"] = this;
		// callback nach laden
		xmlobj.onLoad = function() {
			// geladenes XML uebergeben
			this.caller.onXMLLoaded(this);
		};
		// laden
		xmlobj.load(myUrl);
	}
	
	public function setUrl(url:String ):Void
	{
		// url, mit dem die xml-daten ausgetauscht werden
		myUrl = url;
	}
	
	public function getXMLHead(nodename:String, attrib:Object ):XML
	{
		// neues xml-object
		var xmlHead = new XML();
		// content type
		xmlHead.contentType="text/xml";
		// declaration
		xmlHead.xmlDecl = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>";

		// root-knoten
		var xmlRoot = xmlHead.createElement(nodename);
		// einhaengen
		xmlHead.appendChild(xmlRoot);
		// schleife ueber attribute
		for (var i in attrib) {
			// in xml schreiben
			xmlRoot.attributes[i] = attrib[i];
		}
		// zurueck geben
		return (xmlHead);
	}
	
	public function getXMLNode(nodename:String, attrib:Object ):XMLNode
	{
		// neues xml-object
		var xmlHead = new XML();
		// neues xmlnode-object
		var xmlNode = xmlHead.createElement(nodename);
		
		// schleife ueber attribute
		for (var i in attrib) {
			// in xml schreiben
			xmlNode.attributes[i] = attrib[i];
		}
		// zurueck geben
		return (xmlNode);
	}
	
	public function parseXMLNode(node:XMLNode ):Object
	{
		// neues object
		var obj:Object = {};
		// schleife ueber attribute
		for (var i in node.attributes) {
			// in object schreiben
			obj[i] = node.attributes[i];
		}
		// zurueck geben
		return (obj);
	}

} /* end class XMLConnector */
