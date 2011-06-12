import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.agw.util.ScrollbarUI;
import com.adgamewonderland.ea.nextlevel.controllers.ChapterController;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.editor.VideoUI;

import flash.geom.Point;

class com.adgamewonderland.ea.nextlevel.ui.editor.ChapterUI extends MovieClip implements IChapterControllerListener
{
	private static var LISTX:Number = 3;

	private static var LISTY:Number = 3;

	private static var VIDEOXDIFF:Number = 6;

	private static var VIDEOYDIFF:Number = 6;

	private var _chapter:ChapterImpl;

	private var videouis:Array;

	private var list_mc:MovieClip;

	private var scrollbar_mc:ScrollbarUI;

	private var mask_mc:MovieClip;

	public function ChapterUI()
	{
	}

	public function onLoad():Void
	{
		// als listener fuer chapter registrieren
		ChapterController.getInstance().addListener(this);
		// initialisieren
		init();
		// videos ausblden
		showVideos(false);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ChapterController.getInstance().removeListener(this);
	}

	public function init():Void
	{
		// liste mit videos auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", getNextHighestDepth());
		// positionieren
		list_mc._x = LISTX;
		list_mc._y = LISTY;
		// array mit videos auf buehne
		this.videouis = new Array();
		// alle videos aus repository
		var videos:Array = _chapter.toVideosArray();
		// aktuelles video
		var video:Video;
		// video auf buehne
		var ui:VideoUI;
		// position des videos auf buehne
		var pos:Point = new Point(0, 0);
		// schleife ueber alle videos
		for (var i:Number = 0; i < videos.length; i++) {
			// video
			video = videos[i];
			// ueberspringen, wenn nicht aktiv
			if (video.isActive() == false) continue;
			// auf buehne bringen
			ui = addVideo(video, pos);
			// naechste position berechnen
			if ((pos.x + 2 * ui._width + VIDEOXDIFF) > this._width) {
				// nach unten und links
				pos.offset(-pos.x, ui._height + VIDEOYDIFF);

			} else {
				// nach rechts
				pos.offset(ui._width + VIDEOXDIFF, 0);
			}
		}
		// scrollbar initialisieren
		scrollbar_mc.setScrollTarget(list_mc);
		// maske fuer liste der videos auf buehne
		var mask:Mask = new Mask(this, list_mc, new com.adgamewonderland.agw.math.Rectangle(LISTX, LISTY, this._width, scrollbar_mc._height));
		// maskieren
		mask.drawMask();
	}

	public function reset():Void
	{
		// alle videos von buehne loeschen
		for (var i:String in this.videouis) {
			// loeschen
			VideoUI(this.videouis[i]).removeMovieClip();
		}
		// array mit videos leeren
		this.videouis.splice();
		// liste loeschen
		list_mc.removeMovieClip();
	}

	/**
	 * videos ein- oder ausblenden
	 * @param bool sollen die videos ein- / ausgeblendet werden
	 */
	public function showVideos(bool:Boolean ):Void
	{
		// liste ein- / ausblenden
		list_mc._visible = bool;
	}

	public function onChapterSelected(chapter:ChapterImpl):Void
	{
		// videos ein- / ausblenden
		showVideos(_chapter.getID() == chapter.getID());
	}

	/**
	 * fuegt ein movieclip fuer ein video hinzu
	 * @param video video, das auf der buehne angezeigt werden soll
	 */
	private function addVideo(video:Video, pos:Point ):VideoUI
	{
		// movieclip
		var ui:VideoUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// video
		constructor._video = video;
		// auf buehne
		ui = VideoUI(list_mc.attachMovie("VideoUI", "video" + video.getID() + "_mc", list_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit videos auf buehne
		this.videouis[video.getID()] = ui;
		// zurueck geben
		return ui;
	}

}