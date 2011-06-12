/* Loaderbox
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Loaderbox
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		07.05.2004
zuletzt bearbeitet:	19.05.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.eplus.soccer.microsite.*;

class com.adgamewonderland.eplus.soccer.microsite.Loaderbox extends Box {

	// Attributes
	
	private var _myPath:String;
	
	private var _myInitframe:Number;
	
	private var _myHeadline:String;
	
	private var myIndex:Number;
	
	private var isLoaded:Boolean, showContent:Boolean;
	
	private var myContent:MovieClip;
	
	private var back_mc:MovieClip, pic_mc:MovieClip, mask_mc:MovieClip, loaded_mc:MovieClip;
	 
	private var headline_txt:TextField, loaded_txt:TextField;
	
	// Operations
	
	public  function Loaderbox()
	{
		// klassenname
		myClassName = "Loaderbox";
		// pfad setzen
		path = _myPath;
		// laden initialisieren
		initBox(_myInitframe, []);
		// headline
// 		headline_txt.text = _myHeadline;
		// animation ausblenden
		loaded_mc._visible = false;
		// content nicht geladen
		loaded = false;
		// soll der content unmittelbar nach dem laden angezeigt werden?
		showContent = false;
		// registrieren
		Playground.registerBox(this);
		// bei subpage registrieren
		myIndex = _parent.registerLoaderbox(this);
	}
	
	// beim entladen wieder abmelden
	public function onUnload():Void
	{
		// deregistrieren
		Playground.unregisterBox(this);
	}
	
	// de- / aktivieren
	public function set active(bool:Boolean ):Void
	{
		// abbrechen, falls aktivieren, obwohl noch nicht geladen
		if (bool && !loaded) return;
		// aktivitaet umschalten
		isActive = bool;
		// buttons de- / aktivieren
		for (var i in myButtons) {
			myButtons[i].enabled = bool;
		}
		// schatten ein- / ausblenden
		shadow_mc._visible = !bool;
	}
	
	// geladen oder nicht
	public function set loaded(bool:Boolean ):Void
	{
		// geladen oder nicht
		isLoaded = bool;
	}
	
	// geladen oder nicht
	public function get loaded():Boolean
	{
		// geladen oder nicht
		return (isLoaded);
	}
	
	// buttons initialisieren
	public function initButtons():Void
	{
		// array mit buttons
		myButtons = [back_mc];
		// callback rollover ueber die karte
		back_mc.onRollOver = back_mc.onRollOut = function () {
			this._parent.onRollBack();
		}
		// callback beim druecken der karte
		back_mc.onRelease = function () {
			this._parent.onPressBack();
		}
		// deaktivieren
		active = false;
	}
	
	// laden starten
	public function startLoading(show:Boolean ):Void
	{
		// content laden
		Playground.loadContent(this, path);
		// soll der content unmittelbar nach dem laden angezeigt werden?
		showContent = show;
	}
	
	// ladevorgang anzeigen
	public function showLoader(content:MovieClip )
	{
		// content merken
		myContent = content;
		// aussehen aendern
// 		nextFrame();
		// animation einblenden
		loaded_mc._visible = true;
		// laden verfolgen
		this.onEnterFrame = function () {
			// content unsichtbar
			content._visible = false;
			// prozent geladen
			var percent:Number = Math.round(content.getBytesLoaded() / content.getBytesTotal() * 100);
			// text zentriert
			loaded_txt.autoSize = "center";
			// anzeigen
			if (!isNaN(percent)) loaded_txt.text = percent + " %";
			// fertig geladen
			if (percent == 100) {
				// verfolgen beenden
				delete (this.onEnterFrame);
				// callback
				onLoaded();
			}
		}
	}
	
	// callback nach ende des ladens
	private function onLoaded():Void
	{
		// content geladen
		loaded = true;
		// aktivieren
		active = true;
		// aussehen aendern
		nextFrame();
		// als html
		headline_txt.html = true;
		// text aus komponentenparameter (zentrieren)
		headline_txt.htmlText = "<P ALIGN=\"CENTER\">" + _myHeadline + "</P>";

		// pic laden
		pic_mc.loadMovie("pics/pic_" + path + ".swf");
		// ggf. content anzeigen lassen
		if (showContent) _parent.showContent(this, myContent);
		// naechstes laden veranlassen
		_parent.loadNext(myIndex);
	}
	
	// callback beim rollover ueber die karte
	public function onRollBack():Void
	{
		// schatten sichtbar / unsichtbar
		shadow_mc._visible = !shadow_mc._visible;
	}
	
	// callback beim druecken der karte
	public function onPressBack():Void
	{
		// loaderboxen aktivieren
		Playground.setBoxesActive("loaderbox", true);
		// entsprechenden content anzeigen lassen
		_parent.showContent(this, myContent);
	}

} /* end class Loaderbox */
