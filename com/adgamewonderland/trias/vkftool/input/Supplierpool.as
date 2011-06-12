/* Supplierpool
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplierpool
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		02.07.2004
zuletzt bearbeitet:	30.06.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Supplierpool extends MovieClip {

	// Attributes
	
	private var myListitems:Array;
	
	private var mySuppliers:Array;
	
	private var isActive:Boolean;
	
	private var list_mc:MovieClip, mask_mc:MovieClip, scrollbar_mc:MovieClip;
	
	private var close_btn:MovieClip;
	
	// Operations
	
	public  function Supplierpool()
	{
		// listitems auf buehne (werden attached)
		myListitems = [];
		// suppliers
		mySuppliers = _parent._parent.suppliers;
		// aktivitaet (sprich zu sehen oder nicht)
		active = false;
		// button aktivieren
		close_btn.onRelease = function () {
			// schliessen
			this._parent._parent.showPool(false);
		}
		// liste initialisieren
		initPool();
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isActive = bool;
	}
	
	public function get active():Boolean
	{
		// zurueck geben
		return (isActive);
	}
	
	private function initPool():Void
	{
		// neue liste
		list_mc = this.createEmptyMovieClip("list_mc", 1);
		// positionieren
		list_mc._x = 34;
		list_mc._y = 60;
		// schleife ueber supplier
		for (var i = 1; i < mySuppliers.length; i ++) {
			// constructor
			var constructor:Object = {};
			// position
			constructor._x = 0;
			constructor._y = (i - 1) * 20;
			// supplier
			constructor._mySupplier = mySuppliers[i];
			// neues listitem
			var mc:MovieClip = list_mc.attachMovie("supplierpoolitem", "item" + i + "_mc", i, constructor);
			// in array schreiben
			myListitems[i] = mc;
		}
		// maskieren
		mask_mc = this.createEmptyMovieClip("mask_mc", 2);
		// an linke obere ecke der liste
		mask_mc._x = list_mc._x;
		mask_mc._y = list_mc._y;
		// maske bauen
		mask_mc.beginFill(0xCCCCCC, 10);
		mask_mc.lineTo(450, 0);
		mask_mc.lineTo(450, 300);
		mask_mc.lineTo(0, 300);
		mask_mc.lineTo(0, 0);
		mask_mc.endFill();
		// als maske setzen
		list_mc.setMask(mask_mc);
		// scrollbar anpassen
		scrollbar_mc.setScrollTarget(list_mc);
	}
	
	public function setItemSelected(id:Number, bool:Boolean ):Void
	{
		// umschalten, ob item ausgewaehlt oder nicht
		myListitems[id].selected = bool;
	}

} /* end class Supplierpool */
