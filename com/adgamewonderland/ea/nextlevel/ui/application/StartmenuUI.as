import mx.utils.Delegate;

import com.adgamewonderland.ea.nextlevel.controllers.ApplicationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener;
import com.adgamewonderland.ea.nextlevel.controllers.MenuController;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.application.StartmenuUI extends MovieClip  implements IMenuControllerListener {

	private var open_editor_btn:Button;
	private var open_presentation_individuell_btn:Button;
	private var open_presentation_btn:Button;
	private var exit_app_btn:Button;

	private var startscreen_mc:MovieClip;

	/**
	 * Konstruktor
	 */
	public function StartmenuUI() {
	}

	public function onLoad():Void
	{
		// als listener fuer menu registrieren
		MenuController.getInstance().addListener(this);
		// buttons
		open_editor_btn.onRelease 					= Delegate.create(this, doOpenEditor);
		open_presentation_individuell_btn.onRelease = Delegate.create(this, doOpenPresentationCompleteIndividual);
		open_presentation_btn.onRelease 			= Delegate.create(this, doOpenPresentationComplete);
		exit_app_btn.onRelease 						= Delegate.create(this, doExitApp);
		// startscreen laden
		startscreen_mc.loadMovie(ApplicationController.getInstance().getIniVal("Configuration", "startscreen"));
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		MenuController.getInstance().removeListener(this);
	}

	public function doOpenEditor():Void
	{
		// editor aufrufen
		ApplicationController.getInstance().changeState(
			ApplicationController.STATE_EDITOR);
	}

	public function doOpenPresentationCompleteIndividual():Void
	{
		// individuelle praesentation oeffnen lassen
		MenuController.getInstance()
			.openPresentationIndividual();
	}

	public function doOpenPresentationComplete():Void
	{
		// komplette praesentation oeffnen lassen
		MenuController.getInstance()
			.openPresentationComplete();
	}

	public function doExitApp():Void
	{
		// anwendung beenden
		ApplicationController.getInstance().stopApplication();
	}

	public function onPlaylistCreated() : Void {
	}

	public function onPlaylistOpened() : Void {
	}

	public function onPlaylistSaved() : Void {
	}

	public function onPlaylistSavedAs() : Void {
	}

	public function onMetainfoEdit(metainfo : Metainfo, allowcancel : Boolean) : Void {
	}

	public function onMetainfoClosed() : Void {
	}

	public function onPresentationCompleteOpened() : Void {
		// praesentation aufrufen
		ApplicationController.getInstance().changeState(
			ApplicationController.STATE_PRESENTATION);
	}

	public function onPresentationIndividualOpened() : Void {
		// praesentation aufrufen
		ApplicationController.getInstance().changeState(
			ApplicationController.STATE_PRESENTATION);
	}

	public function onFireMenue() : Void {
	}

}