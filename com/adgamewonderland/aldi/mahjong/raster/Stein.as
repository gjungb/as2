/**
 * @author gerd
 */

import com.adgamewonderland.aldi.mahjong.raster.Ebene;
import com.adgamewonderland.aldi.mahjong.raster.SteinGrafikPara;
import com.adgamewonderland.aldi.mahjong.raster.Zelle;
import com.adgamewonderland.aldi.mahjong.ui.StoneUI;
 
class com.adgamewonderland.aldi.mahjong.raster.Stein {

	private var zellen:Array;			// werden direkt in die Zellen einer Ebene referenzieren
	
	private var motifid:Number;		// ID um herauszufinden welcher Stein zu welchem passt
	
	private var ident:Number;			// eine Nummer eindeutig die in den Zellen eingetragen wird
	
	private var gesetzt:Boolean;		// 0 nicht gesetzt 1 gesetzt
	
	private var frei:Boolean;			// darf der stein gespielt werden
	
	private var zeile:Number;			// Zeile linke Ecke
	
	private var spalte:Number;			// Spalte linke Ecke
	
	private var ebene:Ebene;			// auf welcher Ebene liege ich
	
	private var stoneui:StoneUI;
	
	public function Stein() {
		zellen 	= [];
		motifid = -1;
		ident 	= 0;
		gesetzt = false;
		frei	= false;
		zeile 	= -1;
		spalte 	= -1;
		ebene 	= null;
		stoneui	= null;
	}
	
	public function getGrafikPara():SteinGrafikPara
	{
		return new SteinGrafikPara(getZeile(),getSpalte(),getEbene().getSchicht());
	}

	public function checkPaar(other:Stein ):Boolean
	{
		return (getMotifid() == other.getMotifid());
	}
	
	public function removeStein():Void
	{
		// nicht mehr gesetzt
		setGesetzt(false);
		// zellen resetten
		resetZellen();
		// stein von buehne loeschen
		stoneui.removeMovieClip();
		// kein stein mehr auf buehne
		setStoneui(null);
	}
	
	public function resetZellen():Void
	{
		for (var j:String in this.zellen) {
			var zelle:Zelle = this.zellen[j];
			zelle.setOwner(0);
			zelle.setBelegung(false);
		}
	}
	
	public function getZeile():Number {
		return zeile;
	}

	public function setZeile(zeile:Number):Void {
		this.zeile = zeile;
	}

	public function getGesetzt():Boolean {
		return gesetzt;
	}

	public function setGesetzt(gesetzt:Boolean):Void {
		this.gesetzt = gesetzt;
	}

	public function getZellen():Array {
		return zellen;
	}

	public function setZellen(zellen:Array):Void {
		this.zellen = zellen;
	}

	public function getIdent():Number {
		return ident;
	}

	public function setIdent(ident:Number):Void {
		this.ident = ident;
	}

	public function getEbene():Ebene {
		return ebene;
	}

	public function setEbene(ebene:Ebene):Void {
		this.ebene = ebene;
	}

	public function getSpalte():Number {
		return spalte;
	}

	public function setSpalte(spalte:Number):Void {
		this.spalte = spalte;
	}

	public function getMotifid():Number {
		return motifid;
	}

	public function setMotifid(motifid:Number):Void {
		this.motifid = motifid;
	}

	public function getStoneui():StoneUI {
		return stoneui;
	}

	public function setStoneui(stoneui:StoneUI):Void {
		this.stoneui = stoneui;
	}

	public function getFrei():Boolean {
		return frei;
	}

	public function setFrei(frei:Boolean):Void {
		this.frei = frei;
	}

}