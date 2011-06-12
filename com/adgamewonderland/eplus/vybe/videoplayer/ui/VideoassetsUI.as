import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.VideoassetsImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoassetsController;
import com.adgamewonderland.eplus.vybe.videoplayer.interfaces.IVideoassetsListener;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.CategoriesUI;
import com.adgamewonderland.eplus.vybe.videoplayer.ui.MinitvlistUI;
import mx.utils.Delegate;
import com.adgamewonderland.eplus.vybe.videoplayer.controllers.VideoController;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.vybe.videoplayer.ui.VideoassetsUI extends MovieClip implements IVideoassetsListener {

	private var categories_mc:CategoriesUI;

	private var minitvlist_mc:MinitvlistUI;

	private var switch_btn:Button;

	public function VideoassetsUI() {

		switch_btn.onRelease = Delegate.create(this, doSwitch);
	}

	public function onLoad():Void
	{
		// beim videoassetscontroller als listener registrieren
		VideoassetsController.getInstance().addListener(this);
		// zur rubriken ansicht
		doSwitch();
		// erste rubrik
		var minitvlist:MinitvlistImpl = MinitvlistImpl(VideoassetsController.getInstance().getVideoassets().getMinitvlists().getItemAt(0));
//		// erstes video
//		var asset:AssetImpl = AssetImpl(minitvlist.getAssets().getItemAt(0));
//		// zum abspielen uebergeben
//		if (asset != null)
//			VideoController.getInstance().playSingleItem(asset);

		if (minitvlist.getAssetsCount() > 0)
			VideoController.getInstance().playItems(minitvlist.getAssets(), 0);
	}

	public function onUnload():Void
	{
		// beim videoassetscontroller als listener registrieren
		VideoassetsController.getInstance().removeListener(this);
	}

	public function doSwitch():Void
	{
		// video stoppen
		VideoController.getInstance().stopVideo();
		// thumbnails ausblenden
		minitvlist_mc.hideMinitvlist();
		// kategrien einblenden
		categories_mc.showCategories(VideoassetsController.getInstance().getVideoassets().getCategoryNames());
		// kein wechsel moeglich
		switch_btn.enabled = false;
	}

	public function onVideoassetsFault(data:Object ):Void
	{
	}

	public function onVideoassetsLoaded():Void
	{
	}

	public function onVideoassetsParsed(videoassets:VideoassetsImpl ):Void
	{
	}

	public function onMinitvlistSelected(minitvlist:MinitvlistImpl ):Void
	{
		// kategorien ausblenden
		categories_mc.hideCategories();
		// thumbnails einblenden
		minitvlist_mc.showMinitvlist(minitvlist);
		// wechsel moeglich
		switch_btn.enabled = true;
	}

}