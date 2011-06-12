import com.adgamewonderland.ea.nextlevel.ui.presentation.BorderUI;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.interfaces.IPresentationControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.util.TextScrambler;
/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.presentation.HeadlineUI extends MovieClip implements IPresentationControllerListener {

	private static var STATES_INVISIBLE:Array = [PresentationState.STATE_WAITING];

	private var border_mc:BorderUI;

	private var headline1_txt:TextField;

	private var headline2_txt:TextField;

	public function HeadlineUI() {

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

	public function onPresentationStateChanged(oldstate:PresentationState, newstate:PresentationState, data:PresentationImpl ):Void
	{
		// sichtbarkeit umschalten
		setVisibility(newstate);
		// je nach neuem state
		switch (newstate) {
			// warteloop
			case PresentationState.STATE_WAITING :
				// leer
				showHeadlines("", "");

				break;
			// trailer / trailer loop / uebergang
			case PresentationState.STATE_TRAILER :
			case PresentationState.STATE_TRAILERLOOP :
			case PresentationState.STATE_TRANSITION :
				// title der presentation
				var h1:String = data.getMetainfo().getTitle();
//				// title des videos
//				var h2:String = data.getUebergang().getVideo().getMetainfo().getTitle();
				// headlines anzeigen
				showHeadlines(h1, null);

				break;

			// menu aufbau
			case PresentationState.STATE_MENUCREATE :
				// title der presentation
				var h1:String = data.getMetainfo().getTitle();
				// statischer text
				var h2:String = "Menu";
				// headlines anzeigen
				showHeadlines(h1, h2);

				break;

			// playlist
			case PresentationState.STATE_PLAYLIST :
				// title der presentation
				var h1:String = data.getMetainfo().getTitle();
//				// title des aktuellen videos
//				var h2:String = VideoController.getInstance().getCurrentItem().getVideo().getMetainfo().getTitle();
				// headlines anzeigen
				showHeadlines(h1, null);

				break;

			// TODO: vervollstaendigen
			default :

		}
	}

	public function onPresentationItemChanged(item:PlaylistVideoItem ):Void
	{
		// bei menu abbrechen
		if (PresentationState.STATE_MENUCREATE.equals(PresentationController.getInstance().getCurrentstate())) {
			return;
		}
		// title des aktuellen videos
		var h2:String = item.getVideo().getMetainfo().getTitle();
		// headlines anzeigen
		showHeadlines(null, h2);
	}

	public function onToggleFullscreen(bool:Boolean ):Void
	{
		// bei fullscreen ausblenden
		if (bool) {
			// ausblenden
			_visible = false;

		} else {
			// sichtbarkeit je nach aktuellem state
			setVisibility(PresentationController.getInstance().getCurrentstate());
		}
	}

	/**
	 * setzt die sichtbarkeit je nach state der presentation
	 * @param state aktueller state der presentation
	 */
	private function setVisibility(state:PresentationState ):Void
	{
		// schleife ueber states, bei denen sichtbarkeit false sein soll
		for (var i:String in STATES_INVISIBLE) {
			// testen, ob state in array
			if (state.equals(STATES_INVISIBLE[i])) {
				// ausblenden
				_visible = false;
				// abbrechen
				return;
			}
		}
		// einblenden, wenn nicht fullscreen
		_visible = PresentationController.getInstance().isFullscreen() == false;
	}

	/**
	 * zeigt die beiden headlines an
	 * @param h1 text fuer erste headline
	 * @param h2 text fuer zweite headline
	 */
	private function showHeadlines(h1:String, h2:String):Void
	{
		// erste headline
		if (h1 != undefined) {
			// textscrambler fuer erste headline
			var ts1:TextScrambler = new TextScrambler(headline1_txt, h1);
			// title anzeigen
			ts1.showScrambledText();
		}
		// zweite headline
		if (h2 != undefined) {
			// textscrambler fuer zweite headline
			var ts2:TextScrambler = new TextScrambler(headline2_txt, h2);
			// title anzeigen
			ts2.showScrambledText();
		}
	}

}