/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

class com.adgamewonderland.sskddorf.mischpult.data.Weighting {
	
	private var summen:Array;
	
	public function Weighting() {
		// eingesetzte summen je produktkategorie
		this.summen = new Array();
	}
	
	public function setSummeByProduktkategorie(produktkategorie:Produktkategorie, summe:Number ):Void
	{
		// speichern
		this.summen[produktkategorie.getID()] = summe;
	}
	
	public function getSummeByProduktkategorie(produktkategorie:Produktkategorie ):Number
	{
		// zurueck geben
		return (this.summen[produktkategorie.getID()]);
	}
}