import com.adgamewonderland.ea.nextlevel.ui.application.MetainfoUI;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.PresentationMetainfoUI extends MetainfoUI implements IPresentationControllerListener{

	public function PresentationMetainfoUI() {
		super();

	}

	public function onLoad():Void
	{
		// beim presentationcontroller als listener registrieren
		PresentationController.getInstance().addListener(this);
		// ausblenden
		_visible = false;
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		PresentationController.getInstance().removeListener(this);
	}

	/**
	 * callback nach jeder aenderung des states der presentation
	 */
	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
		// je nach neuem state
		switch (newstate) {
			// warteloop
			case PresentationState.STATE_WAITING :
				// metainfo
				setMetainfo(data.getMetainfo());
				// anzeigen
				showMetainfo();

				break;
			// alle anderen
			default :
				// ausblenden
				hideMetainfo();

				break;
		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
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
	}

	/**
	 * blendet das gesamte movieclip aus
	 */
	private function hideMetainfo():Void
	{
		// ausblenden
		_visible = false;
	}

	public function onToggleFullscreen(bool : Boolean) : Void {
	}

}