
class com.adgamewonderland.eplus.base.tarifberater.ui.FragetextUI extends MovieClip {
	
	private var blende_mc : MovieClip;
	
	private var text1_txt : TextField;
	
	private var text2_txt : TextField;

	public function FragetextUI() {
		// texte
		text1_txt.autoSize = text2_txt.autoSize = "left";
	}
	
	public function zeigeText(aText : String ) : Void {
		// text anzeigen
		text1_txt.text = text2_txt.text = aText;
		// blende skalieren
		blende_mc._width = text1_txt._width;
		// blende abspielen
		blende_mc.gotoAndPlay(1);
	}
}