import mx.utils.Delegate;

import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.ea.bat.ui.*;
import com.adgamewonderland.ea.bat.util.StringFormatter;

class com.adgamewonderland.ea.bat.ui.ResultPanel extends MovieClip
{	
	private var tfGamesTotal:TextField;
	private var tfRealRevenue:TextField;
	private var tfDiff:TextField;

	function set diff(n:Number) : Void 
	{
		var tf:TextFormat = new TextFormat();
		tf.color = n>=0 ? 0x00CC00 : 0xCC0000;
		
		tfDiff.text = StringFormatter.formatMoney(n);
		tfDiff.setTextFormat(tf);
	}

	function set gamesTotal(n:Number) : Void	{ tfGamesTotal.text = StringFormatter.formatMoney(n); }
	function set realRevenue(n:Number) : Void	{ tfRealRevenue.text = StringFormatter.formatMoney(n); }

	// -------------------------------------------------------------------
	
	// Konstruktor
	function ResultPanel()
	{

	}
}