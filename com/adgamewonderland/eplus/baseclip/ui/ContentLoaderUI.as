/*
klasse:			ContentLoaderUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		26.02.2005
zuletzt bearbeitet:	27.02.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.ui.ContentLoaderUI extends MovieClip {

	// Attributes

	private var _myText:String;

	private var myXstart:Number;

	private var text_txt:TextField;

	private var bar_mc:MovieClip;

	// Operations

	// konstruktor
	public function ContentLoaderUI()
	{
		// anzuzeigender text zentriert
		text_txt.autoSize = "center";
		// text anzeigen
		text = _myText;
		// startposition balken
		myXstart = bar_mc._x - bar_mc._width;
		// balken ausblenden
		bar_mc._visible = false;
	}

	public function set text(tstr:String ):Void
	{
		// anzuzeigender text
		_myText = tstr;
		// anzeigen
		text_txt.text = _myText;
	}

	public function showProgress(percent:Number ):Void
	{
		// neue position
		var pos:Number = myXstart + Math.round(bar_mc._width * percent / 100);
		// balken positionieren
		setBarPosition(pos);
		// balken einblenden
		bar_mc._visible = true;
	}

	private function setBarPosition(pos:Number ):Void
	{
		// positionieren
		bar_mc._x = pos;
	}
}