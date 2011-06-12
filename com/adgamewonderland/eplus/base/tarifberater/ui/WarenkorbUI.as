﻿import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
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

class com.adgamewonderland.eplus.base.tarifberater.ui.WarenkorbUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr, ISizable {
	
	private var back_mc : MovieClip;
		// ausblenden
		this._visible = false;
		// hintergrund als button
		back_mc.onRelease = function() : Void {
		};
		back_mc.useHandCursor = false;
		
		back_mc._visible = false;
	
	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().getAutomat().addListener(this);	
		// als listener deregistrieren
		ApplicationController.getInstance().getAutomat().removeListener(this);	

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
	/**
		// anzeigen
		// hintergund skalieren
		back_mc._height = rahmen_mc._y + rahmen_mc._height;

	/**
	 * Ändert Alpha des Hintergrunds mittels Tweening
	 * @param aStart Startalpha
	 * @param aEnd Endalpha
	 * @param aDuration Dauer in s
	 */
	private function doTween(aStart : Number, aEnd : Number, aFunction : Function, aDuration : Number ) : Void {
		// tween fur alpha
		var t1 : Tween = new Tween(this, "_alpha", aFunction, aStart, aEnd, aDuration, true);
	}