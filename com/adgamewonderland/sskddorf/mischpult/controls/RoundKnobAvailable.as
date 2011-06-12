import com.adgamewonderland.sskddorf.mischpult.utils.StringParser;
import com.adgamewonderland.sskddorf.mischpult.controls.RoundKnob;

class com.adgamewonderland.sskddorf.mischpult.controls.RoundKnobAvailable extends RoundKnob
{
	private var tfFix:TextField;

	function __set_maximum(m:Number) : Void
	{
		super.__set_maximum(m);
		tfFix.text = StringParser.formatMoney(m);
	}
}