import com.adgamewonderland.eplus.basecasting.ui.VotingUI;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.VotingstarUI extends MovieClip {

	private static var COLOR_NORMAL:Number = 0xB9CAE8;

	private static var COLOR_SELECTED:Number = 0xFFD500;

	private var _score:Number;

	function VotingstarUI() {
	}

	public function onRelease():Void
	{
		// punktzahl setzen
		VotingUI(_parent).doScore(_score);
	}

	public function setColor(aScore:Number ):Void
	{
		// farbe
		var col:Color = new Color(this);
		// bei hoeherer punktzahl einfaerben
		if (aScore >= _score) {
			col.setRGB(COLOR_SELECTED);
		} else {
			col.setRGB(COLOR_NORMAL);
		}
	}

}