import mx.utils.Delegate;

import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.ea.nextlevel.interfaces.IDraggable;
import com.adgamewonderland.ea.nextlevel.interfaces.IDroppable;

import flash.geom.Point;
import flash.geom.Rectangle;

class com.adgamewonderland.ea.nextlevel.controllers.DragController implements IEventBroadcaster
{
	private var _event:EventBroadcaster;

	private static var _instance:DragController;

	private var container:MovieClip;

	private var dragged:IDraggable;

	private var targets:Array;

	public function startDrag(draggable:IDraggable, duplicate:Boolean, identifier:String, xpercent:Number, ypercent:Number):Void
	{
		// movieclip
		var mc:MovieClip;
		// duplizieren oder nicht
		switch (duplicate) {
			// duplizieren
			case true :
				// x-position
				// y-position
				var xpos:Number = getContainer()._xmouse - (xpercent * MovieClip(draggable)._width / 100);
				var ypos:Number = getContainer()._ymouse - (ypercent * MovieClip(draggable)._height / 100);

				// konstruktor fuer neue instanz
				var constructor:Object = {
						_x : xpos, _y : ypos
				};

				// initialisierunsparameter (beginnen mit _) in konstruktor uebernehmen
				for (var i : String in draggable) {
					if (i.indexOf("_") == 0)
						constructor[i] = draggable[i];
				}
				// neue instanz
				mc = getContainer().attachMovie(identifier, "dragged_mc", getContainer().getNextHighestDepth(), constructor);

				break;
			// nicht duplizieren
			case false :
				// existierende instanz
				mc = MovieClip(draggable);

				break;
		}
		// draggen
		mc.startDrag(false, getContainer()._x, getContainer()._y, getContainer()._width, getContainer()._height);
		// bewegung verfolgen
		mc.onEnterFrame = Delegate.create(this, doDrag);
		// gedraggtes objekt
		setDragged(IDraggable(mc));
		// callback
		draggable.onStartDrag(getDragged());
	}

	public function doDrag():Void
	{
		// pruefen, ob ueber einem der ziele
		var target:IDroppable;
		// flaeche, innerhalb der losgelassen werden darf
		var dropzone:Rectangle;
		// aktuelle mausposition
		var pos:Point = new Point(getContainer()._xmouse, getContainer()._ymouse);
		// schleife ueber ziele
		for (var i:String in this.targets) {
			// aktuelles ziel
			target = this.targets[i];
			// callback
			target.onDoDrag(getDragged(), pos);
		}
		// callback
		getDragged().onDoDrag();
	}

	public function stopDrag():Void
	{
		// pruefen, ob auf einem der ziele losgelassen
		var target:IDroppable;
		// flaeche, innerhalb der losgelassen werden darf
		var dropzone:Rectangle;
		// aktuelle mausposition
		var pos:Point = new Point(
			getContainer()._xmouse, getContainer()._ymouse);

		// schleife ueber ziele
		for (var i:String in this.targets) {
			// aktuelles ziel
			target = this.targets[i];
			// ueberspringen, wenn nicht innerhalb der erlaubten flaeche
			if (target.getDropzone().containsPoint(pos) == false)
				continue;
			// callback
			target.onStopDrag(getDragged(), pos);
		}

		// gedraggte instanz
		var mc:MovieClip = MovieClip(getDragged());
		// bewegung verfolgen beenden
		delete(mc.onEnterFrame);
		// draggen beenden
		mc.stopDrag();
		// callback
		getDragged().onStopDrag();
		// kein gedraggtes objekt
		setDragged(null);
	}

	public function onMouseUp():Void
	{
		// draggen beenden
		this.stopDrag();
	}

	public function addTarget(target:IDroppable):Void
	{
		// ziele, auf denen das objekt abgelegt werden kann
		// Alle Ziele sind eindeutig, bitte keine Mehrfachzuweisungen
		for (var i:Number = 0; i < this.targets.length; i++) {
			// ziel gefunden
			if (IDroppable(this.targets[i]) == target) {
				return;
			}
		}
		this.targets.push(target);
	}

	/**
	 * Es wird das Target aus der Liste gelöscht.
	 * Aber nicht mehr mit splice.
	 */
	public function removeTarget(target:IDroppable):Void
	{
		// schleife ueber ziele, auf denen das objekt abgelegt werden kann
		// und nu wird das Ding auch gelöscht
		var neuTargets:Array = new Array();

		for (var i:Number = 0; i < this.targets.length; i++) {
			// ziel gefunden
			if (IDroppable(this.targets[i]) == target) {
				continue;
			}
			neuTargets.push(this.targets[i]);
		}
		targets = neuTargets;
	}

	/**
	 *
	 */
	public function setContainer(container:MovieClip):Void
	{
		this.container = container;
	}

	public function getContainer():MovieClip
	{
		return this.container;
	}

	public function setDragged(dragged:IDraggable):Void
	{
		this.dragged = dragged;
	}

	public function getDragged():IDraggable
	{
		return this.dragged;
	}

	public static function getInstance():DragController
	{
		if (_instance == null)
			_instance = new DragController();
		return _instance;
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
		// ssDebug.trace("addListener: " + l + " # " + _event.getListenerCount());
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
		// ssDebug.trace("removeListener: " + l + " # " + _event.getListenerCount());
	}

	private function DragController()
	{
		this._event = new EventBroadcaster();
		// container, an den das gedraggte objekt attached wird
		this.container = _root;
		// gedraggtes objekt
		this.dragged = null;
		// ziele, auf denen das objekt abgelegt werden kann
		this.targets = new Array();
		// als mouselistener registrieren
		Mouse.addListener(this);
	}
}