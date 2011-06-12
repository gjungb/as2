import com.adgamewonderland.eplus.ayyildiz.ayworld.Controller;

class com.adgamewonderland.eplus.ayyildiz.ayworld.SelectorUI extends MovieClip 
{
	private var _ydiff:Number = 100;
	private var _ystart:Number;
	private var selected:Number;

	public function SelectorUI()
	{
		// startposition
		_ystart = _y;
		// aktueller abschnitt auf y-achse
		this.selected = 0;
	}
	
	public function onEnterFrame():Void
	{
		// y-abstand zur startposition
		var ydiff:Number = Math.ceil(Math.abs(_y - _ystart));
		// abschnitt auf y-achse
		var yslice:Number = Math.ceil(ydiff / _ydiff);
		// testen, ob abschnitt gewechselt
		if (yslice != getSelected()) {
			// neuen abschnitt speichern
			setSelected(yslice);
			// controller informieren
			Controller.getInstance().onUpdateSelector(getSelected());
		}
	}

	public function setSelected(selected:Number):Void
	{
		this.selected = selected;
	}

	public function getSelected():Number
	{
		return this.selected;
	}
}