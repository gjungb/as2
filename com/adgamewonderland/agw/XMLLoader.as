/* XMLLoader
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			XMLLoader
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.11.2003
zuletzt bearbeitet:	30.11.2003
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.XMLLoader{

  // Attributes

  public var myCaller:Object;

  public var myCallback:String;

  public var serverXML:XML;

  // Operations
  
  public function XMLLoader(caller:Object) {
	myCaller = caller;
	myCallback = "";
	serverXML = new XML();	  
  }

  public  function loadXML(url:String , callback:String ):Void {
	// callback
	myCallback = callback;
	// XML object
	serverXML = new XML();
	// caller
	serverXML["caller"] = this;
	// callback nach laden
	serverXML.onLoad = function() {
		// geladenes XML uebergeben
		this.caller.XMLloaded(this);
	};
	// laden*/
	serverXML.load(url);
  }

  public  function XMLLoaded(xmlobj:XML ):Void {
	// uebergebenes XML weiter reichen
	myCaller[myCallback](xmlobj);
  }

} /* end class XMLLoader */
