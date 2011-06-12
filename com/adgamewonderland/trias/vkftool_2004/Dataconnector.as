/* Dataconnector
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Dataconnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		29.06.2004
zuletzt bearbeitet:	14.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.swfstudio.*

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

class com.adgamewonderland.trias.vkftool.Dataconnector {

	// Attributes
	
	private var myFile:Object = {suppliers : "data\\ea_bat_suppliers.csv", userdata : "daten.xml", pccd : "data\\ea_bat_ranking_pccd.csv", ps2 : "data\\ea_bat_ranking_ps2.csv", xbox : "data\\ea_bat_ranking_xbox.csv", gamecube : "data\\ea_bat_ranking_gamecube.csv", gba : "data\\ea_bat_ranking_gba.csv"};
	
	private var mySuppliers:Array;
	
	private var myInterval:Number;
	
	private var myRevenue:Number;
	
	private var myAnalysis:Analysis;
	
	private var myUserdata:XML;
	
	private var myFirstRun:Boolean;
	
	public var myCatalogConnector:CatalogConnector;
	
	public var myFileSys2Connector:FileSys2Connector;
	
	// Operations
	
	public  function Dataconnector(path:String )
	{
		// lieferanten (array mit objekten der klasse Supplier)
		mySuppliers = [];
		// gesamtumsatz
		myRevenue = null;
		// analyse-objekt fuer reports
		myAnalysis = new Analysis(this);
		// daten, die der user eingetragen / gespeichert hat
		myUserdata = new XML();
		// laeuft die anwendung zum ersten mal (sprich myFile["userdata"] existiert noch nicht)
		firstrun = true;
		
		// catalog connector, um daten aus csv-dateien auszulesen
		myCatalogConnector = new CatalogConnector(this, path + ".myCatalogConnector");
		// filesys2 connector, um dateien zu lesen / schreiben
		myFileSys2Connector = new FileSys2Connector(this, path + ".myFileSys2Connector");
		
		// catalog oeffnen
		myCatalogConnector.openCatalog(myFile["suppliers"]);
	}
	
	public function get suppliers():Array
	{
		// lieferanten (array mit objekten der klasse Supplier)
		return (mySuppliers);
	}
	
	public function get revenue():Number
	{
		// gesamtumsatz
		return (myRevenue);
	}
	
	public function set revenue(num:Number ):Void
	{
		// gesamtumsatz
		myRevenue = num;
	}
	
	public function get analysis():Analysis
	{
		// analyse-objekt fuer reports
		return (myAnalysis);
	}
	
	public function get userdata():XML
	{
		// daten, die der user eingetragen / gespeichert hat
		return (myUserdata);
	}
	
	public function get firstrun():Boolean
	{
		// laeuft die anwendung zum ersten mal (sprich myFile["userdata"] existiert noch nicht)
		return (myFirstRun);
	}
	
	public function set firstrun(bool:Boolean ):Void
	{
		// laeuft die anwendung zum ersten mal (sprich myFile["userdata"] existiert noch nicht)
		myFirstRun = bool;
	}
	
	public  function loadSuppliers():Void
	{
		// callback setzen
		myCatalogConnector.callback = "onSuppliersLoaded";
		// SELECT * FROM
		myCatalogConnector.searchPattern("name", "*", "PARTIAL", true);
	}
	
	public  function onSuppliersLoaded(res:Array ):Void
	{
		// schleife ueber geladene zeilen
		for (var i in res) {
			// id
			var id:Number = Number(res[i]["id"]);
			// neues supplier objekt
			mySuppliers[id] = new Supplier(id, res[i]["name"], res[i]["ranking"], res[i]["marketshare"]);
		}
		// catalog schliessen
		myCatalogConnector.closeCatalog();
	}
	
	public function getSupplierByParam(param:String, value ):Supplier
	{
		// schleife ueber supplier
		for (var i in suppliers) {
			// wenn gefunden, supplier zurueck geben
			if (suppliers[i][param] == value) return (suppliers[i]);
		}
	}
	
	public function getSuppliersByParam(param:String, value ):Array
	{
		// array mit suppliern, die kriterium erfuellen
		var supparr:Array = [];
		// schleife ueber supplier
		for (var i in suppliers) {
			// wenn gefunden, in array schrieben
			if (suppliers[i][param] == value) supparr.push(suppliers[i]);
		}
		// zurueck geben
		return (supparr);
	}
	
	public function checkUserdata():Void
	{
		// callback setzen
		myFileSys2Connector.callback = "onUserdataChecked";
		// testen, ob datei vorhanden
		myFileSys2Connector.getFileExists(myFile["userdata"]);
	}
	
	public  function onUserdataChecked(bool:Boolean ):Void
	{
		// laeuft die anwendung zum ersten mal (sprich myFile["userdata"] existiert noch nicht)
		firstrun = !bool;
		// je nachdem, ob datei existiert oder nicht
		switch (bool) {
			// existiert
			case true :
				// datei laden
				loadUserdata();
				
				break;
			// existiert nicht
			case false :
			
				break;
		}
	}
	
	public function loadUserdata():Void
	{
		// callback setzen
		myFileSys2Connector.callback = "onUserdataLoaded";
		// datei laden
		myFileSys2Connector.getReadFile(myFile["userdata"]);
	}
	
	public  function onUserdataLoaded(str:String ):Void
	{
		// string in xml umformen und speichern
		myUserdata.parseXML(str);
		// leerzeichen ignorieren
		myUserdata.ignoreWhite = true;
		// leerzeichen loeschen
// 		stripWhitespaceTraverse(myUserdata);
		// parsen, um supplier mit gespeicherten daten zu fuellen
		parseUserdata();
	}
	
// 	// This function to remove the white space from an XML object was taken 
// 	// from Colin Moock's book, ActionScript: The Definitive Guide.
// 	private function stripWhitespaceTraverse (xmlobj:XML ):Void
// 	{
// 		var nodeList = new Array();
// 		nodeList[0] = xmlobj;
// 		while (nodeList.length > 0) {
// 			var currentNode = nodeList.shift();
// 			if (currentNode.childNodes.length > 0) {
// 				nodeList = nodeList.concat(currentNode.childNodes);
// 			} else {
// 				if (currentNode.nodeType == 3) {
// 					var i = 0;
// 					var emptyNode = true;
// 					for(i = 0; i < currentNode.nodeValue.length; i++) {
// 						if(currentNode.nodeValue.charCodeAt(i) > 32) {
// 							emptyNode = false;
// 							break;
// 						}
// 					}
// 				}
// 				if(emptyNode) {
// 					currentNode.removeNode();
// 				}
// 			} 
// 		}
// 	}
	
	private function parseUserdata():Void
	{
		// gesamtumsatz ist attribut der userdata
		revenue = Number(userdata.firstChild.attributes["revenue"]);
		// suppliers sind childnodes der userdata
		var suppliernodes:Array = userdata.firstChild.childNodes;
		// schleife ueber suppliers
		for (var i in suppliernodes) {
			// aktueller supplier
			var supplierXML:XMLNode = suppliernodes[i];
			// id
			var id:Number = Number(supplierXML.attributes["id"]);
			// xml an supplier uebergeben
			suppliers[id].fromXML(supplierXML);
		}
		// analyse updaten
		analysis.updateAnalysis();
	}
	
	public  function updateUserdata():Void
	{
		// neues xml-object
		var xmlHead = new XML();
		// content type
		xmlHead.contentType="text/xml";
		// declaration
		xmlHead.xmlDecl = "<?xml version=\"1.0\" encoding=\"ISO8859-15\" standalone=\"yes\" ?>";
		
		// root-knoten
		var xmlRoot = xmlHead.createElement("userdata");
		// einhaengen
		xmlHead.appendChild(xmlRoot);
		// aktuelles datum
		var now:Date = new Date();
		// als attribut
		xmlRoot.attributes["date"] = now.toString();
		// gesamtumsatz als attribut
		xmlRoot.attributes["revenue"] = revenue;
		
		// schleife ueber alle lieferanten
		for (var i in suppliers) {
			// informationen ueber supplier als xml
			var supXML:XMLNode = suppliers[i].toXML();
			// einhaengen
			xmlRoot.appendChild(supXML);
		}
		
		// speichern
		saveUserdata(xmlHead);
	}
	
	private  function saveUserdata(xmlobj:XML ):Void
	{
		// callback setzen
		myFileSys2Connector.callback = "onUserdataSaved";
		// datei speichern
		myFileSys2Connector.setWriteToFile(myFile["userdata"], xmlobj.toString());
	}
	
	public  function onUserdataSaved(res:String ):Void
	{
		// laeuft die anwendung zum ersten mal (sprich myFile["userdata"] existiert noch nicht)
		firstrun = false;
		// analyse updaten
		analysis.updateAnalysis();
	}
	
	public  function loadGames(platform:String, id:Number, caller:Object, callback, String ):Void
	{
		// catalog oeffnen
		myCatalogConnector.openCatalog(myFile[platform]);
		// caller setzen
		myCatalogConnector.caller = caller;
		// callback setzen
		myCatalogConnector.callback = callback;
		
		// nach pause suchen
		myInterval = setInterval(this, "searchGames", 2000, suppliers[id].name);
	}
	
	public  function searchGames(name:String ):Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// SELECT * FROM
		myCatalogConnector.searchPattern("supplier", name, "EXACT", true);
	}

} /* end class Dataconnector */
