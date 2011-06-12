/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

import com.adgamewonderland.sskddorf.mischpult.ui.*;

class com.adgamewonderland.sskddorf.mischpult.ui.ProductListUI extends MovieClip {
	
	public static var DIRECTION_UP:Number = 1;
	
	public static var DIRECTION_DOWN:Number = -1;
	
	private static var ITEMS_YDIFF:Number = 18;
	
	private static var LISTPOS:Object = {x : 0, y : 0};
	
	private static var LISTDIMS:Object = {width : 400, height : 90};
	
	private static var LISTSCROLL:Number = 0.6;
	
	private var list_mc:MovieClip;
	
	private var mask_mc:MovieClip;
	
	private var up_btn:MovieClip;
	
	private var down_btn:MovieClip;
	
	private var default_txt:TextField;
	
	public function ProductListUI() {
		
	}
	
	public function showProducts(produkte:Array ):Void
	{
		// liste loeschen
		clearList();
		// neue liste
		list_mc = this.createEmptyMovieClip("list_mc", 1);
		// schleife ueber alle produkte
		for (var i = 0; i < produkte.length; i ++) {
			// constructor
			var constructor:Object = {};
			// position
			constructor._y = i * ITEMS_YDIFF;
			// produkt
			constructor._product = produkte[i];
			// item attachen
			var product_mc:ProductItemUI = ProductItemUI(list_mc.attachMovie("ProductItemUI", "product" + i + "_mc", i + 1, constructor));
		}
		// maskieren
		showMask(list_mc);
		// scroll buttons
		initScrollButtons();
	}
	
	public function moveList(direction:Number ):Void
	{
		// wie weit bewegen
		var ydiff:Number = direction * LISTSCROLL;
		// je nach richtung grenzen pruefen
		switch (direction) {
			case DIRECTION_UP :
				// abbrechen, wenn zu weit nach unten
				if (list_mc._y + ydiff > LISTPOS.y) ydiff = 0;
				break;
			case DIRECTION_DOWN :
				// abbrechen, wenn zu weit nach oben
				if ((list_mc._height - (-list_mc._y)) < LISTDIMS.height) ydiff = 0;
			
				break;
		}
		
		// bewegen
		list_mc._y += ydiff;
	}
	
	public function showDefaulttext(text:String ):Void
	{
		// liste loeschen
		clearList();
		// text anzeigen
		default_txt.text = text;
	}
	
	private function showMask(target:MovieClip ):Void
	{
		// neue maske
		this.createEmptyMovieClip("mask_mc", 2);
		// positionieren
		mask_mc._x = LISTPOS.x;
		mask_mc._y = LISTPOS.y;
		// rechteck mit fuellung
		mask_mc.beginFill(0xCCCCCC, 100);
		// zeichnen
		mask_mc.lineTo(LISTDIMS.width, 0);
		mask_mc.lineTo(LISTDIMS.width, LISTDIMS.height);
		mask_mc.lineTo(0, LISTDIMS.height);
		mask_mc.lineTo(0, 0);
		// als maske
		target.setMask(mask_mc);
	}
	
	private function initScrollButtons():Void
	{
		up_btn.onPress = function():Void {
			this.onEnterFrame = function():Void {
				this._parent.moveList(ProductListUI.DIRECTION_UP);
			}
		};
		up_btn.onRelease = function():Void {
			delete(this.onEnterFrame);
		};
		up_btn.onReleaseOutside = up_btn.onDragOut = up_btn.onRelease;
		
		down_btn.onPress = function():Void {
			this.onEnterFrame = function():Void {
				this._parent.moveList(ProductListUI.DIRECTION_DOWN);
			}
		};
		down_btn.onRelease = function():Void {
			delete(this.onEnterFrame);
		};
		down_btn.onReleaseOutside = down_btn.onDragOut = down_btn.onRelease;
	}
	
	private function clearList():Void
	{
		// zaehler
		var i = 0;
		// schleife ueber alle angezeigten produkte
		while (list_mc["product" + (i++) + "_mc"] instanceof MovieClip) list_mc["product" + i + "_mc"].removeMovieClip();
		// liste loeschen
		list_mc.removeMovieClip();
		// maske loeschen
		mask_mc.removeMovieClip();
		// defaulttext loeschen
		default_txt.text = "";
	}
}