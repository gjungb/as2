/*
klasse:			ContentIntroUI
autor: 			gerd jungbluth, adgamepublic function wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		26.02.2005
zuletzt bearbeitet:	04.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.ui.ContentIntroUI extends MovieClip {

	private var _myPause:Number;

	private var myInterval:Number;

	private var myCaller:Object;

	private var myCallback:String;

	private var introtext_txt:TextField;

	public function ContentIntroUI()
	{
		// text linksbuendig
		introtext_txt.autoSize = "left";
		// mehrzeilig
		introtext_txt.multiline = true;
	}

	public function showIntro(text:String, caller:Object, callback:String ):Void
	{
		// text anzeigen
		introtext_txt.text = text;
		// ggf. verkleinern
		if (introtext_txt.bottomScroll > 4) {
			// textformat
			var tf:TextFormat = introtext_txt.getNewTextFormat();
			// schriftgroesse verkleinern
			tf.size /= 2;
			// neu formatieren
			introtext_txt.setNewTextFormat(tf);
		}
		// caller
		myCaller = caller;
		// callback
		myCallback = callback;
		// frame, in dem sich intro zuletzt befunden hat (um stop() zu bemerken)
		var lastframe:Number = 0;
		// abspielen ueberwachen
		onEnterFrame = function () {
			// stop() erreicht
			if (_currentframe - lastframe == 0) {
				// ueberwachen beenden
				delete (onEnterFrame);
				// nach pause weiter
				myInterval = setInterval(this, "showOutro", _myPause);
			}
			// lastframe aktualisieren
			lastframe = _currentframe;
		};
		// abspielen
		gotoAndPlay("frIn");
	}

	private function showOutro():Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// ausblenden ueberwachen
		onEnterFrame = function() {
			// testen, ob am ende angekommen
			if (_currentframe == _totalframes) {
				// ueberwachen beenden
				delete (onEnterFrame);
				// callback
				myCaller[myCallback]();
			}
		};
		// ausblenden
		gotoAndPlay("frOut");
	}
}