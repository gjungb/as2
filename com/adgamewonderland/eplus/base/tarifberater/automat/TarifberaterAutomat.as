import mx.utils.Collection;import mx.utils.CollectionImpl;import mx.utils.Iterator;import com.adgamewonderland.agw.util.DefaultController;import com.adgamewonderland.eplus.base.tarifberater.automat.AllnetZustand24;import com.adgamewonderland.eplus.base.tarifberater.automat.AllnetZustand31;import com.adgamewonderland.eplus.base.tarifberater.automat.AllnetZustand32;import com.adgamewonderland.eplus.base.tarifberater.automat.FehlerZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.HandyInternetFlatrateZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.InternetFlatrateZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.OnlineZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand41;import com.adgamewonderland.eplus.base.tarifberater.automat.SMSAllnetZustand42;import com.adgamewonderland.eplus.base.tarifberater.automat.TelefonieDauerZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.TelefonieZustand;import com.adgamewonderland.eplus.base.tarifberater.automat.VertragsZustand;import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;import com.adgamewonderland.eplus.base.tarifberater.beans.Konfiguration;import com.adgamewonderland.eplus.base.tarifberater.beans.Tarifberater;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;class com.adgamewonderland.eplus.base.tarifberater.automat.TarifberaterAutomat extends DefaultController implements IZustand {	private var berater : Tarifberater;

	private var zustand : IZustand;
	
	private var weg : Collection;		private var vertragsZustand : VertragsZustand;

	private var telefonieZustand : TelefonieZustand;	private var telefonieDauerZustand : TelefonieDauerZustand;		private var allnetZustand24 : AllnetZustand24;		private var allnetZustand31 : AllnetZustand31;		private var allnetZustand32 : AllnetZustand32;		private var smsAllnetZustand41 : SMSAllnetZustand41;		private var smsAllnetZustand42 : SMSAllnetZustand42;
	
	private var onlineZustand : OnlineZustand;		private var handyInternetFlatrateZustand : HandyInternetFlatrateZustand;
	private var internetFlatrateZustand : InternetFlatrateZustand;
	
	private var fertigZustand : FertigZustand;
	
	private var fehlerZustand : FehlerZustand;

	public function TarifberaterAutomat(aBerater : Tarifberater ) {		// berater		this.berater = aBerater;
		// zustaende
		this.vertragsZustand = new VertragsZustand(this);
		this.telefonieZustand = new TelefonieZustand(this);		this.telefonieDauerZustand = new TelefonieDauerZustand(this);		this.allnetZustand24 = new AllnetZustand24(this);		this.allnetZustand31 = new AllnetZustand31(this);		this.allnetZustand32 = new AllnetZustand32(this);		this.smsAllnetZustand41 = new SMSAllnetZustand41(this);		this.smsAllnetZustand42 = new SMSAllnetZustand42(this);
		this.onlineZustand = new OnlineZustand(this);		this.handyInternetFlatrateZustand = new HandyInternetFlatrateZustand(this);		this.internetFlatrateZustand = new InternetFlatrateZustand(this);		this.fertigZustand = new FertigZustand(this);
		this.fehlerZustand = new FehlerZustand(this);
	}
	public function getId() : String {
		// an zustand delegieren
		return this.zustand.getId();
	}	public function getFortschritt() : Number {		// an zustand delegieren		return this.zustand.getFortschritt();	}		public function getFrage() : Frage {		// an zustand delegieren		return this.zustand.getFrage();	}
	
	public function produktWaehlenMoeglich(aProdukt : IProdukt ) : Boolean {
		// an zustand delegieren
		return this.zustand.produktWaehlenMoeglich(aProdukt);
	}

	public function produktWaehlen(aProdukt : IProdukt) : Void {
		// an zustand delegieren
		this.zustand.produktWaehlen(aProdukt);
	}
	
	public function zurueckGehenMoeglich() : Boolean {
		// an zustand delegieren
		return this.zustand.zurueckGehenMoeglich();
	}
	
	public function zurueckGehen() : Void {
		// an zustand delegieren
		this.zustand.zurueckGehen();
	}
	
	public function vorwaertsGehenMoeglich() : Boolean {
		// an zustand delegieren
		return this.zustand.vorwaertsGehenMoeglich();
	}

	public function vorwaertsGehen() : Void {
		// an zustand delegieren
		this.zustand.vorwaertsGehen();
	}
	
	public function warenkorbBestellenMoeglich() : Boolean {
		// an zustand delegieren
		return this.zustand.warenkorbBestellenMoeglich();
	}
	
	public function warenkorbBestellen(aSessionid : String ) : Void {
		// an zustand delegieren
		this.zustand.warenkorbBestellen(aSessionid);
	}

	public function handyAuswaehlenMoeglich() : Boolean {
		// an zustand delegieren
		return this.zustand.handyAuswaehlenMoeglich();
	}
	
	public function handyAuswaehlen(aSessionid : String ) : Void {
		// an zustand delegieren
		this.zustand.handyAuswaehlen(aSessionid);
	}
	
	public function neuStartenMoeglich() : Boolean {
		// an zustand delegieren
		return this.zustand.neuStartenMoeglich();
	}		public function equals(aZustand : IZustand) : Boolean {		// an zustand delegieren		return this.zustand.equals(aZustand);	}		public function isStartZustand() : Boolean {		// an zustand delegieren		return this.zustand.isStartZustand();	}	public function isEndeZustand() : Boolean {		// an zustand delegieren		return this.zustand.isEndeZustand();	}
	
	public function neuStarten() : Void {
		// gewaehlter weg durch die zustaende
		this.weg = new CollectionImpl();
		// warenkorb leeren
		getBerater().leereWarenkorb();
		// anfangszustand
		setZustand(getBerater().getKonfiguration().getStart());
	}	public function getBerater() : Tarifberater {
		return this.berater;
	}
	public function getWegString() : String {
		// weg als string
		var wegstr : String = "";
		// zustand
		var zustand : IZustand;
		// zustaende im weg
		var iterator : Iterator = this.weg.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// zustand
			zustand = IZustand(iterator.next());
			// hinzufuegen
			wegstr += zustand.getId() + ";";
		}		
		// zurueck geben
		return wegstr;
	}
	
	public function setZustand(aZustand : IZustand ) : Void {
		this.zustand = aZustand;
		
		// neuen zustand in weg aufnehmen, falls nicht schon vorhanden
		if (! this.weg.contains(aZustand))
			this.weg.addItem(aZustand);
		// listener informieren
		_event.send("onZustandGeaendert", aZustand, getBerater().getWarenkorb());
	}

	public function getZustand() : IZustand {
		return this.zustand;
	}
	
	public function getWeg() : Collection {
		return this.weg;	
	}

	public function getVertragsZustand() : VertragsZustand {
		return this.vertragsZustand;
	}

	public function getTelefonieZustand() : TelefonieZustand {
		return this.telefonieZustand;
	}	public function getTelefonieDauerZustand() : TelefonieDauerZustand {		return this.telefonieDauerZustand;	}	public function getAllnetZustand24() : AllnetZustand24 {		return this.allnetZustand24;	}	public function getAllnetZustand31() : AllnetZustand31 {		return this.allnetZustand31;	}	public function getAllnetZustand32() : AllnetZustand32 {		return this.allnetZustand32;	}

	public function getSMSAllnetZustand41() : SMSAllnetZustand41 {
		return this.smsAllnetZustand41;
	}	public function getSMSAllnetZustand42() : SMSAllnetZustand42 {		return this.smsAllnetZustand42;	}

	public function getOnlineZustand() : OnlineZustand {
		return this.onlineZustand;
	}	public function getHandyInternetFlatrateZustand( ) :HandyInternetFlatrateZustand  {		return this.handyInternetFlatrateZustand;	}	public function getInternetFlatrateZustand() : InternetFlatrateZustand {		return this.internetFlatrateZustand;	}	public function getFertigZustand() : FertigZustand {
		return this.fertigZustand;
	}

	public function getFehlerZustand() : FehlerZustand {
		return this.fehlerZustand;
	}
	
	public function getKonfiguration() : Konfiguration {		return getBerater().getKonfiguration();
	}
}
