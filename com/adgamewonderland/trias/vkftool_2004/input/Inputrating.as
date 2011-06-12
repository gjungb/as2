/* Inputrating
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputrating
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Inputrating extends MovieClip {

	// Attributes
	
	private var mySupplier:Supplier;
	
	private var myResultText:Object;
	
	private var result_mc:MovieClip;
	
	private var message_txt:TextField, result_txt:TextField;
	
	private var edit_btn:MovieClip, blind_mc:MovieClip, inputratingform_mc:Inputratingform;
	
	// Operations
	
	public  function Inputrating()
	{
		// lieferant, der aktuell angezeit / bearbeitet wird
		mySupplier = new Supplier(null, "");
		// angezeigter text und prozentzahl, oberhalb der der text angezeigt wird
		myResultText = {positiv : 66, neutral : 33, negativ : 0};
		// button initialisieren
		edit_btn.onRelease = function () {
			// formular einblenden
			this._parent.showForm(true);
		}
	}
	
	public  function showRating(supp:Supplier ):Void
	{
		// lieferant, der aktuell angezeit / bearbeitet wird
		mySupplier = supp;
		// ergebnis des ratings
		var result:Number = supp.rating.result;
		// vollstaendig oder nicht (null, wenn noch nicht vollstaendig, sonst integer 0 - 100)
		switch (result) {
			// nicht vollstaendig
			case null :
				// message einblenden
				message_txt._visible = true;
				// result ausblenden
				result_txt._visible = false;
				// pfeil ausblenden
				result_mc._visible = false;
				 
				break;
			// vollstaendig
			default :
				// schleife ueber moegliche texte
				for (var txt:String in myResultText) {
					// text gefunden
					if (result >= myResultText[txt]) break;
				}
				// text anzeigen
				result_txt.autoSize = "left";
				result_txt.html = true;
				result_txt.htmlText = txt + "<br>" + result + " %";
				// pfeil drehen
				result_mc._rotation = result * -180 / 100;
				
				// message ausblenden
				message_txt._visible = false;
				// result einblenden
				result_txt._visible = true;
				// pfeil einblenden
				result_mc._visible = true;
		}
		// details des ratings anzeigen
		inputratingform_mc.showRating(supp.name, supp.rating);
	}
	
	public  function showForm(bool:Boolean ):Void
	{
		// ein / ausblenden
		switch (bool) {
			// einblenden
			case true :
				// button deaktivieren
				edit_btn.enabled = false;
				// blende verfolgen und am ende das formular reinfahren
				onEnterFrame = function () {
					// blende am ende?
					if (blind_mc._currentframe == 5) {
						// verfolgen beenden
						delete(onEnterFrame);
						// formular reinfahren
						gotoAndPlay("frIn");
					}
				}
				// blende reinfahren (zeigt unsichtbaren button an)
				blind_mc.gotoAndPlay("frIn");
			
				break;
			// ausblenden
			case false :
				// button aktivieren
				edit_btn.enabled = true;
				//  das formular verfolgen und am ende blende rausfahren
				onEnterFrame = function () {
					// blende am ende?
					if (_currentframe == _totalframes) {
						// verfolgen beenden
						delete(onEnterFrame);
						// blende rausfahren
						blind_mc.gotoAndPlay("frOut");
					}
				}
				// formular rausfahren
				gotoAndPlay("frOut");
				// anzeige updaten
				showRating(mySupplier);
			
				break;
		}
	}

} /* end class Inputrating */
