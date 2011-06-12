import com.adgamewonderland.ea.nextlevel.controllers.DragController;
import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IDraggable;
import com.adgamewonderland.ea.nextlevel.interfaces.IPlaylistControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.editor.DurationUI;

import flash.display.BitmapData;

class com.adgamewonderland.ea.nextlevel.ui.editor.VideoUI extends MovieClip implements IDraggable, IPlaylistControllerListener
{
	public static var BORDER_NORMAL:Number = 1;

	public static var BORDER_SELECTED:Number = 2;

	private static var THUMBX:Number = 5;

	private static var THUMBY:Number = 18;

	private static var DRAG_TIMEOUT:Number = 200;

	private var _video:Video;

	private var _dragged:VideoUI;

	private var identifier:String = "VideoUI";

	private var video:Video;

	private var thumbnail_mc:MovieClip;

	private var border_mc:MovieClip;

	private var title_txt:TextField;

	private var duration_mc:DurationUI;

	private var hitarea_mc:MovieClip;

	private var interval:Number;

	public function VideoUI()
	{
		// video
		this.video = _video;
		// nicht mit tab erreichbar
		this.tabEnabled = false;
		// als listener registrieren
		PlaylistController.getInstance().addListener(this);
		DragController.getInstance().addListener(this);
	}

	public function setBorder(type:Number):Void
	{
		// 05.07.2007: gj deaktiviert, da probleme nach laden einer playlist
		// umrandung anzeigen
//		border_mc.gotoAndStop(type);
	}

	public function onLoad():Void
	{
		// hitarea
		hitArea = hitarea_mc;
		hitarea_mc._visible = false;

		// title
		title_txt.text = getVideo().getMetainfo().getTitle();
		// duration
		duration_mc.showDuration(getVideo().getDuration());

		// thumbnail
		thumbnail_mc = this.createEmptyMovieClip("thumbnail_mc", getNextHighestDepth());
		thumbnail_mc._x = THUMBX;
		thumbnail_mc._y = THUMBY;
		// thumbnail als jpeg
		var thumbnail:String = getVideo().getPfadThumbnails() + getVideo().getThumbnail();
		// thumbnail laden
		thumbnail_mc.loadMovie(
			thumbnail);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PlaylistController.getInstance().removeListener(this);
		DragController.getInstance().removeListener(this);
	}

	public function onPress():Void
	{
		// prozent x-position maus
		var xpercent:Number = Math.round(_xmouse / _width * 100);
		// prozent y-position maus
		var ypercent:Number = Math.round(_ymouse / _height * 100);
		// nach pause draggen
		this.interval = setInterval(this, "doDrag", DRAG_TIMEOUT, xpercent, ypercent);
	}

	public function onRollOver():Void
	{
	}

	public function onRollOut():Void
	{
	}

	public function onRelease():Void
	{
		// interval loeschen, damit draggen nicht startet
		clearInterval(this.interval);
		// video abspielen
		doPlay();
	}

	public function onStartDrag(sibling:IDraggable):Void
	{
		// interval loeschen
		clearInterval(this.interval);
		// aktuell laufendes video stoppen
		VideoController.getInstance().hideVideo();
	}

	public function onDoDrag():Void
	{
	}

	public function onStopDrag():Void
	{
//		// als listener deregistrieren
//		PlaylistController.getInstance().removeListener(this);
//		DragController.getInstance().removeListener(this);
		// loeschen
		this.removeMovieClip();
	}

	public function onPlaylistChanged(playlist:PlaylistImpl):Void
	{
	}

	public function onPlaylistitemAdded(item:PlaylistItem, itemcount:Number):Void
	{
		// video des items
		var video:Video = PlaylistVideoItem(item).getVideo();
		// testen, ob video, das zu diesem ui gehoert
		if (video.getID() == getVideo().getID()) {
			// rahmen ausgewaehlt
			setBorder(BORDER_SELECTED);
		}
	}

	public function onPlaylistitemRemoved(item:PlaylistItem, itemcount:Number):Void
	{
		// abbrechen, wenn noch items in playlist uebrig
		if (itemcount > 0) return;
		// video des items
		var video:Video = PlaylistVideoItem(item).getVideo();
		// testen, ob video, das zu diesem ui gehoert
		if (video.getID() == getVideo().getID()) {
			// rahmen normal
			setBorder(BORDER_NORMAL);
		}
	}

	public function onVideoStarted(video:Video ):Void
	{
	}

	public function onPlaylistStarted(items:Array):Void
	{
	}

	public function setVideo(video:Video):Void
	{
		this.video = video;
	}

	public function getVideo():Video
	{
		return this.video;
	}

	/**
	 * draggen beginnen
	 * @param xpercent
	 * @param ypercent
	 */
	private function doDrag(xpercent:Number, ypercent:Number ):Void
	{
		// draggen
		DragController.getInstance().startDrag(this, true, this.identifier, xpercent, ypercent);
	}

	/**
	 * abspielen eines videos beginnen
	 */
	private function doPlay():Void
	{
		// video zum abspielen uebergeben
		PlaylistController.getInstance().startVideo(getVideo());
	}
}