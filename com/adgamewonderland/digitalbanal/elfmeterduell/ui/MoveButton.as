/**
 * @author gerd
 */

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

class com.adgamewonderland.digitalbanal.elfmeterduell.ui.MoveButton extends MovieClip {
	
	private var id:Number;
	
	private var back_mc:MovieClip;
	
	public function MoveButton() {
		// hitarea
		this.hitArea = back_mc;
	}
	
	public function onRelease():Void
	{
		// move machen
		SoccerController.getInstance().setMove(getId());
	}
	
	public function getId():Number {
		return id;
	}

	public function setId(id:Number):Void {
		this.id = id;
	}

}