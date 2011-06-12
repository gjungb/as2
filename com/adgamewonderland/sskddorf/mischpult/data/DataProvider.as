/**
 * @author gerd
 */

import mx.remoting.RecordSet;
import mx.utils.Iterator;

import com.adgamewonderland.agw.net.*;

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

class com.adgamewonderland.sskddorf.mischpult.data.DataProvider {
		
	private static var NAMES:Array = new Array("Familienstaende", "Lebensphasen", "Planungssummen", "Produktkategorien", "Wohnsituationen", "Gewichtungen", "Produkte", "Produktempfehlungen");
	
	private static var _instance:DataProvider;
	
	private var familienstaende:RecordSet;
	
	private var familienstaendebeans:Array;
	
	private var lebensphasen:RecordSet;
	
	private var lebensphasenbeans:Array;
	
	private var planungssummen:RecordSet;
	
	private var planungssummenbeans:Array;
	
	private var produktkategorien:RecordSet;
	
	private var produktkategorienbeans:Array;
	
	private var wohnsituationen:RecordSet;
	
	private var wohnsituationenbeans:Array;
	
	private var gewichtungen:RecordSet;
	
	private var gewichtungenbeans:Array;
	
	private var produkte:RecordSet;
	
	private var produktebeans:Array;
	
	private var produktempfehlungen:RecordSet;
	
	private var produktempfehlungenbeans:Array;
	
	private var userinput:UserInput;
	
	private var weighting:Weighting;
	
	private var existent:Array;
	
	private var contact:Contact;
	
	/**
	 * @return singleton instance of DataProvider
	 */
	public static function getInstance():DataProvider {
		if (_instance == null)
			_instance = new DataProvider();
		return _instance;
	}
	
	private function DataProvider() {
		this.familienstaende = new RecordSet();
		this.lebensphasen = new RecordSet();
		this.planungssummen = new RecordSet();
		this.produktkategorien = new RecordSet();
		this.wohnsituationen = new RecordSet();
		
		this.gewichtungen = new RecordSet();
		this.produkte = new RecordSet();
		this.produktempfehlungen = new RecordSet();
		
		this.familienstaendebeans = new Array();
		this.lebensphasenbeans = new Array();
		this.planungssummenbeans = new Array();
		this.produktkategorienbeans = new Array();
		this.wohnsituationenbeans = new Array();
		
		this.gewichtungenbeans = new Array();
		this.produktebeans = new Array();
		this.produktempfehlungenbeans = new Array();
		
		// eingaben des users
		this.userinput = new UserInput();
		// gewichtungen zur verteilung der planungssumme auf die produktkategorien
		this.weighting = new Weighting();
		// beim user bereits vorhandene produkte (zu jeder produktID true || false)
		this.existent = new Array();
		// kontaktdaten zum senden an den berater
		this.contact = new Contact();
	}
	
	public function getName(index:Number ):String
	{
		return (NAMES[index]);
	}
	
	public function getNumNames():Number
	{
		return NAMES.length;	
	}
	
	public function getLebensphasen():RecordSet {
		return lebensphasen;
	}

	public function setLebensphasen(lebensphasen:RecordSet):Void {
		this.lebensphasen = lebensphasen;
		initLebensphasenbeans(lebensphasen);
	}

	public function getProdukte():RecordSet {
		return produkte;
	}

	public function setProdukte(produkte:RecordSet):Void {
		this.produkte = produkte;
		initProduktebeans(produkte);
	}

	public function getFamilienstaende():RecordSet {
		return familienstaende;
	}

	public function setFamilienstaende(familienstaende:RecordSet):Void {
		this.familienstaende = familienstaende;
		initFamilienstaendebeans(familienstaende);
	}

	public function getProduktempfehlungen():RecordSet {
		return produktempfehlungen;
	}

	public function setProduktempfehlungen(produktempfehlungen:RecordSet):Void {
		this.produktempfehlungen = produktempfehlungen;
	}

	public function getPlanungssummen():RecordSet {
		return planungssummen;
	}

	public function setPlanungssummen(planungssummen:RecordSet):Void {
		this.planungssummen = planungssummen;
		initPlanungssummenbeans(planungssummen);
	}

	public function getProduktkategorien():RecordSet {
		return produktkategorien;
	}

	public function getNumProduktkategorien():Number {
		return produktkategorien.getLength();
	}

	public function setProduktkategorien(produktkategorien:RecordSet):Void {
		this.produktkategorien = produktkategorien;
		initProduktkategorienbeans(produktkategorien);
	}

	public function getWohnsituationen():RecordSet {
		return wohnsituationen;
	}

	public function setWohnsituationen(wohnsituationen:RecordSet):Void {
		this.wohnsituationen = wohnsituationen;
		initWohnsituationenbeans(wohnsituationen);
	}

	public function getGewichtungen():RecordSet {
		return gewichtungen;
	}

	public function setGewichtungen(gewichtungen:RecordSet):Void {
		this.gewichtungen = gewichtungen;
		initGewichtungenbeans(gewichtungen);
	}
	
