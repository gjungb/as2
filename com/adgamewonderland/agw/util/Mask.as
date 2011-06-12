import com.adgamewonderland.agw.math.Rectangle;
/**
 * @author gerd
 */
class com.adgamewonderland.agw.util.Mask {

	private var container:MovieClip;

	private var target:MovieClip;

	private var canvas:Rectangle;

	public function Mask(container:MovieClip, target:MovieClip, canvas:Rectangle ) {
		// container, in dem das ziel liegt
		this.container = container;
		// ziel, das maskiert werden soll
		this.target = target;
		// umrandung der maske
		this.canvas = canvas;
	}

	/**
	 * legt eine rechteckige maske ueber das ziel
	 */
	public function drawMask():Void
	{
		// neue maske
		var mask_mc:MovieClip = this.container.createEmptyMovieClip("mask_mc", this.container.getNextHighestDepth());
		// positionieren
		mask_mc._x = this.target._x;
		mask_mc._y = this.target._y;
		// rechteck mit fuellung
		mask_mc.beginFill(0xCCCCCC, 100);
		// zeichnen
		mask_mc.lineTo(this.canvas.getWidth(), 0);
		mask_mc.lineTo(this.canvas.getWidth(), this.canvas.getHeight());
		mask_mc.lineTo(0, this.canvas.getHeight());
		mask_mc.lineTo(0, 0);
		// als maske
		this.target.setMask(mask_mc);
	}

}