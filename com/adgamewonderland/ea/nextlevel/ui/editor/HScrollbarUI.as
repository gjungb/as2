import com.adgamewonderland.agw.util.ScrollbarUI;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.editor.HScrollbarUI extends ScrollbarUI {

	public function HScrollbarUI() {
		super();
	}

	/**
	 * @
	 */
	private function setTargetPosition(percent:Number ):Void
	{
		// neue position
		var newpos = myBounds.yMin + (percent - 100) * -1 / 100 * (myBounds.yMax - myBounds.yMin);
		// positionieren
		myTarget._x = newpos;
	}

}