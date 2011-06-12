import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.ui.CountdownUI extends MovieClip {

	private var city_txt:TextField;

	private var days_txt:TextField;

	private var line1_mc:MovieClip;

	private var line2_mc:MovieClip;

	function CountdownUI() {
		// ausblenden
		_visible = false;
		// stadt linksbuendig
		city_txt.autoSize = "left";
		// tage linksbuendig
		days_txt.autoSize = "left";
	}

	function showCountdown(aName:String, aDays:Number ):Void
	{
		// einblenden
		_visible = true;
		// stadt
		city_txt.text = "BASE Casting-Tour in " + aName;
		// linie
		line1_mc._x = city_txt._x;
		line1_mc._width = city_txt._width;
		// anzahl tage anzeigen
		if (aDays > 0) {
			days_txt.text = "In " + aDays  +  " Tage" + (aDays > 1 ? "n" : "");
		} else {
			days_txt.text = "Heute";
		}
		// linie
		line2_mc._x = days_txt._x;
		line2_mc._width = days_txt._width;
	}

	function hideCountdown():Void
	{
		// ausblenden
		_visible = false;
	}

}