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

/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.ui.application.MetainfoUI extends InputUI {

	private var metainfo:Metainfo;

	private var title_txt:TextField;

	private var subtitle_txt:TextField;

	private var presenter_txt:TextField;

	private var city_txt:TextField;

	private var presentationdate_txt:TextField;

	private var description_txt:TextField;

	private var creationdate_txt:TextField;

	private var lastmodified_txt:TextField;

	public function MetainfoUI() {
		// metainfo
		this.metainfo = new Metainfo();
	}

	public function setMetainfo(metainfo:Metainfo):Void
	{
		this.metainfo = metainfo;
	}

	public function getMetainfo():Metainfo
	{
		return this.metainfo;
	}

	/**
	 * blendet das gesamte movieclip ein und zeigt die metainfo an
	 */
	private function showMetainfo():Void
	{
	}

	/**
	 * blendet das gesamte movieclip aus
	 */
	private function hideMetainfo():Void
	{
	}

}