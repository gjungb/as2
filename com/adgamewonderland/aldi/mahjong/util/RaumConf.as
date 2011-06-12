/**
 * @author gerd
 */
class com.adgamewonderland.aldi.mahjong.util.RaumConf {
	
	private var ebenen:Number;
	
	private var zeilen:Number;
	
	private var spalten:Number;
	
	private var steine:Number;
	
	private var belegung:Array;
	
	public function RaumConf() {
		this.ebenen = 0;
		this.zeilen = 0;
		this.spalten = 0;
		this.steine = 0;
		this.belegung = new Array();
	}
	
	public function parseBelegung(belegungxml:Array ):Void
	{
		// schleife ueber ebenen
		for (var i:Number = 0; i < belegungxml.length; i++) {
			// aktuelle ebene
			var ebenexml:XMLNode = belegungxml[i];
			// neue belegung
			var temp:Array = new Array();
			// zeilen
			var zeilenxml:Array = ebenexml.childNodes;
			// schleife ueber zeilen
			for (var j:Number = 0; j < zeilenxml.length; j++) {
				// aktuelle zeile
				var zeilexml:XMLNode = zeilenxml[j];
				// inhalt der zeile in belegung speichern
				temp.push(zeilexml.firstChild.nodeValue);
			}
			// belegung speichern
			this.belegung[i] = temp;
		}
	}
	
	public function getSteine():Number {
		return steine;
	}

	public function setSteine(steine:Number):Void {
		this.steine = steine;
	}

	public function getZeilen():Number {
		return zeilen;
	}

	public function setZeilen(zeilen:Number):Void {
		this.zeilen = zeilen;
	}

	public function getSpalten():Number {
		return spalten;
	}

	public function setSpalten(spalten:Number):Void {
		this.spalten = spalten;
	}

	public function getEbenen():Number {
		return ebenen;
	}

	public function setEbenen(ebenen:Number):Void {
		this.ebenen = ebenen;
	}

	public function getBelegung():Array {
		return belegung;
	}

	public function setBelegung(belegung:Array):Void {
		this.belegung = belegung;
	}

}