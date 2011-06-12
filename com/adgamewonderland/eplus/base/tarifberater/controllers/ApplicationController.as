import com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand;import com.adgamewonderland.eplus.base.tarifberater.services.ClientFactory;

import mx.transitions.easing.Regular;

import com.adgamewonderland.agw.util.DefaultController;
import com.adgamewonderland.eplus.base.tarifberater.automat.OnlineZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.SMSZustand;
import com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat;
import com.adgamewonderland.eplus.base.tarifberater.beans.Konfiguration;
import com.adgamewonderland.eplus.base.tarifberater.beans.Tarifberater;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController extends DefaultController implements ITarifberaterAutomatLsnr {
	
	public static var MARKE_BASE : Number = 1;
	
	public static var MARKE_BASE_PRO : Number = 2;
	
	public static var MARKE_EPLUS : Number = 3;
	
	public static var MARKE_EPLUS_PRO : Number = 4;

	public static var TWEENDURATION : Number = 0.5;
	
	public static var TWEENFUNCTION : Function = Regular.easeOut;
	
	private static var _instance : ApplicationController;
	
	private static var MARKE : Number = MARKE_BASE;

	private var ui:MovieClip;
	
	private var sessionid : String;
	
	private var berater : Tarifberater;
	
	private var automat : TarifberaterAutomat;

	public static function getInstance() : ApplicationController {
		if (_instance == null)
			_instance = new ApplicationController();
		return _instance;
	}
	
	public static function setMarke(aMarke : Number ) : Void {
		MARKE = aMarke;	
	}
	
	public static function getMarke() : Number {
		return MARKE;
	}

	/**
	 * startet die applikation
	 * @param aUI movieclip, das die einzelnen states anzeigt
	 * @param aSessionid aktuelle session
	 */
	public function startApplication(aUI:MovieClip, aSessionid:String, aKonfiguration : Konfiguration ) : Void {
		// movieclip, das die einzelnen states anzeigt
		this.ui = aUI;		// aktuelle session
		this.sessionid = aSessionid;		// konfiguration		if (aKonfiguration != null)			this.berater.setKonfiguration(aKonfiguration);
		else
			this.berater.setKonfiguration(new Konfiguration(this.automat.getTelefonieZustand(), this.automat.getFertigZustand(), ClientFactory.JSONCLIENT));
	}

	/**
	 * Start des Beraters durch den User
	 */
	public function neuAction() : Void {		this.berater.neuStarten(this.automat.getZustand());
		// an automaten delegieren
		this.automat.neuStarten();
	}

	/**
	 * Auswahl eines Produkts durch den User
	 * @param aProdukt vom User gewähltes Produkt
	 */
	public function waehlenAction(aProdukt : IProdukt ) : Void {
		// an automaten delegieren
		this.automat.produktWaehlen(aProdukt);
		// webtrends
		trackeWtod(aProdukt .getStep());
	}
	
	/**
	 * Navigation zum vorhergehenden Zustand
	 */
	public function zurueckAction() : Void {		this.berater.zurueckGehen(this.automat.getZustand());
		// an automaten delegieren
		this.automat.zurueckGehen();
	}
	
	/**
	 * Navigation zum naechsten Zustand
	 */
	public function  vorwaertsAction() : Void {
		// an automaten delegieren
		this.automat.vorwaertsGehen();
	}

	/**
	 * Empfohlene Produkte an Warenkorb uebergeben
	 */
	public function warenkorbAction() : Void {
		// an automaten delegieren
		this.automat.warenkorbBestellen(this.sessionid);
	}

	/**
	 * Empfohlene Produkte speichern und Handy auswählen
	 */
	public function handyAction() : Void {
		// an automaten delegieren
		this.automat.handyAuswaehlen(this.sessionid);
	}
	
	/**
	 * Nach Absenden der Ergebnisse redirecten
	 */
	public function redirectAction(aUrl : String ) : Void {
		// zur zielseite
		getURL(aUrl, "_self");
	}

	/**
	 * Informationen zu einem Produkt anzeigen
	 * @param aProdukt
	 */
	public function zeigeProduktinfos(aProdukt : IProdukt ) : Void {
		// listener informieren
		_event.send("onZeigeProduktinfos", aProdukt);
	}
	
	/**
	 * Grösse von mcs ändern
	 * @param aSizable
	 */
	public function aendereGroesse(aSizable : ISizable ) : Void {
		// listener informieren
		_event.send("onAendereGroesse", aSizable);
	}

	/**
	 * Warenkorb ein- / ausblenden
	 * @param aSichtbar
	 */
	public function zeigeWarenkorb(aSichtbar : Boolean ) : Void {
		// listener informieren
		_event.send("onZeigeWarenkorb", this.berater.getWarenkorb(), aSichtbar, this.automat.getZustand());
	}

	/**
	 * Callback nach Zustandsänderungen
	 */
	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb ) : Void {
		// am ende warenkorb anzeigen
		if (aZustand.isEndeZustand())
			zeigeWarenkorb(true);
	}
	
	public function getTarifberater() : Tarifberater {
		return this.berater;
	}
	
	public function getAutomat() : TarifberaterAutomat {
		return this.automat;
	}

	private function ApplicationController() {
		// berater
		this.berater = new Tarifberater();
		// automat
		this.automat = new TarifberaterAutomat(this.berater);
		// als listener rgistrieren
		this.automat.addListener(this);
	}
	
	/**
	 * ruft WToD per JavaScript auf
	 */
	 private function trackeWtod(aStep : String ) : Void {
		// js url
		var url : String = "javascript:dcsMultiTrack('DCS.dcsuri', '/tarifberater/step.jsf', 'WT.ti', 'Tarifberater Step', 'DCSext.tb_step', '" + aStep + "', 'DCS.dcsqry', '', 'WT.ac', '', 'WT.ad', '');";
		// aufrufen		_root.zeigeDebug(url);
		if (_url.indexOf("http") > -1)
			getURL(url, "");	 }
}
