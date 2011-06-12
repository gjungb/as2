import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.automat.FertigZustand;

import flash.geom.Point;
import flash.geom.Rectangle;

import mx.transitions.Tween;
import mx.utils.Collection;

import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.ui.HintergrundUI;
import com.adgamewonderland.eplus.base.tarifberater.ui.ProduktkategorieUI;

class com.adgamewonderland.eplus.base.tarifberater.ui.WarenkorbUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr, ISizable {	private var _xstart : Number;		private var _ystart : Number;		private var _xdiff : Number;		private var _ydiff : Number;	private var rahmen_mc : HintergrundUI;
	
	private var back_mc : MovieClip;		public function WarenkorbUI() {		// TODO: auf- / zuklappen, ein- / ausfaden
		// ausblenden
		this._visible = false;
		// hintergrund als button
		back_mc.onRelease = function() : Void {
		};
		back_mc.useHandCursor = false;
		
		back_mc._visible = false;	}
	
	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().getAutomat().addListener(this);			// als listener registrieren		ApplicationController.getInstance().addListener(this);		}		public function onUnload() : Void {
		// als listener deregistrieren
		ApplicationController.getInstance().getAutomat().removeListener(this);			// als listener deregistrieren		ApplicationController.getInstance().removeListener(this);		}		public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {		// anzeigen		onZeigeWarenkorb(aWarenkorb, aZustand instanceof FertigZustand, aZustand);	}

	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}
	
	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand ) : Void {
		// ein- / ausblenden
		//this._visible = aSichtbar;
		this._visible = false;
		// hintergrund ein- / ausblenden
//		back_mc._visible = aZustand instanceof FertigZustand == false;
		back_mc.visible = false;
		// animation
		doTween(0, 100, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION);
		// anzeigen
		//zeigeWarenkorb(aWarenkorb);
		// controller informieren
//		if (aZustand instanceof FertigZustand)
			ApplicationController.getInstance().aendereGroesse(this);
	}
	/**	 * Zeigt die Inhalte des Warenkorbs an	 * @param aWarenkorb	 */	public function zeigeWarenkorb(aWarenkorb : Warenkorb ) : Void {		// ggf. alte mcs loeschen		for (var i : String in this) {			if (this[i] instanceof ProduktkategorieUI) {				var ui : ProduktkategorieUI = ProduktkategorieUI(this[i]);				ui.removeMovieClip();			}		}		// produkte, die je kategorie angezeigt werden sollen		var produkte : Collection;		// position, an der die kategorie angezeigt werden soll		var position : Point = new Point(_xstart, _ystart);		// 1. tarife		produkte = aWarenkorb.getTarife();
		// anzeigen		position = zeigeProduktkategorie("Ihr BASE Tarif:", produkte, position);				// 2. onlinevorteile		produkte = aWarenkorb.getOnlinevorteile();		// anzeigen		position = zeigeProduktkategorie("Vorteil bei Online Bestellung:", produkte, position);				// 3. tarifoptionen		produkte = aWarenkorb.getTarifoptionen();		// anzeigen		position = zeigeProduktkategorie("Gewählte Tarifoptionen:", produkte, position);				// rahmen skalieren		rahmen_mc.setYsize(position.y - _ydiff);//		rahmen_mc.doTween(rahmen_mc._height, position.y - _ydiff, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION);
		// hintergund skalieren
		back_mc._height = rahmen_mc._y + rahmen_mc._height;	}		public function getPosition() : Point {		// position als punkt		return new Point(_x, _y);	}		public function getSize() : Rectangle {		// groesse als rechteck		var size : Rectangle = new Rectangle(0, 0, _width, _visible ? _height - _y : 0);		// zurueck geben		return size;	}		public function getName() : String {		return this._name;	}	/**	 * Bringt eine Produktkategorie auf die Bühne	 * @param aKategorie	 * @param aProdukte	 * @param aPosition	 * @return die Position, an der die nächste Kategorie angezeigt werden soll	 */	private function zeigeProduktkategorie(aKategorie : String, aProdukte : Collection, aPosition : Point) : Point {		// abbrechen, wenn keine produkte		if (aProdukte.isEmpty())			return aPosition;		// konstruktor		var constructor:Object = new Object();		// kategorie		constructor._kategorie = aKategorie;		// produkte		constructor._produkte = aProdukte;		// position		constructor._x = aPosition.x;		constructor._y = aPosition.y;		// auf buehne		var ui : ProduktkategorieUI = ProduktkategorieUI(this.attachMovie("ProduktkategorieUI", "kategorie" + this.getNextHighestDepth() + "_mc", this.getNextHighestDepth(), constructor));		// naechste position		return new Point(ui._x + _xdiff, ui._y + aProdukte.getLength() *  ui._height + _ydiff);	}

	/**
	 * Ändert Alpha des Hintergrunds mittels Tweening
	 * @param aStart Startalpha
	 * @param aEnd Endalpha
	 * @param aDuration Dauer in s
	 */
	private function doTween(aStart : Number, aEnd : Number, aFunction : Function, aDuration : Number ) : Void {
		// tween fur alpha
		var t1 : Tween = new Tween(this, "_alpha", aFunction, aStart, aEnd, aDuration, true);
	}}