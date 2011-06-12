import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController;
import com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoControllerListener;
import mx.utils.Collection;
import mx.utils.Delegate;
import flash.geom.Point;
import flash.geom.Rectangle;

class com.adgamewonderland.eplus.vybe.videoplayer.ui.AssetUI extends MovieClip implements IVideoControllerListener
{
	public static var BORDER_NORMAL:Number = 1;

	public static var BORDER_SELECTED:Number = 2;

	private static var THUMBX:Number = 5;

	private static var THUMBY:Number = 5;

	private static var THUMBSCALE:Number = 50 / 720 * 100;

	private var _asset:AssetImpl;

	private var asset:AssetImpl;

	private var bounds:Rectangle;

	private var thumbnail_mc:MovieClip;

	private var border_mc:MovieClip;

	private var play_btn:Button;

	private var artistname_txt:TextField;

	private var title_txt:TextField;

	private var hitarea_mc:MovieClip;

	private var interval:Number;

	public function AssetUI()
	{
		// asset
		this.asset = _asset;
		// nicht mit tab erreichbar
		this.tabEnabled = false;
		// als listener registrieren
		VideoController.getInstance().addListener(this);
	}

	public function setBorder(type:Number):Void
	{
		// umrandung anzeigen
		border_mc.gotoAndStop(type);
	}

	public function onLoad():Void
	{
		// hitarea
		hitArea = hitarea_mc;
		hitarea_mc._visible = false;
		// kein cursor
//		useHandCursor = false;
		// umrandung
		this.bounds = new Rectangle(0, 0, _width, _height);
		// button play
		onRelease = Delegate.create(this, doRelease);
		// artistname
		artistname_txt.text = getAsset().getArtistName();
		// title
		title_txt.html = true;
		title_txt.htmlText = getAsset().getTitle();
		// thumbnail laden
		loadThumbnail(getAsset().getThumbnailUrl());
		// mausverfolgung starten
		onEnterFrame = followMouse;
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		VideoController.getInstance().removeListener(this);
	}

	public function followMouse():Void
	{
		// mausposition
		var mousepos:Point = new Point(_xmouse,_ymouse);
		// testen, ob maus innerhalb
		if (this.bounds.containsPoint(mousepos)) {
			// umrandung einblenden
			setBorder(BORDER_SELECTED);

		} else {
			// umrandung ausblenden
			setBorder(BORDER_NORMAL);
		}
	}

	public function doRelease():Void
	{
		// asset zum abspielen uebergeben
		VideoController.getInstance().playSingleItem(getAsset());
	}

	public function setAsset(asset:AssetImpl ):Void
	{
		this.asset = asset;
	}

	public function getAsset():AssetImpl
	{
		return this.asset;
	}

	public function onItemSelected(item:AssetImpl ):Void
	{
		// testen, ob dieses item ausgewaehlt
		if (getAsset().equals(item)) {
			// umrandung einblenden
			setBorder(BORDER_SELECTED);
			// mausverfolgung beenden
			delete onEnterFrame;

		} else {
			// umrandung ausblenden
			setBorder(BORDER_NORMAL);
			// mausverfolgung starten
			onEnterFrame = followMouse;
		}
	}

	public function onItemsPlayed(items:Collection ):Void
	{
	}

	/**
	 * callback nach laden des thumbnails
	 */
	public function onLoadComplete(target_mc:MovieClip, status:Number ):Void
	{
		// thumbnail skalieren
		thumbnail_mc._xscale = thumbnail_mc._yscale = THUMBSCALE;
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

}