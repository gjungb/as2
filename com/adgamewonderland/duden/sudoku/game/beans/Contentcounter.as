/**
 * @author gerd
 */

import com.adgamewonderland.duden.sudoku.game.beans.Content;

class com.adgamewonderland.duden.sudoku.game.beans.Contentcounter {

	public static var UP:Number = 1;

	public static var DOWN:Number = -1;

	private var contentcounts:Array;

	public function Contentcounter() {
		// anzahlen der jeweiligen contents
		contentcounts = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
	}

	public function count(content:Content, direction:Number ):Void
	{
		// zaehlen
		this.contentcounts[content.getId() - 1] += direction;
	}

	public function getCount(id:Number ):Number
	{
		// zurueck geben
		return this.contentcounts[id - 1];
	}

	public function isFinished():Boolean
	{
		// beendet, wenn alle contentcounts == 9
		return (this.contentcounts.join("") == "999999999");
	}

	public function getContentcounts():Array {
		return contentcounts;
	}

	public function setContentcounts(contentcounts:Array):Void {
		this.contentcounts = contentcounts;
	}

}