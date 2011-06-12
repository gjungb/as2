import mx.utils.Delegate;
import de.kruesch.event.*;

class com.adgamewonderland.sskddorf.mischpult.controls.RadioChoice extends MovieClip
{
	private var btnA:Button;
	private var btnB:Button;
	
	private var radio0:MovieClip;
	private var radio1:MovieClip;
			
	private var selected:Number;
	
	private var _event:EventBroadcaster;
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }
	
	// ---------------------------------------------

	function setRadio(n:Number) : Void
	{
		switch (n)
		{
			case 0:	selected = 0;
					this.radio0.gotoAndStop("set");				
					this.radio1.gotoAndStop("unset");				
					break;
					
			case 1:	selected = 1;
					this.radio0.gotoAndStop("unset");				
					this.radio1.gotoAndStop("set");				
					break;
				
		}
	}
	
	function getSelectedIndex() : Number
	{
		return selected;
	}
	
	function setSelectedIndex(index:Number) : Void
	{
		setRadio(index);
	}
	
	
	// ---------------------------------------------
	
	// c'tor
	function RadioChoice()
	{
		var ref = this;
		
		btnA.onPress = function() {ref.onRadio(0);};	
		btnB.onPress = function() {ref.onRadio(1);};
		
		btnA.useHandCursor = btnB.useHandCursor = false;
		
		setRadio(0);
		
		_event = new EventBroadcaster();
	}	
		
	function onRadio(n:Number) : Void
	{
		if (((n!=0)&&(n!=1))||(n==selected)) return;
		
		setRadio(n);
		
		onSelectionChanged();
	}	
	
	function onSelectionChanged() : Void
	{
		_event.send("onSelectionChanged",this,selected);
	}
}