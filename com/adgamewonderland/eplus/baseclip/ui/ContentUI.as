/*
klasse:			ContentUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		26.02.2005
zuletzt bearbeitet:	09.03.2005
durch			gj
status:			final
*/

import com.adgamewonderland.eplus.baseclip.interfaces.Movable;
import com.adgamewonderland.eplus.baseclip.interfaces.Fadable;
import com.adgamewonderland.eplus.baseclip.descriptors.ContentDescriptor;
import com.adgamewonderland.eplus.baseclip.util.Fader;
import com.adgamewonderland.eplus.baseclip.ui.ContentLoaderUI;
import com.adgamewonderland.eplus.baseclip.ui.ContentIntroUI;
import com.adgamewonderland.eplus.baseclip.descriptors.NavigationDescriptor;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.eplus.baseclip.util.Mover;
import com.adgamewonderland.eplus.baseclip.ui.NavigationUI;

class com.adgamewonderland.eplus.baseclip.ui.ContentUI extends MovieClip implements Movable, Fadable {

	private static var SERVER:String = "http://tripto.adgame-wonderland.de:8080/baseclip/phase1/flash/";

//	private static var SCRIPT:String = "scripts/eplus_cebit_content.php?path=";

	private static var PATH_PREFIX:String = "content/baseclip_";

	private static var PATH_SUFFIX:String = ".log";

	private static var JSMETHOD:String = "javascript:openLink";

	private static var FADETIME:Number = 250;

	private static var FADESTEPS:Number = 5;

	private var myContentDescriptor:ContentDescriptor;

	private var myMover:Mover;

	private var isMoving:Boolean;

	private var myPosDrag:Point;

	private var myFader:Fader;

	private var loader_mc:ContentLoaderUI;

	private var intro_mc:ContentIntroUI;

	private var content_mc:MovieClip;

	private var mover_mc:MovieClip;

	private var back_mc:MovieClip;

	private var close_mc:MovieClip;

	public function ContentUI()
	{
		// aktueller content (startseite)
		myContentDescriptor = NavigationDescriptor.getInstance().getContentDescriptor(["start"]);
		// mover,der das menuitem bewegt
		myMover = new Mover(this);
		// start position beim draggen
		myPosDrag = new Point(_x, _y);
		// fader
		myFader = new Fader(this);
		// aktuell in bewegung
		isMoving = false;
		// button fuer bewegung
		mover_mc.onPress = function() {
			// bewegung starten
			this._parent.trackMouse(true);
		};
		// beim testen zugriff fuer nachgeladene swfs erlauben
//		if (_url.indexOf("http://") == -1)
		System.security.allowDomain("*", "http://tripto.adgame-wonderland.de:8080");
		// ausblenden
		_visible = false;
		// laden
		loadContent();
	}

	/**
	 * gibt globale referenz auf dieses movieclip zurueck
	 */
	public static function getMovieClip():ContentUI
	{
		return ContentUI(_root.content_mc);
	}

	public function set moving(bool:Boolean ):Void
	{
		// aktuell in bewegung
		isMoving = bool;
	}

	public function get moving():Boolean
	{
		// aktuell in bewegung
		return isMoving;
	}

	public function initContent(show:Boolean ):Void
	{
		// ggf. einblenden
		if (show) {
			// einfaden
			myFader.startFader(0, 100, FADETIME, FADESTEPS);
		}
		// wenn fertig geladen
		if (myContentDescriptor.loaded == true && _visible) {
			// video version?
			if (Number(_level0.video) == 1) {
				// nach pause video laden
				var timeend:Number = getTimer() + 2000;
				// zeit verfolgen
				onEnterFrame = function() {
					// warten
					if (getTimer() > timeend) {
						// verfolgen beenden
						delete (onEnterFrame);
						// video laden
						_level0.videoloader_mc.loadVideo(1);
					}
				};
			}
			// intro abspielen
			intro_mc.showIntro(myContentDescriptor.introtext, this, "onIntroFinished");
		}
	}

	public function showContent(desc:ContentDescriptor ):Void
	{
		// content komplett einblenden
		_visible = true;
		// aktueller content
		myContentDescriptor = desc;
		// bisherigen content ausblenden
		closeContent(true, true);
	}

	public function closeContent(load:Boolean, visible:Boolean ):Void
	{
		// ausblenden ueberwachen
		onEnterFrame = function() {
			// testen, ob am ende angekommen
			if (_currentframe == _totalframes) {
				// ueberwachen beenden
				delete (onEnterFrame);
				// callback
				onContentClosed(load, visible);
			}
		};
		// ausblenden
		gotoAndPlay("frClose");
	}

	public function onFade(alpha:Number ):Void
	{
		// einblenden
		_visible = true;
		// alpha setzen
		_alpha = alpha;
	}

	public function onStopFade():Void
	{
	}

