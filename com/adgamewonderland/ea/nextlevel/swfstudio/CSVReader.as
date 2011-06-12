/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.swfstudio.CSVReader {

	private var Dateiname : String;
	private var FieldTrenner : String;
	private var LinesTrenner : String;

	// Enthält die Feldnamen (erste Zeile der Datei)
	private var Fieldnames : Array = null;

	// Enthält die Zeilen (unformatiert)
	private var Lines : Array = null;

	/**
	 * Konstruktor
	 */
	public function CSVReader() {
		FieldTrenner = ";";
		LinesTrenner = String.fromCharCode(13) + String.fromCharCode(10);
	}

	/**
	 *
	 */
	public function setDateiname(value:String):Void	{
		this.Dateiname = value;
	}

	/**
	 *
	 */
	public function getDateiname():String {
		return this.Dateiname;
	}

	/**
	 *
	 */
	public function setFieldTrenner(value:String):Void	{
		this.FieldTrenner = value;
	}

	/**
	 *
	 */
	public function getFieldTrenner():String {
		return this.FieldTrenner;
	}

	/**
	 *
	 */
	public function setLinesTrenner(value:String):Void	{
		this.LinesTrenner = value;
	}

	/**
	 *
	 */
	public function getLinesTrenner():String {
		return this.LinesTrenner;
	}

	/**
	 * Lesen der Datei
	 * wenn ok dann true
	 */
	public function readFile () : Boolean {
		/**
		 * Ich gehe davon aus das ich die Datei in eine
		 * einzelne Zeichenkette einlese (SWF Studio)
		 * Danach wird die datei zerlegt und schon mal
		 * das Array mit den Feldnamen gebildet und ein
		 * Array mit den Lines im Speicher gehalten.
		 *
		 * Achtung : Ich verwende synchronized (siehe ssDefaults)
		 */
		var file_obj = ssCore.FileSys.readFile (
			{path:Dateiname}

			// "startdir://"}	//
			// "tempdir://"}	//
		);
		if (file_obj.success)
			return setContent(file_obj.result);
		return false;
	}

	/**
	 * Speichert den geladenenen Content in die datei
	 * zurück.
	 */
	public function writeFile (datName : String) : Boolean {
		var content:String = "";
		var i:Number;
		var iFieldCount:Number = Fieldnames.length;

		// Zuerst die Feldnamen
		for (i = 0;i < iFieldCount;i++) {
			content = content + Fieldnames[i];
			if (i < iFieldCount - 1)
				content = content + FieldTrenner;
		}
		content = content + LinesTrenner;

		// Jetzt jede Zeile
		var iMax:Number = getLinesCount();
		for (i = 1;i <= iMax;i++) {
			var line:Array = getLine(i);

			var ii:Number;
			var iiMax:Number = line.length;

			for (ii = 0;ii < iiMax;ii++) {
				content = content + line[ii];
				if (ii < iiMax - 1)
					content = content + FieldTrenner;
			}
			if (iiMax == iFieldCount && i < iMax)
				content = content + LinesTrenner;
		}
		ssCore.FileSys.writeToFile(
			{
				path:datName,
				data:content
			}
		);

		return true;
	}


	/**
	 * Das gleiche wie readFile, nur das der Inhalt
	 * der Datei von woanders kommt und als String übergeben
	 * wird.
	 */
	public function setContent (content : String) : Boolean {
		Lines = splitContentToLines (content);
		if (Lines != null) {
			if (Lines.length > 0) {
				// Die erste Zeile wird zerlegt und als FeldnamenArray gespeichert
				Fieldnames = splitContentToFields(Lines[0]);
				return true;
			}
		}
		return false;
	}

	/**
	 * Zerlege die Zeichenkette über den Linestrenner
	 * in einzelne Parts
	 *
	 */
	private function splitContentToLines (content : String) : Array {
		if (content.length == 0)
			return null;
		if (content.indexOf(LinesTrenner) < 0)
			return null;

		var ret:Array = content.split(LinesTrenner);

		if (ret.length > 0)
			return ret;
		return null;
	}

	/**
	 * Zerlege die Zeichenkette über den Fieldtrenner
	 * in einzelne Parts
	 *
	 */
	private function splitContentToFields (content : String) : Array {
		if (content.length == 0)
			return null;
		if (content.indexOf(FieldTrenner) < 0)
			return null;

		var ret:Array = content.split(FieldTrenner);

		if (ret.length > 0)
			return ret;
		return null;
	}

	/**
	 * Liefert das Array mit den Namen der Felder
	 * in der Datei.
	 */
	public function getFieldNames () : Array {
		return Fieldnames;
	}

	/**
	 * Liefert die Anzahl der Datensätze in der Datei
	 * ohne die Header
	 */
	public function getLinesCount() : Number {
		if (Lines != null)
			return Lines.length - 1;
		return 0;
	}

	/**
	 * Liefert ein Array zurück einer einzelnen
	 * Zeile der Datei
	 * In der Zeile 0 (des Lines Array) stehen die
	 * Namen der Felder !!!!!
	 *
	 * line kann sein 1 - n
	 */
	public function getLine (line:Number) : Array {
		if (Lines != null) {
			if (Lines.length > line) {
				var ret:Array = splitContentToFields (Lines[line]);
				if (ret != null) {
					if (ret.length > 0)
						return ret;
				}
			}
		}
		return null;
	}

	/**
	 * Diese Funktion erzeugt aus einer Zeile des
	 * Dokumentes einen XML Knoten mit dem Namen name
	 *
	 * Bei Erfolg XMLNode
	 * ansonsten null
	 *
	 */
	public function getXMLKnoten (line:Number,name:String) : XMLNode {
		var lineArray:Array = getLine(line);

		if (lineArray != null) {
			var node:XMLNode = new XMLNode(1,name);

			var i:Number;
			var iMax:Number = lineArray.length;

			for (i = 0;i < iMax;i++) {
				if (Fieldnames[i].length > 0) {
					// Itemnode
					var nodeChild:XMLNode 	= new XMLNode(1,Fieldnames[i]);
					// Textnode
					nodeChild.appendChild(new XMLNode(3,lineArray[i]));
					// ins root
					node.appendChild(nodeChild);
				}
			}

			return node;
		}

		return null;
	}

	/**
	 * Liefert alle Datensätze in einem einzigen Knoten zurück
	 * der den Namen rootName trägt
	 */
	public function getXMLAll (rootName:String,name:String) : XMLNode {
		var node:XMLNode = new XMLNode(1,rootName);

		var i:Number;
		var iMax:Number = getLinesCount();

		// baue alles zusammen
		for (i = 1;i <= iMax;i++) {
			var knoten:XMLNode = getXMLKnoten(i,name);
			node.appendChild(knoten);
		}

		return node;
	}

	/**
	 * Schreibt den kompletten Content in eine
	 * XML datei version 1.0
	 */
	public function writeAsXML (datName:String,rootName:String,name:String) : Void {
		var header:String = '<?xml version="1.0"?>' + String.fromCharCode(13) + String.fromCharCode(10);
		var root:XMLNode = getXMLAll (rootName,name);

		var content = header + root.toString();
		ssCore.FileSys.writeToFile(
			{
				path:datName,
				data:content
			}
		);
	}

}