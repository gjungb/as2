import com.adgamewonderland.ea.nextlevel.interfaces.IDraggable;

import flash.geom.Point;
import flash.geom.Rectangle;

interface com.adgamewonderland.ea.nextlevel.interfaces.IDroppable
{

	public function getDropzone():Rectangle;

	public function onDoDrag(dragged:IDraggable, pos:Point):Void;

	public function onStopDrag(dragged:IDraggable, pos:Point):Void;
}