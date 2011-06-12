/* Viewer
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Viewer
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.11.2003
zuletzt bearbeitet:	30.11.2003
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.*;
import com.adgamewonderland.viewer.*;

class com.adgamewonderland.viewer.Viewer {

  // Attributes

  public var myXmlUrl:String;

  public var myLoader:XMLLoader;
  
  public var myDesc:Object;

  public var myProspectuses:Object;

  public var myAttributes:Attributes;

  public var mySelected:Object;

  // Operations

  public  function Viewer(xmlurl:String ) {
	myXmlUrl = xmlurl; // url der xml-beschreibung
	myLoader = new XMLLoader(this); // loader zum laden der xml-beschreibung
	myDesc = new Object(); // beschreibung des viewers (index: prospekt-id, wert: Attributes instanz)
	myProspectuses = new Object(); // geladene prospekte (index: prospekt-id, wert: Prospectus instanz)
	myAttributes = new Attributes();
	mySelected = {id : "24984", obj : {}}; // aktuell ausgewaehlter prospekt
  }

  public  function initViewer():Void {
	// xml-beschreibung laden
	myLoader.loadXML(myXmlUrl, "parseDesc");
  }

  public  function parseDesc(xmldesc:XML):Void {
	// loader loeschen
	delete(myLoader);
	// leerzeichen ignorieren
	xmldesc.ignoreWhite = true;
	// root-knoten
	var rootXML:XMLNode = xmldesc.lastChild;
	// schleife ueber alle attribute
	for (var i in rootXML.attributes) {
		// attribut speichern
		myAttributes.setValue(i, rootXML.attributes[i]);	
	}
	// schleife ueber alle prospekte
	for (var i = 0; i < rootXML.childNodes.length; i ++) {
		// aktueller prospekt
		var prospectusXML:XMLNode = rootXML.childNodes[i];
		// prospekt-id
		var id:String = prospectusXML.attributes["id"];
		// beschreibung unter id speichern
		myDesc[id] = new Attributes();
		// schleife ueber alle attribute
		for (var j in prospectusXML.attributes) {
			// attribut speichern
			myDesc[id].setValue(j, prospectusXML.attributes[j]);
		}
		// inhalt als "name" speichern
		myDesc[id].setValue("name", prospectusXML.firstChild.nodeValue);
	}
	// von aussen uebergebenen prospekt auswaehlen
	this.selectProspectus(mySelected.id);
  }

  public  function selectProspectus(id:String ):Void {
	trace(id);
  }

  public  function prospectusLoaded():Void
  {

  }

} /* end class Viewer */
