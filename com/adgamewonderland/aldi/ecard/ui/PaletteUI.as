/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.ui.*;

class com.adgamewonderland.aldi.ecard.ui.PaletteUI extends MovieClip {
	
	private var myItemUI:ItemUI;
	
	private var scaleup_btn:Button;
	
	private var scaledown_btn:Button;
	
	private var remove_btn:Button;
	
	public function PaletteUI() {
		myItemUI = ItemUI(_parent);
		// vergroessern
		scaleup_btn.onRelease = function() {
			this._parent.onScaleUp();
		}
		// verkleinern
		scaledown_btn.onRelease = function() {
			this._parent.onScaleDown();
		}
		// loeschen
		remove_btn.onRelease = function() {
			this._parent.onRemove();
		}
	}
	
	public function onScaleUp():Void
	{
		myItemUI.scaleItem(1);
	}
	
	public function onScaleDown():Void
	{
		myItemUI.scaleItem(-1);
	}
	
	public function onRemove():Void
	{
		myItemUI.removeItem();
	}
}