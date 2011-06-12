/* Popup
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Popup
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		08.07.2004
zuletzt bearbeitet:	08.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.Popup extends MovieClip {

	// Attributes
	
	private var isOpen:Boolean;
	
	// Operations
	
	public  function Popup()
	{
		// geoeffnet oder nicht
		isOpen = false;
		// beim menue registrieren
		_global.Menue.registerPopup(this);
	}
	
	public function get open():Boolean
	{
		// geoeffnet oder nicht
		return (isOpen);
	}
	
	public function set open(bool:Boolean ):Void
	{
		// abbrechen, falls nicht veraendert werden soll
		if (bool == open) return;
		// geoeffnet oder nicht
		isOpen = bool;
		// bewegen
		_parent.gotoAndPlay((bool ? "frOpen" : "frClose"));
	}
	
	public function onReleaseButton(mc:MovieClip):Void
	{
		// nummer aus instanzname
		var num:Number = Number(mc._name.substring(mc._name.indexOf("b")+1, mc._name.indexOf("_")));
		// an menue uebergeben
		_global.Menue.showContent(_parent._name, num);
	}

} /* end class Popup */
