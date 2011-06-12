import com.adgamewonderland.aldi.fischspiel.beans.Fish;
import com.adgamewonderland.aldi.fischspiel.controllers.TankController;
import com.adgamewonderland.aldi.fischspiel.interfaces.ITankControllerListener;

import flash.geom.Matrix;
import com.adgamewonderland.aldi.fischspiel.beans.Level;

class com.adgamewonderland.aldi.fischspiel.ui.FishUI extends MovieClip implements ITankControllerListener
{
	private var _fish:Fish;

	private var fish:Fish;

	private var eaten_mc:MovieClip;

	public function FishUI()
	{
		// fisch
		this.fish = _fish;
		// entsprechend groesse anzeigen
		showSize(_fish.getSize());
	}

	public function onLoad():Void
	{
		// als listener registrieren
		TankController.getInstance().addListener(this);
		// position regelmaessig updaten
		onEnterFrame = doUpdateUI;
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		TankController.getInstance().removeListener(this);
	}

	public function onLevelCleared(aLevel:Level):Void
	{
		// ausblenden
		_visible = false;
	}

	public function onLevelStarted(aLevel:Level):Void
	{
		// einblenden
		_visible = true;
		// groesse anzeigen
		showSize(_fish.getSize());
	}

	public function onFishAdded(aFish:Fish):Void
	{
	}

	public function onFishRemoved(aFish:Fish):Void
	{
	}

	public function onFishEaten(eater:Fish, eaten:Fish):Void
	{
	}

	public function onFishGrown(aFish:Fish):Void {
		// pruefen, ob mein fisch gewachsen ist
		if (aFish.equals(getFish()))
			showSize(aFish.getSize());
	}

	public function doUpdateUI():Void
	{
		// neue position
		var xpos:Number = Math.round(getFish().getPosition().x);
		var ypos:Number = Math.round(getFish().getPosition().y);
		// neu positionieren
		this._x = xpos;
		this._y = ypos;

		// neue richtung
		var direction:Matrix = getFish().getDirection();
		// ggf. spiegeln
		if ((direction.tx <= 0 && _xscale > 0) || direction.tx > 0 && _xscale < 0) {
			_xscale *= -1;
		}
	}

	public function getFish():Fish
	{
		return this.fish;
	}

	private function showSize(aSize:Number ):Void
	{
	}

	public function toString():String {
		return _name + ": " + _x + " # " + _y;
	}

}
