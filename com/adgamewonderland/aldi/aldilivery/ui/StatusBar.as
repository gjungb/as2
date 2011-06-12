import com.adgamewonderland.aldi.aldilivery.ui.Clock;
import com.adgamewonderland.aldi.aldilivery.ui.PowerBar;

class com.adgamewonderland.aldi.aldilivery.ui.StatusBar
{
	private var power:PowerBar;
	private var clock:Clock;
	private var bonus:MovieClip;
	
	private var tfLives:TextField;
	private var tfScore:TextField;
	
	// ----------------------------------
	
	function setTime(t:Number) : Void
	{
		if (t<0) t = 0;
		if (t>1) t = 1;
		
		this.clock.setTime(t);
	}
	
	function setPower(p:Number) : Void
	{
		this.power.setPower(p);
	}
	
	function setLives(l:Number) : Void
	{
		if (l<0) l = 0;
		this.tfLives.text = l.toString();
	}
	
	function setScore(s:Number) : Void
	{
		this.tfScore.text = s.toString();
	}
	
	function setBonusFactor(b:Number) : Void
	{
		if (b<1) b = 1;
		
		this.bonus._visible = b>1;
		this.bonus.tfFactor.text = "X"+b;
	}
	
	// ----------------------------------
	
	function StatusBar()
	{		
		this.setPower(0.2);
	}
}
