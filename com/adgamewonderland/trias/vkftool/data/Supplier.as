/* Supplier
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplier
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		29.06.2004
zuletzt bearbeitet:	14.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.XMLConnector

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

class com.adgamewonderland.trias.vkftool.data.Supplier {

	// Attributes
	
	private var myId:Number;
	
	private var myName:String;
	
	private var myRanking:Number;
	
	private var myMarketshare:Number;
	
	private var myFacts:Facts;
	
	private var myComment:String;
	
	private var myRating:Rating;
	
	private var myIntegrity:Boolean;
	
	private var myListPos:Number;
	
	private var myXMLConnector:XMLConnector;
	
	// Operations
	
	public  function Supplier(idnum:Number, namestr:String, ranknum:Number, sharenum:Number )
	{
		// eindeutige id (aus csv datei)
		id = idnum;
		// name (aus csv datei)
		name = namestr;
		// ranking nach umsatz am markt (aus csv datei)
		ranking = ranknum;
		// prozentualer umsatz am markt (aus csv datei)
		myMarketshare = sharenum;
		// masterdatensatz (vom user einzugeben)
		myFacts = new Facts();
		// kommentar (vom user einzugeben)
		comment = "";
		// rating (vom user einzugeben)
		myRating = new Rating();
		// vollstaendigkeit der daten
		integrity = false;
		// ist vom user in liste aufgenommen
		listpos = 0;
		// xml connector
		myXMLConnector = new XMLConnector(this, "");
	}
	
	public function get id():Number
	{
		// eindeutige id (aus csv datei)
		return (myId);
	}
	
	public function set id(num:Number ):Void
	{
		// eindeutige id (aus csv datei)
		myId = num;
	}
	
	public function get name():String
	{
		// name (aus csv datei)
		return (myName);
	}
	
	public function set name(str:String ):Void
	{
		// name (aus csv datei)
		myName = str;
	}
	
	public function get ranking():Number
	{
		// ranking nach umsatz am markt (aus csv datei)
		return (myRanking);
	}
	
	public function set ranking(num:Number ):Void
	{
		// ranking nach umsatz am markt (aus csv datei)
		myRanking = num;
	}
	
	public function get marketshare():Number
	{
		// prozentualer umsatz am markt (aus csv datei)
		return (myMarketshare);
	}
	
	public function set marketshare(num:Number ):Void
	{
		// prozentualer umsatz am markt (aus csv datei)
		myMarketshare = num;
	}
	
	public function get facts():Facts
	{
		// masterdatensatz (vom user einzugeben)
		return (myFacts);
	}
	
	public function get comment():String
	{
		// kommentar (vom user einzugeben)
		return(myComment);
	}
	
	public function set comment(str:String ):Void
	{
		// kommentar (vom user einzugeben)
		myComment = str;
	}
	
	public function get rating():Rating
	{
		// rating (vom user einzugeben)
		return (myRating);
	}
	
	public function get integrity():Boolean
	{
		// vollstaendigkeit der daten
		return(myIntegrity);
	}
	
	public function set integrity(bool:Boolean ):Void
	{
		// vollstaendigkeit der daten
		myIntegrity = bool;
	}
	
	public function get listpos():Number
	{
		// ist vom user in liste aufgenommen
		return(myListPos);
	}
	
	public function set listpos(num:Number ):Void
	{
		// ist vom user in liste aufgenommen
		myListPos = num;
	}
	
	public function fromXML(xmlobj:XMLNode ):Void
	{
		// attribute
		// listpos
		listpos = Number(xmlobj.attributes["listpos"]);
		// integrity
		integrity = (xmlobj.attributes["integrity"] == "true" ? true : false);
		// childnodes (facts, comment, rating)
		var children:Array = xmlobj.childNodes;
		// schleife ueber childnodes
		for (var i in children) {
			// aktuelle node
			var node:XMLNode = children[i];
			// art der node
			var type:String = node.nodeName;
			// je nach art
			switch (type) {
				// facts
				case "facts" :
					// schleife ueber parameter
					for (var j in node.childNodes) {
						// aktueller parameter
						var param:XMLNode = node.childNodes[j];
						// in facts speichern
						facts.params[param.attributes["name"]] = param.attributes["value"];
					}
					
					break;
				// comment
				case "comment" :
					// direkt speichern
					comment = node.attributes["value"];
				
					break;
				// rating
				case "rating" :
					// schleife ueber parameter
					for (var k in node.childNodes) {
						// aktueller parameter
						var param:XMLNode = node.childNodes[k];
						// in rating speichern
						rating.params[param.attributes["name"]] = param.attributes["value"];
					}
				
					break;
			}
		}
	}
	
	public function toXML():XMLNode
	{
		// supplier
		var supplierXML:XMLNode = myXMLConnector.getXMLNode("supplier", {id : id, name : name, integrity : integrity, listpos : listpos});
		
		// facts
		var factsXML:XMLNode = myXMLConnector.getXMLNode("facts", {});
		// einhaengen
		supplierXML.appendChild(factsXML);
		// schleife ueber parameter der facts
		for (var i in facts.params) {
			// parameter
			var paramXML:XMLNode = myXMLConnector.getXMLNode("param", {name : i, value : facts.params[i]});
			// einhaengen
			factsXML.appendChild(paramXML);
		}
		
		// comment
		var commentXML:XMLNode = myXMLConnector.getXMLNode("comment", {value : comment});
		// einhaengen
		supplierXML.appendChild(commentXML);
		
		// rating
		var ratingXML:XMLNode = myXMLConnector.getXMLNode("rating", {});
		// einhaengen
		supplierXML.appendChild(ratingXML);
		// schleife ueber parameter des ratings
		for (var i in rating.params) {
			// parameter
			var paramXML:XMLNode = myXMLConnector.getXMLNode("param", {name : i, value : rating.params[i]});
			// einhaengen
			ratingXML.appendChild(paramXML);
		}
	
		// zurueck geben
		return (supplierXML);
	}
	
	public function checkIntegrity():Void
	{
		// parameter updaten (summe der umsaetze im jahresendgeschaeft)
		facts.updateParams();
		// per default alles ausgefuellt (sobald ein parameter gefunden, der nicht ausgefuellt ist, auf false schalten)
		var integer:Boolean = true;
		// wenn nicht vom user in liste aufgenommen, als nicht vollstaendig werten, damit nicht in auswertung beruecksichtigt
		integer = (listpos > 0);
		// schleife ueber alle facts
		for (var i in facts.params) {
			// testen, ob facts ausgefuellt
			if (facts.params[i] == "") {
				// nicht ausgefuellt
				integer = false;
				// schleife abbrechen
				break;
			}
		}
		// testen, ob kommentar ausgefuellt
// 		if (comment == "") integer = false;
		// schleife ueber alle ratings
		for (var i in rating.params) {
			// testen, ob rating ausgefuellt
			if (rating.params[i] == -1) {
				// nicht ausgefuellt
				integer = false;
				// schleife abbrechen
				break;
			}
		}
		// vollstaendigkeit speichern
		integrity = integer;
	}

} /* end class Supplier */
