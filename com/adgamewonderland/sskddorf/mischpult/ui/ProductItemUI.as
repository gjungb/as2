/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.ui.*;

class com.adgamewonderland.sskddorf.mischpult.ui.ProductItemUI extends MovieClip {
	
	private var COLOR_UP:Number = 0x000000;
	
	private var COLOR_OVER:Number = 0xCCFFFF;
	
	private var _product:Produkt;
	
	private var nameempfehlung_txt:TextField;
	
	public function ProductItemUI() {
		// produktname
		nameempfehlung_txt.autoSize = "left";
		nameempfehlung_txt.text = _product.getNameempfehlung();
	}
	
	public function onRollOver():Void
	{
		nameempfehlung_txt.textColor = COLOR_OVER;
	}
	
	public function onRollOut():Void
	{
		nameempfehlung_txt.textColor = COLOR_UP;
	}
	
	public function onRelease():Void
	{
		// TODO: event handling
		var mc:ProductDetailsUI = ProductDetailsUI(_root.produktdetails_mc);
		mc.onProductChanged(_product);
		// farbe aendern
		onRollOut();
	}
	
	public function onReleaseOutside():Void
	{
		onRollOut();
	}
	
	public function onPress():Void
	{
		onRollOut();
	}
}