	public function getFamilienstandByID(id:Number ):Familienstand {
		if (id < 0) id = 0;
		if (id >= this.familienstaendebeans.length) id = this.familienstaendebeans.length - 1;
		return (this.familienstaendebeans[id]);	
	}
	
	public function getLebensphaseByID(id:Number ):Lebensphase {
		if (id < 0) id = 0;
		if (id >= this.lebensphasenbeans.length) id = this.lebensphasenbeans.length - 1;
		return (this.lebensphasenbeans[id]);	
	}
	
	public function getPlanungssummeByID(id:Number ):Planungssumme {
		if (id < 0) id = 0;
		if (id >= this.planungssummenbeans.length) id = this.planungssummenbeans.length - 1;
		return (this.planungssummenbeans[id]);	
	}
	
	public function getProduktkategorieByID(id:Number ):Produktkategorie {
		if (id < 0) id = 0;
		if (id >= this.produktkategorienbeans.length) id = this.produktkategorienbeans.length - 1;
		return (this.produktkategorienbeans[id]);	
	}
	
	public function getWohnsituationByID(id:Number ):Wohnsituation {
		if (id < 0) id = 0;
		if (id >= this.wohnsituationenbeans.length) id = this.wohnsituationenbeans.length - 1;
		return (this.wohnsituationenbeans[id]);	
	}
	
	public function getGewichtungByID(id:Number ):Gewichtung {
		if (id < 0) id = 0;
		if (id >= this.gewichtungenbeans.length) id = this.gewichtungenbeans.length - 1;
		return (this.gewichtungenbeans[id]);	
	}
	
	public function getProduktByID(id:Number ):Produkt {
		if (id < 0) id = 0;
		if (id >= this.produktebeans.length) id = this.produktebeans.length - 1;
		return (this.produktebeans[id]);	
	}

	public function getUserinput():UserInput {
		return userinput;
	}

	public function setUserinput(userinput:UserInput):Void {
		this.userinput = userinput;
	}

	public function getWeighting():Weighting {
		return weighting;
	}

	public function setWeighting(weighting:Weighting):Void {
		this.weighting = weighting;
	}

	public function getProduktebeans():Array {
		return produktebeans;
	}

	public function getExistentByID(id:Number ):Boolean {
		if (id < 0 || id >= this.existent.length || this.existent[id] == undefined) return false;
		return this.existent[id];
	}

	public function setExistentByID(id:Number, existent:Boolean ):Void {
		this.existent[id] = existent;
	}

	public function getContact():Contact {
		return contact;
	}

	public function setContact(contact:Contact):Void {
		this.contact = contact;
	}
	
	private function initFamilienstaendebeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Familienstand = Familienstand(RemotingBeanCaster.getCastedInstance(new Familienstand(), item));
			// in array speichern
			this.familienstaendebeans[bean.getID()] = bean;
		}
	}
	
	private function initLebensphasenbeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Lebensphase = Lebensphase(RemotingBeanCaster.getCastedInstance(new Lebensphase(), item));
			// in array speichern
			this.lebensphasenbeans[bean.getID()] = bean;
		}
	}
	
	private function initPlanungssummenbeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Planungssumme = Planungssumme(RemotingBeanCaster.getCastedInstance(new Planungssumme(), item));
			// in array speichern
			this.planungssummenbeans[bean.getID()] = bean;
		}
	}
	
	private function initProduktkategorienbeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Produktkategorie = Produktkategorie(RemotingBeanCaster.getCastedInstance(new Produktkategorie(), item));
			// in array speichern
			this.produktkategorienbeans[bean.getID()] = bean;
		}
	}
	
	private function initWohnsituationenbeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Wohnsituation = Wohnsituation(RemotingBeanCaster.getCastedInstance(new Wohnsituation(), item));
			// in array speichern
			this.wohnsituationenbeans[bean.getID()] = bean;
		}
	}
	
	private function initGewichtungenbeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Gewichtung = Gewichtung(RemotingBeanCaster.getCastedInstance(new Gewichtung(), item));
			
			// lebensphase
			bean.setLebensphase(getLebensphaseByID(item["LebensphaseID"]));
			// familienstand
			bean.setFamilienstand(getFamilienstandByID(item["FamilienstandID"]));
			// produktkategorie
			bean.setProduktkategorie(getProduktkategorieByID(item["ProduktkategorieID"]));
			// planungssumme
			bean.setPlanungssumme(getPlanungssummeByID(item["PlanungssummeID"]));
			
			// in array speichern
			this.gewichtungenbeans[bean.getID()] = bean;
		}
	}
	
	private function initProduktebeans(rs:RecordSet ):Void {
		// iterator
		var i:Iterator = rs.getIterator();
		// schleife ueber items
		while (i.hasNext()) {
			// aktuelles item aus datenbank
			var item:Object = i.next();
			// item als bean
			var bean:Produkt = Produkt(RemotingBeanCaster.getCastedInstance(new Produkt(), item));
			
			// produktkategorie
			bean.setProduktkategorie(getProduktkategorieByID(item["ProduktkategorieID"]));
			
			// in array speichern
			this.produktebeans[bean.getID()] = bean;
			
		}
	}

}