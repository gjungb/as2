import com.adgamewonderland.eplus.baseclip.interfaces.Movable;
import com.adgamewonderland.eplus.baseclip.descriptors.ContentDescriptor;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.eplus.baseclip.descriptors.NavigationDescriptor;
import com.adgamewonderland.eplus.baseclip.util.Mover;
/*
klasse:			MenuItemUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		25.02.2005
zuletzt bearbeitet:	06.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.ui.MenuItemUI extends MovieClip implements Movable {

	private static var XDIFF:Object = {main:140, sub:20};

	private var _myPath:Array;

	private var _myPosStart:Object;

	private var myContentDescriptor:ContentDescriptor;

	private var myPosStart:Point;

	private var myPosAct:Point;

	private var myPosDrag:Point;

	private var myXdiff:Number;

	private var myMover:Mover;

	private var isMoving:Boolean;

	private var myMoveMode:String;

	private var isActivated:Boolean;

	private var isDragged:Boolean;

	private var menuname_txt:TextField;

	private var menuname_mc:MovieClip;

	private var animation_mc:MovieClip;

	private var line_mc:MovieClip;

	public function MenuItemUI()
	{
		// content descriptor
		myContentDescriptor = NavigationDescriptor.getInstance().getContentDescriptor(_myPath);

		trace(myContentDescriptor);

		// start position auf buehne aus komponentenparametern
		myPosStart = new Point(_myPosStart.x, _myPosStart.y);
		// aktuelle position auf buehne
		myPosAct = new Point(_x, _y);
		// start position beim draggen
		myPosDrag = new Point(_x, _y);
		// mover,der das menuitem bewegt
		myMover = new Mover(this);
		// aktuell in bewegung
		isMoving = false;
		// art der aktuellen bewegung
		myMoveMode = "";
		// aktuell vom user aktiviert
		isActivated = false;
		// wurde zuletzt gedraggt
		isDragged = false;
		// name linksbuendig
		menuname_txt.autoSize = "left";
		// name anzeigen
		menuname_txt.text = myContentDescriptor.menuname.toUpperCase();
//		menuname_mc.gotoAndStop("fr" + _myPath.join(""));
		// hitarea begrenzen
		hitArea = animation_mc;
	}

	public function onRollOver() {}

	public function onRollOut() {}

	public function onPress() {}

	public function onRelease() {}

	public function onReleaseOutside() {}

	public function onMove():Void {}

	public function moveToStart():Void {}

	public function moveToActivated(bool:Boolean ):Void {}

	public function moveToZero():Void {}

	public function onStopMove():Void {}

	public function onReachTargetPos():Void {}

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

	public function set movemode(mode:String ):Void
	{
		// art der aktuellen bewegung
		myMoveMode = mode;
	}

	public function get movemode():String
	{
		// art der aktuellen bewegung
		return myMoveMode;
	}

	public function set activated(bool:Boolean ):Void
	{
		// menuitem aktiviert
		isActivated = bool;
	}

	public function get activated():Boolean
	{
		// menuitem aktiviert
		return isActivated;
	}

	public function set dragged(bool:Boolean ):Void
	{
		// wurde zuletzt gedraggt
		isDragged = bool;
	}

	public function get dragged():Boolean
	{
		// wurde zuletzt gedraggt
		return isDragged;
	}

	public function setPosition(xpos:Number, ypos:Number ):Void
	{
		// neue position
		myPosAct.x = Math.round(xpos);
		myPosAct.y = Math.round(ypos);
		// positionieren
		_x = myPosAct.x;
		_y = myPosAct.y;
	}

	public function trackMouse(bool:Boolean ):Void
	{
		// beenden, sobald maus losgelassen
		onMouseUp = function () {trackMouse(false);};
		// mausverfolgung starten / beenden
		switch (bool) {
			// starten
			case true :
				// ganz nach vorne
				swapDepths(1000);
				// start position beim draggen
				myPosDrag.x = _xmouse;
				myPosDrag.y = _ymouse;
				// button deaktivieren
				enabled = false;
				// maus verfolgen
				onEnterFrame = function() {followMouse();};

				break;
			// beenden
			case false :
				// button aktivieren
				enabled = true;
				// maus verfolgen beenden
				delete (onEnterFrame);

				break;
		}
	}

	public function followMouse():Void
	{
		// nur bewegen, wenn maus ausserhalb
		if (this.hitTest(_root._xmouse, _root._ymouse, true)) return;
		// startposition
		var pstart:Object = {x : _x , y : _y};
		// zielposition (mausposition)
		var pend:Object = {x : _root._xmouse - this._width / 2, y : _root._ymouse - this._height / 2}; // xpos, ypos
		// bewegung starten (linear)
		myMover.startMove(0, new Point(pstart.x, pstart.y), new Point(pend.x, pend.y), 1000, {});
	}
}