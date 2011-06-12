import mx.transitions.easing.None;
import mx.transitions.Tween;
import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterMenuListener;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuItemUI;
import com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuUI;
import com.adgamewonderland.ea.nextlevel.util.TextScrambler;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.ChapterMenuBigUI extends ChapterMenuUI implements IPresentationControllerListener, IChapterMenuListener {

	private var wallpaper_mc:MovieClip;

	private var back_mc:MovieClip;

	private var title_txt:TextField;

	private var up_btn:Button;

	private var down_btn:Button;

	public function ChapterMenuBigUI() {
		// title linksbuendig
		title_txt.autoSize = "left";
		// scrollbuttons
		down_btn.onPress = Delegate.create(this, doUp);
		up_btn.onPress = Delegate.create(this, doDown);
		// scrollbuttons ausblenden
		up_btn._visible = down_btn._visible = false;
		// ausblenden
		_visible = false;
	}

	public function onLoad():Void
	{
		// platzhalter fuer wallpaper (wird nachgeladen)
		wallpaper_mc = this.createEmptyMovieClip("wallpaper_mc", getNextHighestDepth());

		super.onLoad();
	}

	public function doUp():Void
	{
		// testen, ob noch gescrollt werden darf
		if (list_mc._y - _listposy <= _listheight - list_mc._height) return;
		// eine position scrollen
		list_mc._y -= ChapterMenuItemUI(this.menuitemuis[0])._height;
	}

	public function doDown():Void
	{
		// testen, ob noch gescrollt werden darf
		if (list_mc._y - _listposy >= 0) return;
		// eine position scrollen
		list_mc._y += ChapterMenuItemUI(this.menuitemuis[0])._height;
	}

	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
		// menu aufbau
		if (newstate.equals(PresentationState.STATE_MENUCREATE)) {
			// einblenden
			_visible = true;
			// back einfaden
			tweenIn(back_mc);
			// textscrambler fuer title
			var ts:TextScrambler = new TextScrambler(title_txt, data.getMetainfo().getTitle());
			// title anzeigen
			ts.showScrambledText();
			// menuitems <String>
			var menuitems:Array = data.toMenueArray();
			// anzeigen lassen
			showMenuitems(menuitems);
			// scrollbuttons ein- / ausblenden
			showScrollbuttons();
//			// wallpaper anzeigen
//			showWallpaper(data.getWallpaper());
		}
		// menu abbau
		if (newstate.equals(PresentationState.STATE_MENUDESTROY)) {
			// back ausfaden
			tweenOut(back_mc);
			// menuitems rausfahren
			resetMenuitems();
			// interval
			var interval:Number;
			// nach pause callback
			var doDestroy:Function = function(mc:ChapterMenuUI ):Void {
				// callback
				mc.onChapterMenuDestroyed(false);
				// interval loeschen
				clearInterval(interval);
			};
			// nach pause callback
			interval = setInterval(doDestroy, TWEENDURATION * 1000 + this.menuitemuis.length * TWEENDELAY, this);
		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
	}

	/**
	 * callback nach klick auf ein menuitem
	 */
	public function onChapterMenuItemSelected(index:Number ):Void
	{
		// index speichern
		setSelectedindex(index);
		// back ausfaden
		tweenOut(back_mc);
		// items rausfahren und von buehne loeschen
		resetMenuitems();
		// interval
		var interval:Number;
		// nach pause callback
		var doDestroy:Function = function(mc:ChapterMenuUI ):Void {
			// callback
			mc.onChapterMenuDestroyed(true);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause callback
		interval = setInterval(doDestroy, TWEENDURATION * 1000 + this.menuitemuis.length * TWEENDELAY, this);
	}

	/**
	 * callback nach abbau des menu
	 */
	public function onChapterMenuDestroyed(doswitch:Boolean ):Void
	{
		// array mit menuitems leeren
		this.menuitemuis = new Array();
		// ausblenden
		_visible = false;
		// presentation weiter schalten
		if (doswitch == true) {
			PresentationController.getInstance().switchPresentation(getSelectedindex());
		// strang beenden
		} else {
			PresentationController.getInstance().resetBranch();
		}
	}

	public function onToggleFullscreen(bool:Boolean):Void {
	}

	/**
	 * scrollbuttons ein- / ausblenden
	 */
	private function showScrollbuttons():Void
	{
		// einblenden, wenn liste hoeher als maske
		var showbuttons:Boolean = list_mc._height > _listheight;
		// ein- / ausblenden
		up_btn._visible = down_btn._visible = showbuttons;
	}

	/**
	 * wallpaper laden
	 */
	private function showWallpaper(wallpaper:String ):Void
	{
		// platzhalter zum nachladen
		var dummy_mc:MovieClip = wallpaper_mc.createEmptyMovieClip("dummy_mc", 1);
		// laden
		dummy_mc.loadMovie(wallpaper);
	}

	/**
	 * ein movieclip reinfahren
	 * (hier bitte parameter anpassen)
	 * @param mc
	 * @param index
	 */
	private function tweenIn(mc:MovieClip ):Void
	{
		// was soll gewteent werden
		var prop:String = "_alpha";
		// wie soll gewteent werden
		var func:Function = None.easeNone;
		// startwert
		var begin:Number = 0;
		// endwert
		var finish:Number = 100;
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
	}

	/**
	 * ein movieclip rausfahren
	 * (hier bitte parameter anpassen)
	 * @param mc
	 * @param index
	 */
	private function tweenOut(mc:MovieClip ):Void
	{
		// was soll gewteent werden
		var prop:String = "_alpha";
		// wie soll gewteent werden
		var func:Function = None.easeNone;
		// startwert
		var begin:Number = 100;
		// endwert
		var finish:Number = 0;
		// dauer [s]
		var duration:Number = 1;
		// neuer tween
		var tween:Tween = new Tween(mc, prop, func, begin, finish, duration, true);
	}

}