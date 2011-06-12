/* FileSys2Connector
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			FileSys2Connector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.06.2004
zuletzt bearbeitet:	28.06.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.swfstudio.FileSys2Connector {

	// Attributes
	
	private var myCaller:Object;
	
	private var myPath:String;
	
	private var myCallback:String;
	
	private var myAction:String;
	
	private var myResult:String;
	
	private var myDir:String;
	
	// Operations
	
	public  function FileSys2Connector(callerobj:Object, pathstr:String )
	{
		// object, das den connector aufruft
		caller = callerobj;
		// vollstaendiger pfad
		path = pathstr;
		// callback, das die ergebnisse verarbeitet
		myCallback = "";
		// aktuell ausgefuehrte aktion
		myAction = "";
		// ergebnis der aktion
		myResult = "";
		// verzeichnis, in dem die exe liegt
		myDir = "";
		// verzeichnis setzen
		fscommand("ORG", path + ".dir");
		
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
	
	public function set dir(str:String ):Void
	{
		// verzeichnis, in dem die exe liegt
		myDir = str;
	}
	
	public function get dir():String
	{
		// verzeichnis, in dem die exe liegt
		return (myDir);
	}
	
	public function get resultvar():String
	{
		// vollstaendiger pfad zu der variable, die das result aufnimmt
		return (path + ".result");
	}
	
	private function onResult(prop:String, oldval:String, res:String):String
	{
		// debuggen
		_root.debug_mc.zeigePopup(action + ": " + res);
		// je nach action
		switch (action) {
			// getestet, ob datei existiert
			case "FileSys2.FileExists" :
				// ergebnis zurueck geben
				caller[callback](res == "TRUE" ? true : false);
				
				break;
			// datei wurde gelesen
			case "FileSys2.ReadFile" :
				// dateiinhalt zurueck geben
				caller[callback](res);
				
				break;
			// datei wurde geschrieben
			case "FileSys2.WriteToFile" :
				// ergebnis zurueck geben
				caller[callback](res);
				
				break;
		}
		// neuen wert uebernehmen
		return (res);
	}
	
	public  function getFileExists(file:String ):Void
	{
		// wenn file ohne vollen pfad, directory voran stellen, in dem die exe liegt
		if (file.indexOf(":") == -1) file = dir + "\\" + file;
		// testen, ob datei existiert
		action = "FileSys2.FileExists";
		fscommand("Arg", resultvar);
		fscommand("Arg", file);
		fscommand(action, "");
		fscommand("Clr", "");
	}
	
	public  function getReadFile(file:String ):Void
	{
		// wenn file ohne vollen pfad, directory voran stellen, in dem die exe liegt
		if (file.indexOf(":") == -1) file = dir + "\\" + file;
		// datei lesen
		action = "FileSys2.ReadFile";
		fscommand("Arg", resultvar);
		fscommand("Arg", file);
		fscommand(action, "");
		fscommand("Clr", "");
	}
	
	public  function setWriteToFile(file:String, data:String ):Void
	{
		// wenn file ohne vollen pfad, directory voran stellen, in dem die exe liegt
		if (file.indexOf(":") == -1) file = dir + "\\" + file;
		// datei schreiben
		action = "FileSys2.WriteToFile";
		fscommand("Arg", resultvar);
		fscommand("Arg", file);
		fscommand("Arg", data);
		fscommand(action, "");
		fscommand("Clr", "");
	}

} /* end class FileSys2Connector */
