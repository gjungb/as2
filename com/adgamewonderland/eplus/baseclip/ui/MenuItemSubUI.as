import com.adgamewonderland.eplus.baseclip.ui.MenuItemUI;
import com.adgamewonderland.eplus.baseclip.ui.MenuItemMainUI;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.eplus.baseclip.ui.ContentUI;
/*
klasse:			MenuItemSubUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		25.02.2005
zuletzt bearbeitet:	08.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.ui.MenuItemSubUI extends MenuItemUI {

	private static var TEXTCOLORS:Array = [0x000000, 0xFFFFFF];

	private static var MOVETIME:Number = 100;

	private var _myMenuItemMain:MenuItemMainUI;

	private var myMoveChangeAlpha:Number;

	public function MenuItemSubUI()
	{
		// eigenschaften des MenuItemUI
		super();
		// x-abstand zur ausklappposition
		myXdiff = XDIFF["sub"];
		// um welchen wert soll alpha waehrend der bewegung geandert werden
		myMoveChangeAlpha = 0;
		// durchsichtig
		_alpha = 0;
	}

	public function onRollOver()
	{
		// animation abspielen
		animation_mc.gotoAndPlay("frOver");
		// text faerben
		var col:Color = new Color(menuname_mc);
		col.setRGB(TEXTCOLORS[1]);
	}

	public function onRollOut()
	{
		// animation abspielen
		animation_mc.gotoAndPlay("frOut");
		// text faerben
		var col:Color = new Color(menuname_mc);
		col.setRGB(TEXTCOLORS[0]);
	}

	public function onPress()
	{
		// beim taktgeber anmelden
		_global.Stroke.addListener(this);
		// mausverfolgung starten
		trackMouse(true);
	}

	public function onRelease()
	{
		// abbrechen, wenn aktuell in bewegung
		if (moving == true) return;
		// aktuell vom user aktiviert oder nicht
		switch (activated) {
			// ja => nichts
			case true :

				break;
			// nein => subnavigation umschalten
			case false :
				// an hauptmenupunkt weiter reichen
				_myMenuItemMain.swapSubMenu(myContentDescriptor.path);

				break;
		}
	}

	public function onReleaseOutside()
	{
		// animation und textfarbe aendern
		onRollOut();
	}

	public function onMove():Void
	{
		// aktuell in bewegung
		moving = true;
		// alpha aendern
		_alpha += myMoveChangeAlpha;
		// einblenden
		_visible = true;
	}

	public function onStopMove():Void
	{
		// art der beendeten bewegung
		var lastmove:String = movemode;
		// bewegung beendet
		movemode = "";
		// nicht in bewegung
		moving = false;
		// je nach art der beendeten bewegung
		switch (lastmove) {
			// an startposition angekommen
			case "start" :
				// undurchsichtig
				_alpha = 100;
				// vom user aktiviert
				if (activated) {
					// deaktivieren
					activated = false;
					// aktivieren
					moveToActivated(true);
				}
				break;
			// an nullposition angekommen
			case "zero" :
				// durchsichtig
				_alpha = 0;
				// ausblenden
				_visible = false;

				break;
			// an ein- / ausklappposition angekommen
			case "activated" :
				// angekommen
				onReachTargetPos();

				break;
			// an dragposition angekommen
			case "drag" :
				// draggen endet erst onMouseUp => nichts weiter veranlassen

				break;
			// unbekannt
			default :
				break;
		}
	}

	public function moveToStart(sitemap:Boolean ):Void
	{
		// ggf. deaktivieren
		if (sitemap == true) activated = false;
		// art der bewegung
		movemode = "start";
		// bewegung starten (linear)
		var steps:Number = myMover.startMove(0, new Point(myPosStart.x, _myMenuItemMain.submenupos.y), myPosStart, MOVETIME, {});
		// um welchen wert soll alpha waehrend der bewegung geandert werden
		myMoveChangeAlpha = (100 / steps); // Math.round
	}

	public function moveToZero():Void
	{
		// art der bewegung
		movemode = "zero";
		// bewegung starten (linear)
		var steps:Number = myMover.startMove(0, new Point(myPosAct.x, myPosAct.y), new Point(myPosStart.x, _myMenuItemMain.submenupos.y), MOVETIME, {});
		// um welchen wert soll alpha waehrend der bewegung geandert werden
		myMoveChangeAlpha = (-100 / steps); // Math.round
	}

	public function moveToActivated(bool:Boolean ):Void
	{
		// abbrechen, wenn schon an dieser position
		if (activated == bool) return;
		// aktuell vom user aktiviert
		activated = bool;
		// abbrechen, wenn aktuell andere bewegung
		if (movemode == "start" || movemode == "zero") return;
		// art der bewegung
		movemode = "activated";
		// zur ausklapp- / einklappposition
		switch (bool) {
			// ausklapp
			case true :
				// bewegung starten (linear)
				var steps:Number = myMover.startMove(0, myPosStart, new Point(myPosStart.x + myXdiff, myPosStart.y), MOVETIME, {});
				// um welchen wert soll alpha waehrend der bewegung geandert werden
				myMoveChangeAlpha = 0;

				break;
			// einklapp
			case false :
				// bewegung starten (linear)
				var steps:Number = myMover.startMove(0, new Point(myPosAct.x, myPosAct.y), myPosStart, MOVETIME, {});
				// um welchen wert soll alpha waehrend der bewegung geandert werden
				myMoveChangeAlpha = 0;

				break;
		}
	}

	public function onReachTargetPos():Void
	{
		// aktuell vom user aktiviert oder nicht
		switch (activated) {
			// ja => content anzeigen
			case true :
				// content anzeigen
				ContentUI.getMovieClip().showContent(myContentDescriptor);

				break;
			// nein => nichts
			case false :

				break;
		}
	}
}