	public function onIntroFinished():Void
	{
		// intro ausblenden
		intro_mc._visible = false;
		// content einblenden
		content_mc._visible = true;
		// 20.04.2007 gj: verschiedene dimensionen berücksichtigen
		// mover skalieren
		mover_mc._width = myContentDescriptor.width;
		// hintergrund skalieren
		back_mc._width = myContentDescriptor.width;
		// schliessen button positionieren
		close_mc._x = myContentDescriptor.width;
		// content abspielen
		for (var i in content_mc) {
			if (typeof content_mc[i] == "movieclip") content_mc[i].play();
		}
	}

	public function showLinkExternal():Void
	{
		// aktueller pfad
		var pathstr:String = myContentDescriptor.path.join("");
		// an javascript uebergeben
		getURL(JSMETHOD + "('" + pathstr + "');", "");
	}

	public function setPosition(xpos:Number, ypos:Number ):Void
	{
		// positionieren
		_x = xpos;
		_y = ypos;
	}

	public function trackMouse(bool:Boolean ):Void
	{
		// beenden, sobald maus losgelassen
		onMouseUp = function () {trackMouse(false);};
		// mausverfolgung starten / beenden
		switch (bool) {
			// starten
			case true :
				// start position beim draggen
				myPosDrag.x = _xmouse;
				myPosDrag.y = _ymouse;
				// button deaktivieren
				mover_mc.enabled = false;
				// maus verfolgen
				onEnterFrame = function() {followMouse();};

				break;
			// beenden
			case false :
				// button aktivieren
				mover_mc.enabled = true;
				// maus verfolgen beenden
				delete (onEnterFrame);

				break;
		}
	}

	public function onMove():Void
	{
		// in bewegung
//		moving = true;
	}

	public function onStopMove():Void
	{
		// nicht in bewegung
//		moving = false;
	}

	private function onContentClosed(load:Boolean, show:Boolean ):Void
	{
		// content ausblenden
		content_mc._visible = false;
		// content komplett ausblenden
		_visible = show;
		// neuen content laden oder nicht
		switch (load)  {
			// laden
			case true :
				loadContent();

				break;
			// nicht laden
			case false :
				// testen, ob startseite aktuell angezeigt
				if (myContentDescriptor.path.join("") == "start") {
					// content komplett ausblenden
					_visible = false;
				} else if (show == true) {
					// navigation resetten
					NavigationUI.getMovieClip().resetMenu(null);
					// startseite anzeigen
					showContent(NavigationDescriptor.getInstance().getContentDescriptor(["start"]));
				}

				break;
		}
	}

	private function loadContent():Void
	{
		// loader einblenden
		loader_mc._visible = true;
		// laden uberwachen
		onEnterFrame = function() {
			// prozent geladen
			var percent:Number = Math.round(content_mc.getBytesLoaded() / content_mc.getBytesTotal() * 100);
			// loader anzeigen
			if (!isNaN(percent)) loader_mc.showProgress(percent);
			// fertig geladen
			if (percent == 100) {
				// verfolgen beenden
				delete (onEnterFrame);
				// callback
				onContentLoaded();
			}
		};
		// pfad und dateiname des zu ladenden contents
		var url:String = "";
		// unterscheidung offline / online
		if (_url.indexOf("http://") == -1) {
			// offline
			url = PATH_PREFIX + myContentDescriptor.file + ".swf"; // SERVER +
		} else {
			// online
			url = PATH_PREFIX + myContentDescriptor.file + PATH_SUFFIX;
		}

		trace(url);

		// laden
		content_mc.loadMovie(url);
	}

	private function onContentLoaded():Void
	{
		// vollstaendig geladen
		myContentDescriptor.loaded = true;
		// loader ausblenden
		loader_mc._visible = false;
		// intro einblenden
		intro_mc._visible = true;
		// testen, ob startseite geladen
		if (myContentDescriptor.path.join("") == "start") {
			// initialisieren, ohne einzublenden
			initContent(false);
		} else {
			// intro abspielen
			intro_mc.showIntro(myContentDescriptor.introtext, this, "onIntroFinished");
		}
	}

	private function followMouse():Void
	{
		// x-abstand der maus zur startposition
		var xdiff:Number = _xmouse - myPosDrag.x;
		// y-abstand der maus zur startposition
		var ydiff:Number = _ymouse - myPosDrag.y;
		// linearer abstand
		var radius:Number = Math.sqrt(xdiff * xdiff + ydiff * ydiff);
		// abbrechen, wenn zu nah aneinander
		if (radius < 20) return; // mover_mc._height
//		trace(radius + " # " + mover_mc._height);
		// aktuell in bewegung
		switch (moving) {
			// in bewegung
			case true :

				break;
			// nicht in bewegung
			case false :
				// startposition
				var pstart:Object = {x : _x, y : _y};
				// zielposition
				var pend:Object = {x : _root._xmouse - myPosDrag.x, y : _root._ymouse - myPosDrag.y};
				// bewegung starten (linear)
				myMover.startMove(0, new Point(pstart.x, pstart.y), new Point(pend.x, pend.y), 500, {});

				break;
		}
	}

}