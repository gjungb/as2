/**
 * @author gerd
 */
 
import mx.remoting.RecordSet;
import mx.remoting.debug.NetDebug;

import com.adgamewonderland.agw.net.*;

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

class com.adgamewonderland.sskddorf.mischpult.data.DataCalculator {
	
	private static var _instance:DataCalculator;
	
	private static var PAUSCHALE_LEBENSHALTUNG:Number = 470;
	
	/**
	 * @return singleton instance of DataCalculator
	 */
	public static function getInstance():DataCalculator {
		if (_instance == null)
			_instance = new DataCalculator();
		return _instance;
	}
	
	private function DataCalculator() {
		
	}
	
	public function getFamilienstand(anzahlpersonen:Number ):Familienstand
	{
		// familienstand abhaengig von anzahl personen in haushalt
		return (DataProvider.getInstance().getFamilienstandByID(anzahlpersonen == 1 ? 1 : 2));
	}
	
	public function getLebensphase(alter:Number ):Lebensphase
	{
		// lebensphasen aus datenbank
		var lebensphasen:RecordSet = DataProvider.getInstance().getLebensphasen();
		// nur unterhalb uebergebenem alter
		var filtered:RecordSet = RemotingRecordSetFilter.filterRecordSet(lebensphasen, RemotingRecordSetFilter.MODE_LESS, {altermin : alter + 1});
		// nur hoechstes alter
		filtered.sortItemsBy(["altermin"], null, Array.DESCENDING | Array.NUMERIC);
		// zurueck geben
		return (DataProvider.getInstance().getLebensphaseByID(filtered.getItemAt(0).ID));
	}
	
	public function getWohnsituation(id:Number ):Wohnsituation
	{
		// wohnsituation per checkbox ausgewaehlt
		return (DataProvider.getInstance().getWohnsituationByID(id + 1));
	}
	
	public function getLebenshaltungskosten(personen:Number ):Number
	{
		// pauschale lebenshaltungskosten abhaengig von anzahl personen im haushalt
		var lebenshaltungskosten:Number = PAUSCHALE_LEBENSHALTUNG * (personen + 1) / 2;
		// zurueck geben
		return lebenshaltungskosten;
	}
	
	public function getVerfuegung(userinput:UserInput ):Number
	{
		// zur verfuegung stehendes einkommen
		var verfuegung:Number = 0;
		
		// nettoeinkommen
		var einkommen:Number = userinput.getEinkommen();
//		// pauschale lebenshaltungskosten abhaengig von anzahl personen im haushalt
//		var lebenshaltungskosten:Number = getLebenshaltungskosten(userinput.getPersonen());
		// kosten
		var kosten:Number = userinput.getWohnkosten() + userinput.getSonstigekosten(); // + lebenshaltungskosten;
		
		// differenz
		verfuegung = einkommen - kosten;
		
		// zurueck geben
		return verfuegung;
	}
	
	public function getPlanungssumme(summe:Number ):Planungssumme
	{
		// planungssummen aus datenbank
		var planungssummen:RecordSet = DataProvider.getInstance().getPlanungssummen();
		// nur unterhalb uebergebener summe
		var filtered:RecordSet = RemotingRecordSetFilter.filterRecordSet(planungssummen, RemotingRecordSetFilter.MODE_LESS, {summemin : summe + 1});
		// nur hoechste summe
		filtered.sortItemsBy(["summemin"], null, Array.DESCENDING | Array.NUMERIC);
		// zurueck geben
		return (DataProvider.getInstance().getPlanungssummeByID(filtered.getItemAt(0).ID));
	}
	
	public function getGewichtung(userinput:UserInput, produktkategorie:Produktkategorie ):Gewichtung
	{
		// gewichtungen aus datenbank
		var gewichtungen:RecordSet = DataProvider.getInstance().getGewichtungen();
		// filtern
		var filtered:RecordSet = RemotingRecordSetFilter.filterRecordSet(gewichtungen, RemotingRecordSetFilter.MODE_AND, {LebensphaseID : userinput.getLebensphase().getID(), FamilienstandID : userinput.getFamilienstand().getID(), ProduktkategorieID : produktkategorie.getID(), PlanungssummeID : userinput.getPlanungssumme().getID()});
		// zurueck geben
		return (DataProvider.getInstance().getGewichtungByID(filtered.getItemAt(0).ID));
	}
	
	public function getProduktemfehlungen(userinput:UserInput, produktkategorie:Produktkategorie, summe:Number ):Array
	{
		// produkte als beans
		var produkte:Array = new Array();
		// produktempfehlungen aus datenbank
		var produktempfehlungen:RecordSet = DataProvider.getInstance().getProduktempfehlungen();
		// filtern
		var filtered1:RecordSet = RemotingRecordSetFilter.filterRecordSet(produktempfehlungen, RemotingRecordSetFilter.MODE_AND, {FamilienstandID : userinput.getFamilienstand().getID(), ProduktkategorieID : produktkategorie.getID(), LebensphaseID : userinput.getLebensphase().getID(), WohnsituationID : userinput.getWohnsituation().getID()});
//		trace(userinput.getFamilienstand().getID() + " # " + produktkategorie.getID() + " # " + userinput.getLebensphase().getID() + " # " + userinput.getWohnsituation().getID());
		// nur unterhalb uebergebener summe
		var filtered2:RecordSet = RemotingRecordSetFilter.filterRecordSet(filtered1, RemotingRecordSetFilter.MODE_LESS, {minimalsumme : summe});
		// nur hoechste minimalsumme
		filtered2.sortItemsBy(["minimalsumme"], null, Array.DESCENDING | Array.NUMERIC);
		// produktids
		var produktids:Array = filtered2.getItemAt(0).produkte.split(",");
		// entsprechende produkte
		for (var i:Number = 0; i < produktids.length; i++) {
			// ueberspringen, wenn beim user bereits vorhanden
			if (DataProvider.getInstance().getExistentByID(produktids[i])) continue;
			// speichern
			produkte.push(DataProvider.getInstance().getProduktByID(produktids[i]));
		}
		// zurueck geben 
		return produkte;
	}
}