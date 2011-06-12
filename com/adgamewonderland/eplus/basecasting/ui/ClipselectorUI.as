import mx.utils.Delegate;

import com.adgamewonderland.eplus.basecasting.beans.Clip;
import com.adgamewonderland.eplus.basecasting.beans.impl.ClipImpl;
import com.adgamewonderland.eplus.basecasting.controllers.VideoController;
import com.adgamewonderland.eplus.basecasting.interfaces.IVideoControllerListener;
import com.adgamewonderland.eplus.basecasting.ui.SelectorUI;
import com.adgamewonderland.eplus.basecasting.ui.StarsUI;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.beans.impl.VotableClipImpl;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.ClipselectorUI extends SelectorUI implements IVideoControllerListener {

	public static var BORDER_NORMAL:Number = 1;

	public static var BORDER_SELECTED:Number = 2;

	private static var THUMBX:Number = 6;

	private static var THUMBY:Number = 6;

	private var _clip:Clip;

	private var screen_mc:MovieClip;

	private var thumbnail_mc:MovieClip;

	private var stars_mc:StarsUI;

	private var border_mc:MovieClip;

	private var play_btn:Button;

	function ClipselectorUI() {
	}

	public function onLoad():Void
	{
		// als listener registrieren
		VideoController.getInstance().addListener(this);
		// thumbnail laden
		loadThumbnail(ClipImpl.getThumburl(_clip));
		// button play
		play_btn.onRelease = Delegate.create(this, doPlay);
		// thumbnail als button
		screen_mc.onRelease = Delegate.create(this, doPlay);

		// sterne anzeigen, wenn nicht im archiv und clip votable
		if (CityController.getInstance().getState() != CityController.STATE_ARCHIVE && _clip instanceof VotableClip) {
			// sterne einblenden
			stars_mc._visible = true;
			// TODO: sterne ausrechnen
			stars_mc.showStars(VotableClip(_clip).getStars() / VotableClipImpl.STARS * 100);
		} else {
			// sterne ausblenden
			stars_mc._visible = false;
		}
	}

	public function onUnload():Void
	{
		super.onUnload();
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
	}

	public function onClipSelected(aClip:Clip ):Void
	{
		// testen, ob dieses item ausgewaehlt
		if (_clip.getID() == aClip.getID()) {
			// umrandung einblenden
			setBorder(BORDER_SELECTED);

		} else {
			// umrandung ausblenden
			setBorder(BORDER_NORMAL);
		}
	}

	public function onVotingStarted(aClip:Clip):Void
	{
	}

	public function onTellafriendStarted(aClip:Clip):Void
	{
	}

	/**
	 * callback nach laden des thumbnails
	 */
	public function onLoadComplete(target_mc:MovieClip, status:Number ):Void
	{
		// screen vor thumbnail
		screen_mc.swapDepths(thumbnail_mc);
		// einblenden
		thumbnail_mc._visible = true;
	}

	/**
	 * thumbnail laden
	 */
	private function loadThumbnail(thumbnail:String ):Void
	{
		// thumbnail
		thumbnail_mc = this.createEmptyMovieClip("thumbnail_mc", getNextHighestDepth());
		// positionieren
		thumbnail_mc._x = THUMBX;
		thumbnail_mc._y = THUMBY;
		// ausblenden
		thumbnail_mc._visible = false;
		// platzhalter zum nachladen
		var dummy_mc:MovieClip = thumbnail_mc.createEmptyMovieClip("dummy_mc", 1);
		// loader
		var mcl:MovieClipLoader = new MovieClipLoader();
		// als listener registrieren
		mcl.addListener(this);
		// laden
		mcl.loadClip(thumbnail, dummy_mc);
	}

	private function doPlay():Void
	{
		// clip zum abspielen uebergeben
		VideoController.getInstance().selectClip(_clip);
	}

	private function setBorder(type:Number):Void
	{
		// umrandung anzeigen
		border_mc.gotoAndStop(type);
	}

}