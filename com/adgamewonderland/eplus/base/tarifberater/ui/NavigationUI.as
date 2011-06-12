import com.adgamewonderland.agw.util.HashMap;import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;import com.adgamewonderland.eplus.base.tarifberater.ui.HintergrundUI;import mx.utils.Delegate;import flash.geom.Rectangle;
class com.adgamewonderland.eplus.base.tarifberater.ui.NavigationUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr {
	
	private static var YDIFFRAHMEN : Number = 156;
	
	private static var YDIFFBUTTONS : Number = 32;

	private var zurueck_btn : Button;
	
	private var neu_btn : Button;
	
	private var vorwaerts_btn : Button;
	
	private var handy_btn : Button;
	
	private var warenkorb_btn : Button;
	
	private var handy2_btn : Button;
	
	private var warenkorb2_btn : Button;
	
	private var rahmen_mc : HintergrundUI;
	
	private var testimonial_mc : MovieClip;
	
	private var sizables : HashMap;

	public function NavigationUI() {
		// buttons initialisieren
		zurueck_btn.onRelease = Delegate.create(this, onZurueck);
		neu_btn.onRelease = Delegate.create(this, onNeu); 
		vorwaerts_btn.onRelease = Delegate.create(this, onVorwaerts);
		handy_btn.onRelease = Delegate.create(this, onHandy);
		warenkorb_btn.onRelease = Delegate.create(this, onWarenkorb);
		handy2_btn.onRelease = Delegate.create(this, onHandy);
		warenkorb2_btn.onRelease = Delegate.create(this, onWarenkorb);
		// testimonial ausblenden
//		testimonial_mc._visible = false;
		// andere mcs, die die groesse aendern konnen
		this.sizables = new HashMap();
		// untere buttons staendig an rahmen ausrichten
		this.onEnterFrame = positionierenButtons;
	}

	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().getAutomat().addListener(this);	
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);	
	}
	
	public function onUnload() : Void {
		// als listener deregistrieren
		ApplicationController.getInstance().getAutomat().removeListener(this);	
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);	
	}

	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb ) : Void {
		// buttons entsprechnd de- / aktivieren
		showButtons(aZustand);
	}
	
	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
		// speichern
		this.sizables.put(aSizable.getName(), aSizable);
		// maximalwert fuer unteren rand
		var bottom : Number = 0;
		// groessenbstimmendes
		var sizable : ISizable;
		// schleife ueber sizables
		for (var i : String in this.sizables.getValues()) {
			sizable = this.sizables.getValues()[i];
			// unterer rand
			if (sizable.getSize().bottom > bottom)
				bottom = sizable.getSize().bottom;
		}
		// hintergund skalieren
		rahmen_mc.doTween(rahmen_mc._height, bottom + YDIFFRAHMEN, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION);
		//		rahmen_mc.setYsize(bottom + YDIFFRAHMEN);
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
	}

	/**
	 * de- / aktiviert alle Buttons abhängig von den Möglichkeiten, die der Zustand erlaubt
	 * @param aZustand aktueller Zustand (@see IZustand)
	 */
	private function showButtons(aZustand : IZustand ) : Void {
		// zurueck
		zurueck_btn._visible = aZustand.zurueckGehenMoeglich();
		// neu
		neu_btn._visible = aZustand.neuStartenMoeglich();
		// vorwaerts
		vorwaerts_btn._visible = aZustand.vorwaertsGehenMoeglich();
		// handy
		handy_btn._visible = aZustand.handyAuswaehlenMoeglich();
		// warenkorb
		warenkorb_btn._visible = aZustand.warenkorbBestellenMoeglich();
		// handy
		handy2_btn._visible = aZustand.isEndeZustand();
		// warenkorb
		warenkorb2_btn._visible = aZustand.isEndeZustand();
		// testimonial ein- / ausblenden
		testimonial_mc.gotoAndStop(aZustand.isEndeZustand() ? "frFertig" : "frStart");
	}
	
	/**
	 * positioniert die unteren Buttons relativ zum Rahmen
	 */
	private function positionierenButtons() : Void {
		// buttons relativ zu rahmen verschieben
		zurueck_btn._y = neu_btn._y = vorwaerts_btn._y = handy2_btn._y = warenkorb2_btn._y = Math.round(rahmen_mc._y + rahmen_mc ._height  - YDIFFBUTTONS);
	}

	private function onZurueck() : Void {
		ApplicationController.getInstance().zurueckAction();
	}

	private function onNeu() : Void {
		ApplicationController.getInstance().neuAction();
	}

	private function onVorwaerts() : Void {
		ApplicationController.getInstance().vorwaertsAction();
	}

	private function onWarenkorb() : Void {
		ApplicationController.getInstance().warenkorbAction();
	}

	private function onHandy() : Void {
		ApplicationController.getInstance().handyAction();
	}
}