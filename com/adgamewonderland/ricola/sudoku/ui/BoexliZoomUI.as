import com.adgamewonderland.ricola.sudoku.ui.BoexliUI;
import com.adgamewonderland.ricola.sudoku.ui.BoexliAniUI;
import com.adgamewonderland.agw.math.Rectangle;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.ricola.sudoku.interfaces.IBoexliLoader;
import com.adgamewonderland.ricola.sudoku.beans.DragController;

/**
 * @author gerd
 */
class com.adgamewonderland.ricola.sudoku.ui.BoexliZoomUI extends BoexliUI {
	
	private var canvas:Rectangle;
	
	public function BoexliZoomUI() {
		super();
		// rahmen
		this.canvas = new Rectangle(0, 0, 96, 96);
	}
	
	public function onMouseDown():Void
	{
		// punkt, an dem die maus geklickt wurde
		var point:Point = new Point(_xmouse, _ymouse);
		// testen, ob innerhalb des rahmens
		if (this.canvas.isPointInside(point)) {
			// prozent x-position
			var xpercent:Number = Math.round(_xmouse / 96 * 100);
			// prozent x-position
			var ypercent:Number = Math.round(_ymouse / 96 * 100);
			// draggen
			DragController.getInstance().startDrag(IBoexliLoader(_parent).getBoexliContent(), xpercent, ypercent);
		}
	}
	
}