import mx.utils.Collection;

	private var zustand : IZustand;
	
	private var weg : Collection;

	private var telefonieZustand : TelefonieZustand;
	
	private var onlineZustand : OnlineZustand;
	private var internetFlatrateZustand : InternetFlatrateZustand;
	
	private var fertigZustand : FertigZustand;
	
	private var fehlerZustand : FehlerZustand;

	public function TarifberaterAutomat(aBerater : Tarifberater ) {
		// zustaende
		this.vertragsZustand = new VertragsZustand(this);
		this.telefonieZustand = new TelefonieZustand(this);
		this.onlineZustand = new OnlineZustand(this);
		this.fehlerZustand = new FehlerZustand(this);
	}

		// an zustand delegieren
		return this.zustand.getId();
	}
	
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
	}
	
	public function neuStarten() : Void {
		// gewaehlter weg durch die zustaende
		this.weg = new CollectionImpl();
		// warenkorb leeren
		getBerater().leereWarenkorb();
		// anfangszustand
		setZustand(getBerater().getKonfiguration().getStart());
	}
		return this.berater;
	}

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
	}

	public function getSMSAllnetZustand41() : SMSAllnetZustand41 {
		return this.smsAllnetZustand41;
	}

	public function getOnlineZustand() : OnlineZustand {
		return this.onlineZustand;
	}
		return this.fertigZustand;
	}

	public function getFehlerZustand() : FehlerZustand {
		return this.fehlerZustand;
	}
	
	public function getKonfiguration() : Konfiguration {
	}
}