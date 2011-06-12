/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.aldi.sudoku.beans.Content;
import com.adgamewonderland.aldi.sudoku.beans.FieldImpl;
import com.adgamewonderland.aldi.sudoku.ui.FieldControllerButtonUI;

class com.adgamewonderland.aldi.sudoku.ui.FieldControllerUI extends MovieClip {
	
	private var field:FieldImpl;
	
	private var buttons:Array;
	
	public function FieldControllerUI() {
		// initialisieren
		init();
	}
	
	public function init():Void
	{
		// zaehler
		var i:Number = -1;
		// buttons initialisieren
		while (this["b" + (++i) + "_mc"] != undefined) {
			// aktueller button
			var mc:MovieClip = this["b" + i + "_mc"];
			// speichern
			this.buttons.push(mc);
			// callback
			mc.onPress = function() {
				_parent.onSelectButton(this);
			};
		}
	}
	
	public function onSelectButton(btn:FieldControllerButtonUI ):Void
	{
		// field informieren
		this.field.changeContent(new Content(btn.getId()));
	}
	
	public function setPosition(center:Point ):Void
	{
		// positionieren
		this._x = center.x - this._width / 2;
		this._y = center.y - this._height / 2;
	}
	
	public function getField():FieldImpl {
		return field;
	}

	public function setField(field:FieldImpl):Void {
		this.field = field;
	}

}