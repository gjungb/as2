/**
 * @author gerd
 */

import com.adgamewonderland.aldi.mahjong.raster.Ebene;
import com.adgamewonderland.aldi.mahjong.raster.Stein;
import com.adgamewonderland.aldi.mahjong.util.RaumConf;

class com.adgamewonderland.aldi.mahjong.raster.Raum {
	
	private var ebenen:Array;
	
	private var steine:Array;
	
	private var merged:Ebene;
	
	public function Raum() {
		this.ebenen = new Array();
		this.steine = new Array();
		this.merged = new Ebene(0, 0, 0);
	}
	
	public function init():Void
	{
		this.ebenen = new Array();
		this.steine = new Array();
		this.merged = new Ebene(0, 0, 0);
	}
	
	public function createRaum(conf:RaumConf ):Void
	{
		// array mit steinen
		this.steine		= new Array();
		// steine leer initialisieren
		for (var j:Number = 0; j < conf.getSteine(); j++) {
			// neuer stein
			this.steine[j] = new Stein();
			// ident entsprechend position im array + 1
			this.steine[j].setIdent(j + 1);
		}
		
		// array mit ebenen
		this.ebenen		= new Array();
		// ebenen erstellen und konfigurieren
		for (var i:Number = 0; i < conf.getEbenen(); i++) {
			// neue ebene
			var ebene:Ebene = new Ebene(conf.getZeilen(), conf.getSpalten(), i);
			// belegung
			ebene.setBelegung(conf.getBelegung()[i]);
			// steine
			ebene.setSteine(this.steine);
			// speichern
			this.ebenen[i] = ebene;
		}
		
		// merged ebene
		this.merged		= new Ebene(conf.getZeilen(), conf.getSpalten(), null);
		
		// mergen der Ebenen
		createMerge();
	}

	public function createRaumStandard():Void
	{
		this.ebenen		= new Array(5);
		this.ebenen[0] 	= new Ebene(18,32,0);
		this.ebenen[1] 	= new Ebene(18,32,1);
		this.ebenen[2] 	= new Ebene(18,32,2);
		this.ebenen[3] 	= new Ebene(18,32,3);
		this.ebenen[4] 	= new Ebene(18,32,4);
		this.steine		= new Array(144);
		this.merged		= new Ebene(18,32,0);
		
		for (var i:Number = 0; i < this.steine.length; i++) {
			this.steine[i] = new Stein();
			this.steine[i].setIdent(i + 1);
		}

		var config1:Array = [
			"00000000000000000000000000000000",
			"00011111111111111111111111100000",
			"00011111111111111111111111100000",
			"00000001111111111111111000000000",
			"00000001111111111111111000000000",
			"00000111111111111111111110000000",
			"00000111111111111111111110000000",
			"00011111111111111111111111100000",
			"01111111111111111111111111111110",
			"01111111111111111111111111111110",
			"00011111111111111111111111100000",
			"00000111111111111111111110000000",
			"00000111111111111111111110000000",
			"00000001111111111111111000000000",
			"00000001111111111111111000000000",
			"00011111111111111111111111100000",
			"00011111111111111111111111100000",
			"00000000000000000000000000000000"
		];

		var config2:Array = [
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000011111111111100000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"
		];

		var config3:Array = [
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000111111110000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"
		];
	
		var config4:Array = [
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000001111000000000000000",
			"00000000000001111000000000000000",
			"00000000000001111000000000000000",
			"00000000000001111000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"
		];
	
		var config5:Array = [
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000110000000000000000",
			"00000000000000110000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"
		];
		// Erstelle alles was nötig ist
		ebenen[0].setBelegung(config1);
		ebenen[0].setSteine(steine);
		ebenen[1].setBelegung(config2);
		ebenen[1].setSteine(steine);
		ebenen[2].setBelegung(config3);
		ebenen[2].setSteine(steine);
		ebenen[3].setBelegung(config4);
		ebenen[3].setSteine(steine);
		ebenen[4].setBelegung(config5);
		ebenen[4].setSteine(steine);
		
		// mergen der Ebenen
		createMerge();
	}
	
