import com.adgamewonderland.eplus.baseclip.interfaces.Fadable;
/*
klasse:			Fader
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		08.03.2005
zuletzt bearbeitet:	08.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.util.Fader {

	private var myTarget:Fadable;

	private var myAlpha:Number;

	private var myAlphaDiff:Number;

	private var myStep:Number;

	private var myInterval:Number;

	public function Fader(target:Fadable )
	{
		// object (movieclip, button, textfeld), das gefadet wird
		myTarget = target;
		// aktuelles alpha
		myAlpha = 0;
		// alpha differenz je step
		myAlphaDiff = 0;
		// aktueller schritt
		myStep = 0;
		// interval
		myInterval = 0;
	}

	public function startFader(alphastart:Number, alphaend:Number, time:Number, steps:Number ):Void
	{
		// aktuelles alpha
		myAlpha = alphastart;
		// alpha differenz je step
		myAlphaDiff = (alphaend - alphastart) / steps;
		// aktueller schritt
		myStep = steps;
		// ziel einfaerben
		myTarget.onFade(alphastart);
		// regelmaessig ausfuehren
		myInterval = setInterval(this, "doFade", time / steps);
	}

	private function doFade():Void
	{
		// ziel einfaerben
		myTarget.onFade(myAlpha += myAlphaDiff);
		// runterzaehlen
		if (--myStep == 0) {
			// beenden
			clearInterval(myInterval);
			// ziel informieren
			myTarget.onStopFade();
		}
	}
}