/**
 * @author gerd
 */
 
import com.adgamewonderland.aldi.mahjong.raster.Stein;
import com.adgamewonderland.aldi.mahjong.raster.Zelle;

class com.adgamewonderland.aldi.mahjong.raster.Ebene {
	
	private var zeilen:Number;
	
	private var spalten:Number;
	
	private var schicht:Number;
	
	private var zellen:Array;
	
	public function Ebene(zeilen:Number, spalten:Number, schicht:Number ) {
		this.zeilen 	= zeilen;
		this.spalten 	= spalten;
		this.schicht	= schicht;
		this.zellen		= new Array(zeilen);
		
		// initialisieren
		init();
	}
	
	public function init():Void
	{
		for (var i:Number = 0; i < getZeilen(); i++) {
			this.zellen[i] = new Array(getSpalten());
			for (var j:Number = 0; j < getSpalten(); j++) {
				this.zellen[i][j] = new Zelle();
			}
		}
	}
	
	public function setBelegung(config:Array ):Void
	{
		if (config.length < getZeilen()) {
			return;
		}

		for (var i:Number = 0; i < getZeilen(); i++) {
			for (var j:Number = 0; j < getSpalten(); j++) {
				var zelle:Zelle = this.zellen[i][j];
				zelle.setBelegung(config[i].charAt(j) == "1");
			}
		}
	}
	
	public function setSteine(steine:Array ):Void
	{
		var stein:Stein;
		// Suche den ersten nicht belegten Stein
		for (var lastBelegt:Number = 0; lastBelegt < steine.length; lastBelegt++) {
			stein = steine[lastBelegt];
			if (!stein.getGesetzt()) {
				break;
			}
		}
		
		for (var j:Number = 0; j < getSpalten(); j++) {
			for (var i:Number = 0; i < getZeilen(); i++) {
				var zelle:Zelle = this.zellen[i][j];
				if (zelle.getBelegung() && zelle.getOwner() == 0) {
					// Finde einen freien Stein und trage diesen als Owner ein
					// Manipuliere alle Zellen im 4x4 Raster und verdrate die
					// Zellen mit dem Stein
					if (lastBelegt < steine.length) {
						stein = steine[lastBelegt];
						stein.setGesetzt(true);
						
						this.zellen[i + 0][j + 0].setOwner(stein.getIdent());
						this.zellen[i + 0][j + 1].setOwner(stein.getIdent());
						this.zellen[i + 1][j + 0].setOwner(stein.getIdent());
						this.zellen[i + 1][j + 1].setOwner(stein.getIdent());
						
						// Die eben manipulierten Zellen jetzt dem Stein geben
						stein.getZellen()[0] = this.zellen[i + 0][j + 0];
						stein.getZellen()[1] = this.zellen[i + 0][j + 1];
						stein.getZellen()[2] = this.zellen[i + 1][j + 0];
						stein.getZellen()[3] = this.zellen[i + 1][j + 1];
						
						// Halte die Ebene fest und die linke obere Ecke ()
						stein.setEbene(this);
						stein.setSpalte(j);
						stein.setZeile(i);
						stein.setMotifid(0);
						
						lastBelegt++;
					}
				}
			}
		}
	}
	
	public function prepareMergeEbene():Void
	{
		// Alle Zellen zurücksetzen
		for (var j:Number = 0; j < getSpalten(); j++) {
			for (var i:Number = 0; i < getZeilen(); i++) {
				var zelle:Zelle = this.zellen[i][j];
				zelle.setOwner(0);
			}
		}
	}
	
	public function mergeEbene(source:Ebene ):Void
	{
		// Es werden nur die Zellen manipuliert (mit Belegungsnummer)
		for (var j:Number = 0; j < getSpalten(); j++) {
			for (var i:Number = 0; i < getZeilen(); i++) {
				if (source.getZellen()[i][j].getOwner() > 0) {
					this.zellen[i][j].setOwner(source.getZellen()[i][j].getOwner());
				}
			}
		}
	}
	
	public function getSteinCount():Number
	{
		// wieviele Steine liegen in der Ebene noch rum
		var iRet:Number = 0;
		
		for (var j:Number = 0; j < getSpalten(); j++) {
			for (var i:Number = 0; i < getZeilen(); i++) {
				if (this.zellen[i][j].getOwner() != 0)	iRet++;
			}
		}
		// Es gehören immer 4 Zellen zu einem Stein
		return (iRet > 0 ? iRet / 4 : 0);
	}
	
	public function sindZellenFrei(zeile:Number, spalte:Number ):Boolean
	{	
		var bRet:Boolean = false;

		if (spalte > 0 && spalte < this.spalten - 2) {
			// teste links
			if (this.zellen[zeile][spalte - 1].getBelegung() == false && this.zellen[zeile + 1][spalte - 1].getBelegung() == false)
				return true;
			
			// teste rechts
			if (this.zellen[zeile][spalte + 2].getBelegung() == false && this.zellen[zeile + 1][spalte + 2].getBelegung() == false)
				return true;
		}
		
		return bRet;
	}
	
	public function istSteinFrei(zeile:Number, spalte:Number, owner:Number ):Boolean
	{	
		var bRet:Boolean = true;

		if (spalte > 0 && spalte < this.spalten - 2) {
			// teste erste zeile
			if (this.zellen[zeile][spalte].getOwner() != owner || this.zellen[zeile][spalte + 1].getOwner() != owner)
				return false;
			// teste zweite zeile
			if (this.zellen[zeile + 1][spalte].getOwner() != owner || this.zellen[zeile + 1][spalte + 1].getOwner() != owner)
				return false;
		}
		
		return bRet;
	}
	
	public function istSteinValid(owner:Number ):Boolean
	{
		var bRet:Boolean = false;
		
		for (var j:Number = 0; j < getSpalten(); j++) {
			for (var i:Number = 0; i < getZeilen(); i++) {
				if (this.zellen[i][j].getOwner() == owner) {
					if (this.zellen[i][j + 1].getOwner() == owner) {
						if (this.zellen[i + 1][j].getOwner() == owner) {
							if (this.zellen[i + 1][j + 1].getOwner() == owner) {
								return true;
							}
							else
								return false;
						}
						else
							return false;
					}
					else
						return false;
				}
			}
		}
		return bRet;
	}
	
	public function getSchicht():Number {
		return schicht;
	}

	public function setSchicht(schicht:Number):Void {
		this.schicht = schicht;
	}

	public function getSpalten():Number {
		return spalten;
	}

	public function setSpalten(spalten:Number):Void {
		this.spalten = spalten;
	}

	public function getZeilen():Number {
		return zeilen;
	}

	public function setZeilen(zeilen:Number):Void {
		this.zeilen = zeilen;
	}

	public function getZellen():Array {
		return zellen;
	}

	public function setZellen(zellen:Array):Void {
		this.zellen = zellen;
	}

}