	public function getSteine():Array
	{
		return steine;
	}
	
	public function getAlleFreienSteine():Array
	{	
		var ret:Array = new Array();
		for (var i:Number = 0; i < this.steine.length; i++) {
			var stein:Stein = this.steine[i];
			if (!stein.getGesetzt()) continue;
			if (istSteinFrei(stein.getIdent())) {
				ret.push(stein);
			}
		}
		
		return ret;
	}
	
	public function getGesetzeSteine():Array
	{
		var ret:Array = new Array();
		for (var i:Number = 0; i < this.steine.length; i++) {
			var stein:Stein = this.steine[i];
			if (stein.getGesetzt()) {
				ret.push(stein);
			}
		}
		
		return ret;
	}
	
	public function getSteinCount():Number
	{
		var iRet:Number = 0;
		
//		// Alle Ebenen durchgehen
//		for (var i:Number = 0; i < this.ebenen.length; i++) {
//			iRet += ebenen[i].getSteinCount();
//		}
		for (var i:Number = 0; i < this.steine.length; i++) {
			var stein:Stein = this.steine[i];
			if(stein.getGesetzt()) iRet++;
		}
			
		return iRet;
	}
	
	public function istSteinFrei(index:Number ):Boolean
	{
		var bRet:Boolean = false;
		
		var stein:Stein = this.steine[index - 1];
		if (stein.getGesetzt()) {
			if (this.merged.istSteinFrei(stein.getZeile(), stein.getSpalte(), stein.getIdent())) { // istSteinValid
				bRet = stein.getEbene().sindZellenFrei(stein.getZeile(), stein.getSpalte());
			}
		}
		
		return bRet;
	}
	
	public function removeSteine(steine:Array ):Void
	{
		for (var i:String in steine) {
			var stein:Stein = steine[i];
			stein.removeStein();
		}
		// mergen der Ebenen
		createMerge();
	}
	
	public function getAnzahlSpielzuege():Number
	{
		var iRet:Number = 0;
		
		// Aus den spielbaren Steinen die Anzahl der Pärchen bilden
		var temp:Array = getAlleFreienSteine();
		
		for (var i:Number = 0; i < temp.length; i++) {
			var stein1:Stein = temp[i];
			if (stein1 != null) {
				for (var j:Number = 0; j < temp.length; j++) {
					var stein2:Stein = temp[j];
					if (stein2 != null && stein2 != stein1) {
						if (stein1.checkPaar(stein2)) {
							iRet++;
							stein1 = null;
							stein2 = null;
							break;
						}
					}
				}
			}
		}
		
		return iRet;
	}
	
	public function getSpielzug():Array
	{
		// freie steine
		var temp:Array = getAlleFreienSteine();
		// zufaellig mischen
		var rand:Function = function(e1, e2) {
			return (Math.random() < 0.5 ? -1 : 1);
		};
		temp.sort(rand);
		
		// 2 Steine ermitteln die Spielbar sind
		var ret:Array = new Array();
		// schleife ueber alle freien steine
		for (var i:Number = 0; i < temp.length; i++) {
			// erster stein
			var stein1:Stein = temp[i];
			// schleife ueber alle nachfolgenden freien steine
			for (var j:Number = i + 1; j < temp.length; j++) {
				// zweiter stein
				var stein2:Stein = temp[j];
				// testen, ob paar
				if (stein1.checkPaar(stein2)) {
					// speichern
					ret.push(stein1);
					ret.push(stein2);
					// zurueck geben
					return ret;
				}
			}
		}
		return ret;
	}
	
	private function createMerge():Void
	{
		// mergen der Ebenen
		this.merged.prepareMergeEbene();
		
		// Alle Ebenen durchgehen
		for (var i:Number = 0; i < this.ebenen.length; i++) {
			this.merged.mergeEbene(ebenen[i]);
		}
	}
	
	private function updateFreieSteine():Void
	{
		for (var i:Number = 0; i < this.steine.length; i++) {
			var stein:Stein = this.steine[i];
			
		}
		
	}

}