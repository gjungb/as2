import mx.utils.Delegate;

import de.kruesch.event.EventBroadcaster;
import com.adgamewonderland.ea.bat.ui.*;
import com.adgamewonderland.ea.bat.util.StringFormatter;

class com.adgamewonderland.ea.bat.ui.InputPanel extends MovieClip
{
	private var stepperRevenue:Stepper;
	private var stepperGamesPercent:Stepper;
	private var stepperStockTurn:Stepper;

	// -------------------------------------------------------------------	

	function set targetRevenue(n:Number) : Void		{ stepperRevenue.value = n; }
	function get targetRevenue() : Number			{ return stepperRevenue.value; }

	function set gamesPercentage(n:Number) : Void	{ stepperGamesPercent.value = n; }
	function get gamesPercentage() : Number			{ return stepperGamesPercent.value; }

	function set stockTurn(n:Number) : Void			{ stepperStockTurn.value = n; }
	function get stockTurn() : Number				{ return stepperStockTurn.value; }
	
	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------
	
	// Konstruktor
	function InputPanel()
	{
		_event = new EventBroadcaster();
	}

	function updateView() : Void
	{
		stepperRevenue.updateView();
		stepperGamesPercent.updateView();
		stepperStockTurn.updateView();
	}

	function onValueChanged(sender:Object) : Void
	{
		_event.send("onValueChanged",this,sender==stepperStockTurn);
	}

	function onLoad() : Void
	{
		stepperRevenue.setFormat(Stepper.FORMAT_MONEY);
		stepperRevenue.minimum = 100000;
		stepperRevenue.maximum = 10000000;
		stepperRevenue.step = 100000;

		stepperGamesPercent.setFormat(Stepper.FORMAT_PERCENT);
		stepperGamesPercent.minimum = 1;
		stepperGamesPercent.maximum = 100;
		stepperGamesPercent.step = 1;

		stepperStockTurn.setFormat(Stepper.FORMAT_NUMBER);
		stepperStockTurn.minimum = 1;
		stepperStockTurn.maximum = 15;
		stepperStockTurn.step = 0.2;

		stepperRevenue.addListener(this);
		stepperGamesPercent.addListener(this);
		stepperStockTurn.addListener(this);
	}
}
