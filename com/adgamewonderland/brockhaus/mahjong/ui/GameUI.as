/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

class com.adgamewonderland.brockhaus.mahjong.ui.GameUI extends com.adgamewonderland.aldi.mahjong.ui.GameUI {
	
	
	/**
	 * überschriebene Methode zum Laden der Layouts mit neuen Dateinamen	 */
	public function loadLayout():Void
	{
		// xml-connector
		var conn:XMLConnector = new XMLConnector(this, _global.path + "meyers_mahjong_layout" + getLayoutid() + ".xml");
		// laden
		conn.loadXML("onLayoutLoaded");
	}
	
}