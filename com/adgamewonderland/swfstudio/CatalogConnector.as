/* CatalogConnector
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			CatalogConnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		25.06.2004
zuletzt bearbeitet:	30.06.2005
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

class com.adgamewonderland.swfstudio.CatalogConnector {

	// Attributes
	
	private var myCaller:Object;
	
	private var myPath:String;
	
	private var myCallback:String;
	
	private var myAction:String;
	
	private var myFields:Array;
	
	private var myResult:String;
	
	private var mySessionid:String;
	
	// Operations
	
	public function CatalogConnector(callerobj:Object, pathstr:String )
	{
		// object, das den connector aufruft
		caller = callerobj;
		// vollstaendiger pfad
		path = pathstr;
		// callback, das die ergebnisse verarbeitet
		myCallback = "";
		// aktuell ausgefuehrte aktion
		myAction = "";
		// spalten der datentabelle
		myFields = [];
		// ergebnis der abfrage
		myResult = "";
		// session id zur identifizierung der verbindung
		mySessionid = "session";
		
		// aenderungen des ergebnisses ueberwachen
		this.watch("result", onResult);
	}
	
	public function set caller(obj:Object ):Void
	{
		// object, das den connector aufruft
		myCaller = obj;
	}
	
	public function get caller():Object
	{
		// object, das den connector aufruft
		return (myCaller);
	}
	
	public function set path(str:String ):Void
	{
		// vollstaendiger pfad
		myPath = str;
	}
	
	public function get path():String
	{
		// vollstaendiger pfad
		return (myPath);
	}
	
	public function set callback(str:String ):Void
	{
		// callback, das die ergebnisse verarbeitet
		myCallback = str;
	}
	
	public function get callback():String
	{
		// callback, das die ergebnisse verarbeitet
		return (myCallback);
	}
	
	public function set action(str:String ):Void
	{
		// aktuell ausgefuehrte aktion
		myAction = str;
	}
	
	public function get action():String
	{
		// aktuell ausgefuehrte aktion
		return (myAction);
	}
	
	public function set fields(arr:Array ):Void
	{
		// spalten der datentabelle
		myFields = arr;
	}
	
	public function get fields():Array
	{
		// spalten der datentabelle
		return (myFields);
	}
	
	public function set result(str:String ):Void
	{
		// ergebnis der abfrage
		myResult = str;
	}
	
	public function get result():String
	{
		// ergebnis der abfrage
		return (myResult);
	}
	
	public function get resultvar():String
	{
		// vollstaendiger pfad zu der variable, die das result aufnimmt
		return (path + ".result");
	}
	
	private function onResult(prop:String, oldval:String, res:String):String
	{
// 		fscommand("Debug", getTimer() + ": " + action + ": " + res);
		// je nach action
		switch (action) {
			// session wurde erstellt
			case "Catalog.CreateSession" :
				// fehlermeldung, falls session nicht korrekt erstellt
// 				if (res != "OK") fscommand("Debug", action + ": " + res);
				
				break;
			// katalog wurde geladen
			case "Catalog.Load" :
				// fehlermeldung, falls katalog nicht korrekt geladen
// 				if (res != "OK") fscommand("Debug", action + ": " + res);
				
				break;
			// feldnamen wurden geladen
			case "Catalog.Fields" :
				// in array umformen und speichern
				fields = res.split("\t");
// 				fscommand("Debug", action + ": " + fields.join("#"));
				
				break;
			// ergebnis wurde geholt
			case "Catalog.Results" :
// 				fscommand("Debug", action + ": " + res);
				// in array umformen und zurueck geben
				caller[callback](resultToArray(res));
				
				break;
			// session wurde geloescht
			case "Catalog.DestroySession" :
				// fehlermeldung, falls session nicht korrekt geloescht
// 				if (res != "OK") fscommand("Debug", action + ": " + res);
				
				break;
		}
		// neuen wert uebernehmen
		return (res);
	}
	
	public function openCatalog(file:String ):Void
	{
		// wenn file ohne vollen pfad, tempdir voran stellen, damit internal file gefunden wird
		if (file.indexOf(":") == -1) file = _level0.ssTempDir + "\\" + file;
		// session erstellen
		action = "Catalog.CreateSession";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand(action, "");
		fscommand("Clr", "");
		// katalog laden
		action = "Catalog.Load";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand("Arg", file);
		fscommand(action, "");
		fscommand("Clr", "");
		// feldnamen laden
		action = "Catalog.Fields";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand(action, "");
		fscommand("Clr", "");
	}
	
	public function searchPattern(fieldname:String, pattern:String, matchtype:String, exclusive:Boolean ):Void
	{
		// resetten, um neue suche zu ermoeglichen
		action = "Catalog.Reset";
		fscommand("Arg", mySessionid);
		fscommand(action, "");
		// suchkriterien definieren
		action = "Catalog.AddPattern";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar); // ""
		fscommand("Arg", fieldname);
		fscommand("Arg", pattern);
		fscommand("Arg", matchtype);
		fscommand("Arg", exclusive.toString());
		fscommand(action, "");
		fscommand("Clr", "");
		// suche ausfuehren
		action = "Catalog.Find";
		fscommand("Arg", mySessionid);
		fscommand("Arg", "");
		fscommand(action, "");
		fscommand("Clr", "");
		// ergebnis holen
		action = "Catalog.Results";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand("Arg", "");
		fscommand("Arg", "");
		fscommand("Arg", "");
		fscommand(action, "");
		fscommand("Clr", "");
	}
	
	public function searchRange(fieldname:String, lowvalue:String, highvalue:String, matchtype:String, exclusive:Boolean ):Void
	{
		// resetten, um neue suche zu ermoeglichen
		action = "Catalog.Reset";
		fscommand("Arg", mySessionid);
		fscommand(action, "");
		// suchkriterien definieren
		action = "Catalog.AddRange";
		fscommand("Arg", mySessionid);
		fscommand("Arg", "");
		fscommand("Arg", fieldname);
		fscommand("Arg", lowvalue);
		fscommand("Arg", highvalue);
		fscommand("Arg", matchtype);
		fscommand("Arg", exclusive.toString());
		fscommand(action, "");
		fscommand("Clr", "");
		// suche ausfuehren
		action = "Catalog.Find";
		fscommand("Arg", mySessionid);
		fscommand("Arg", "");
		fscommand(action, "");
		fscommand("Clr", "");
		// ergebnis holen
		action = "Catalog.Results";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand("Arg", "");
		fscommand("Arg", "");
		fscommand("Arg", "");
		fscommand(action, "");
		fscommand("Clr", "");
	}
	
	public function closeCatalog():Void
	{
		// session loeschen
		action = "Catalog.DestroySession";
		fscommand("Arg", mySessionid);
		fscommand("Arg", resultvar);
		fscommand(action, "");
		fscommand("Clr", "");
		
		// fields leeren
		fields = [];
	}
	
	private function resultToArray(res:String ):Array
	{
		// array mit suchergebnissen als objekts
		var arr:Array = [];
		// array mit allen zeilen des suchergebnisses
		var rows:Array = res.split(String.fromCharCode(13));
		// schleife ueber alle zeilen
		for (var i:Number = 0; i < rows.length - 1; i ++) {
			// aktuelle zeile mit allen werten
			var row:Array = rows[i].split("\t");
			// objekt fuer suchergebnisse
			var obj:Object = {};
			// schleife ueber alle spalten
			for (var j in row) {
				// spaltenueberschrift
				var field:String = fields[j];
				// inhalt der spalte
				obj[field] = row[j];
			}
			// in array schreiben
			arr.push(obj);
		}
		// zurueck geben
		return (arr);
	}

} /* end class CatalogConnector */
