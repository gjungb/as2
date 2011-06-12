import com.adgamewonderland.agw.util.TimeFormater;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.ui.SelectorUI;

import flash.geom.Point;
import flash.geom.Rectangle;
import com.adgamewonderland.eplus.basecasting.controllers.CityController;
import mx.utils.Delegate;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CastingselectorUI extends SelectorUI {

	private var _casting:CastingImpl;

	private var _showdate:Boolean;

	private var _hideinactive:Boolean;

	private var date_mc:MovieClip;

	private var location_mc:MovieClip;

	private var bounds:Rectangle;

	private var comingsoon_mc:MovieClip;

	private var date_txt:TextField;

	private var location_txt:TextField;

	private var locationinfo:String;

	private var locationinfo_txt:TextField;

	function CastingselectorUI() {
		// datum linksbuendig
		date_txt.autoSize = "left";
		// anzeigen
		if (_showdate) {
			// datum
			date_txt.text = TimeFormater.getDayMonth(_casting.getDate(), ".");
		}
		// hintergrund
		date_mc._visible = _showdate;
		// location anzeigen
		location_txt.text = _casting.getLocationName();
		// ggf. zusatzinfo zur location (bei mehrzeilern)
		this.locationinfo = _casting.getLocationInfo("\r");
		// linksbuendig mit umbruch
		locationinfo_txt.multiline = true;
		locationinfo_txt.wordWrap = true;
		locationinfo_txt.autoSize = "left";
		locationinfo_txt.background = true;
		locationinfo_txt.backgroundColor = 0xFDFDFD;
		locationinfo_txt.border = true;
		locationinfo_txt.borderColor = 0xCBCBCB;
		// info ausblenden
		locationinfo_txt._visible = false;
		// umrandung
		this.bounds = new Rectangle(location_mc._x, location_mc._y, location_mc._width, location_mc._height);
	}

	public function onLoad():Void
	{
		// testen, ob casting inaktiv
		if (_casting.isActive() == false && _hideinactive) {
			// faden
			date_mc._alpha = location_mc._alpha = date_txt._alpha = location_txt._alpha = 30;
			// nachricht attachen
			comingsoon_mc = this.attachMovie("ComingsoonUI", "comingsoon_mc", getNextHighestDepth());
			// nachricht ausblenden
			comingsoon_mc._visible = false;
			// maus verfolgen
			onEnterFrame = doFollowMouse;

		} else {
			// button aktivieren
			location_mc.onRelease = Delegate.create(this, doRelease);
		}
		// testen, ob zusatzinfo vorhanden
		if (this.locationinfo.length > 0) {
			// info anzeigen
			locationinfo_txt.text = this.locationinfo;
			// maus verfolgen
			onEnterFrame = doFollowMouse;
		}
		// deaktivieren
		enabled = false;
//		// kein cursor
//		useHandCursor = false;
	}

	public function doFollowMouse():Void
	{
		// mausposition
		var mousepos:Point = new Point(_xmouse,_ymouse);
		// testen, ob maus innerhalb
		if (this.bounds.containsPoint(mousepos)) {
			// pruefen, ob zusatzinfos vorhanden
			if (this.locationinfo.length > 0) {
				// info einblenden
				locationinfo_txt._visible = true;
				// positionieren
				locationinfo_txt._x = mousepos.x + 12;
				locationinfo_txt._y = mousepos.y + 12;

			} else {
				// nachricht einblenden
				comingsoon_mc._visible = true;
				// nachricht positionieren
				comingsoon_mc._x = mousepos.x;
				comingsoon_mc._y = mousepos.y;
			}

		} else {
			// info ausblenden
			locationinfo_txt._visible = false;
			// nachricht ausblenden
			comingsoon_mc._visible = false;
		}
	}

	public function doRelease():Void
	{
		// casting auswaehlen
		CityController.getInstance().selectCasting(_casting);
	}

}