/*
klasse:			Prospectus
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.11.2003
zuletzt bearbeitet:	01.12.2003
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.*;
import com.adgamewonderland.viewer.*;

//Prospectus
class com.adgamewonderland.viewer.Prospectus {
	/**Attributes: */
	var myDesc:Array;
	var isLoaded:Boolean;
	var myLoader:XMLLoader;
	var myViewer:Viewer;
	var myCallback:String;
	var myAttributes:Attributes;
	/** public methods: */
	function Prospectus(viwer:Viewer) {
		myViewer = viewer; // referenz auf viewer
		myDesc = new Object(); // beschreibung des prospekts
		isLoaded = false; // beschreibung noch nicht geladen
		myLoader = new XMLLoader(this); // loader zum laden der xml-beschreibung
		
	}
	function initProspectus(id:String, folder:String, caller:Viewer, callback:String) :Void {
		// TODO pfad zusammen bauen, prospektbeschreibung laden
		// xml-beschreibung laden
		myLoader.loadXML(myXmlUrl, "parseDesc");
	}

	function parseDesc(xmldesc:XML) :Void {

	}

	function getIsLoaded() :Boolean {
		return(isLoaded);
	}

	function setIsLoaded(loaded:Boolean) :Void {

	}

	function getAttributeValue(attribute:String) :String {
		return("");

	}

}
