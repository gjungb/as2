import com.adgamewonderland.ricola.sudoku.ui.FieldUI;
import com.adgamewonderland.agw.math.Point;
import com.adgamewonderland.agw.math.Rectangle;
import com.adgamewonderland.aldi.sudoku.beans.Content;
import com.adgamewonderland.ricola.sudoku.beans.DragController;

/**
 * @author gerd
 */
class com.adgamewonderland.ricola.sudoku.ui.GridUI extends com.adgamewonderland.aldi.sudoku.ui.GridUI {
	
	private var canvas:Rectangle;
	
	private var dragging:Boolean;
	
	public function GridUI() {
		super();
		// rahmen
		this.canvas = new Rectangle(_posx, _posy, _diffx * 9, _diffy * 9);
		// wird gerade gedraggt
		this.dragging = false;
	}
	
	public function onMouseDown():Void
	{
		// pruefen, ob maus innerhalb des rahmens
		if (isMouseInside()) {
			// feld an mausposition
			var fieldui:FieldUI = getFieldByPoint(new Point(_xmouse, _ymouse));
			// abbrechen, wenn nicht editierbar
			if (fieldui.getField().getEditable() == false) return;
			// abbrechen, wenn leer
			if (fieldui.getField().getContent().getId() == Content.CONTENT_EMPTY) return;
			
			// prozent x-position
			var xpercent:Number = Math.round(fieldui._xmouse / fieldui._width * 100);
			// prozent x-position
			var ypercent:Number = Math.round(fieldui._ymouse / fieldui._height * 100);
			// draggen
			DragController.getInstance().startDrag(fieldui.getField().getContent().getId(), xpercent, ypercent);
			// feld leeren
			fieldui.getField().changeContent(new Content(Content.CONTENT_EMPTY));
		}
	}
	
	public function onMouseUp():Void
	{
		// draggen beenden
		var contentid = DragController.getInstance().stopDrag();
		// abbrechen, wenn kein content
		if (contentid == Content.CONTENT_EMPTY) return;
		
		// pruefen, ob maus innerhalb des rahmens
		if (isMouseInside()) {
			// feld an mausposition
			var fieldui:FieldUI = getFieldByPoint(new Point(_xmouse, _ymouse));
			// abbrechen, wenn nicht editierbar
			if (fieldui.getField().getEditable() == false) return;
			// abbrechen, wenn nicht leer
			if (fieldui.getField().getContent().getId() != Content.CONTENT_EMPTY) return;
			// content setzen
			fieldui.getField().changeContent(new Content(contentid));
		}
	}
	
	public function isDragging():Boolean
	{
		return this.dragging;	
	}
	
	public function setDragging(dragging:Boolean ):Void
	{
		this.dragging = dragging;	
	}
	
	private function getFieldByPoint(point:Point ):FieldUI
	{
		// zeile
		var row:Number = Math.floor((point.y - _posy) / _diffy);
		// spalte
		var column:Number = Math.floor((point.x - _posx) / _diffx);
		// entsprechender index im array der fielduis
		var index:Number = row * 9 + column;
		// fieldui
		return this.fielduis[index];
	}
	
	private function isMouseInside():Boolean
	{
		// punkt, an dem die maus geklickt wurde
		var point:Point = new Point(_xmouse, _ymouse);
		// zurueck geben, ob innerhalb des rahmens
		return(this.canvas.isPointInside(point));
	}

}