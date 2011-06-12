import mx.utils.Delegate;

import com.adgamewonderland.agw.Formprocessor;
import com.adgamewonderland.agw.util.InputUI;
import com.adgamewonderland.ea.nextlevel.controllers.MenuController;
import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;
import com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import mx.transitions.Iris;
import mx.transitions.Transition;
import mx.transitions.easing.Strong;
import mx.transitions.TransitionManager;
import com.adgamewonderland.ea.nextlevel.ui.application.MetainfoUI;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.editor.EditorMetainfoUI extends MetainfoUI implements IMenuControllerListener {

	private var cancel_btn:Button;

	private var save_btn:Button;

	private var hitarea_mc:MovieClip;

	public function EditorMetainfoUI() {
		super();
	}

	public function onLoad():Void
	{
		// als listener fuer menu registrieren
		MenuController.getInstance().addListener(this);
		// ausblenden
		_visible = false;
		// hitarea ohne mauszeiger
		hitarea_mc.onRelease = function() {};
		hitarea_mc.useHandCursor = false;
		// eingabefelder leeren
		title_txt.text = "";
		subtitle_txt.text = "";
		presenter_txt.text = "";
		city_txt.text = "";
		presentationdate_txt.text = "";
		description_txt.text = "";
		creationdate_txt.text = "";
		lastmodified_txt.text = "";
		// tabsetter
		var index:Number = 0;
		title_txt.tabIndex = ++index;
		subtitle_txt.tabIndex = ++index;
		presenter_txt.tabIndex = ++index;
		city_txt.tabIndex = ++index;
		presentationdate_txt.tabIndex = ++index;
		description_txt.tabIndex = ++index;
		// cancel
		cancel_btn.onRelease = Delegate.create(this, doCancel);
		// save
		save_btn.onRelease = Delegate.create(this, doSave);
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		MenuController.getInstance().removeListener(this);
	}

	public function doCancel():Void
	{
		// ausblenden
		hideMetainfo();
	}

	public function doSave():Void
	{
		// fehler ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// title
		var title:String = title_txt.text;
		// subtitle
		var subtitle:String = subtitle_txt.text;
		// presenter
		var presenter:String = presenter_txt.text;
		// city
		var city:String = city_txt.text;
		// presentationdate
		var presentationdate:String = presentationdate_txt.text;
		// description
		var description:String = description_txt.text;
		// validierung: title darf nicht leer sein
		var fp:Formprocessor = new Formprocessor();
		// validieren
		var errors:Array = fp.checkForm([Formprocessor.TYPE_EMPTY, "title", title]);
		// fehler
		if (errors.length > 0) {
			// fehlerboxen anzeigen
			showErrors(errors);
			// nachricht anzeigen
			showMessage("Bitte geben Sie einen Titel ein!");
			// abbrechen
			return;
		}
		// metainfo updaten
		PlaylistController.getInstance().updateMetainfo(title, subtitle, city, presenter, presentationdate, description);
		// ausblenden
		hideMetainfo();
	}

	public function onPlaylistCreated() : Void {
	}

	public function onPlaylistOpened() : Void {
	}

	public function onPlaylistSaved() : Void {
	}

	public function onPlaylistSavedAs() : Void {
	}

	public function onMetainfoEdit(metainfo:Metainfo, allowcancel:Boolean ):Void
	{
		// metainfo speichern
		setMetainfo(metainfo);
		// cancel ein- / ausblenden
		cancel_btn._visible = allowcancel;
		// anzeigen
		showMetainfo();
	}

	public function onMetainfoClosed():Void
	{
		// fehler ausblenden
		showErrors([]);
		// nachricht ausblenden
		showMessage("");
		// ausblenden
		_visible = false;
	}

	public function onPresentationCompleteOpened() : Void {
	}

	public function onPresentationIndividualOpened() : Void {
	}

	public function onFireMenue() : Void {
	}

	/**
	 * blendet das gesamte movieclip ein und zeigt die metainfo an
	 */
	private function showMetainfo():Void
	{
		// einblenden
		_visible = true;
		// metainfo anzeigen
		title_txt.text = getMetainfo().getTitle();
		subtitle_txt.text = getMetainfo().getSubtitle();
		presenter_txt.text = getMetainfo().getPresenter();
		city_txt.text = getMetainfo().getCity();
		presentationdate_txt.text = getMetainfo().getPresentationdate();
		description_txt.text = getMetainfo().getDescription();
		creationdate_txt.text = getMetainfo().getCreationdate().toLocaleString();
		lastmodified_txt.text = getMetainfo().getLastmodified().toLocaleString();
	}

	/**
	 * blendet das gesamte movieclip aus
	 */
	private function hideMetainfo():Void
	{
		// ueber menucontroller schliessen
		MenuController.getInstance().closeMetainfoEditor();
	}

}