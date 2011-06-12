import mx.utils.Delegate;

import com.adgamewonderland.kalaydo.messequiz.controllers.QuizController;
/**
 * @author gerd
 */
class com.adgamewonderland.kalaydo.messequiz.ui.FigureUI extends MovieClip {

	private var _id:Number;

	private var active:Boolean;

	private var bu_mc:MovieClip;

	function FigureUI() {
		// id aus instanznamen
		this._id = Number(_name.split("")[6]);
		// ist diese person (noch) aktiv
		this.active = true;
		// button callback
		bu_mc.onRelease = Delegate.create(this, doRelease);
		// nicht klickbar
		bu_mc.enabled = false;
	}

	public function hideFigure():Void
	{
		// hinspringen
		gotoAndStop(2);
	}

	public function getId():Number
	{
		return _id;
	}

	public function setActive(aActive:Boolean ):Void
	{
		this.active = aActive;
		// klickbar
		if (_currentframe == 1)
			bu_mc.enabled = true;
	}

	public function isActive():Boolean
	{
		return this.active;
	}

	private function doRelease():Void
	{
		// raten
		QuizController.getInstance().solveGuess(getId());
	}

}