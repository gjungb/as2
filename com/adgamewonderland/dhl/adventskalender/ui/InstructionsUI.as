/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventskalender.ui.*;

class com.adgamewonderland.dhl.adventskalender.ui.InstructionsUI extends MovieClip {
	
	private var myCalendarUI:CalendarUI;
	
	private var close_btn:Button;
	
	public function InstructionsUI() {
		myCalendarUI = CalendarUI(_parent);
	}
	
	public function showInstructions():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frOpen");
	}
	
	public function init():Void
	{
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopInstructions();
	 	};
	}
	
	public function stopInstructions():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onInstructionsFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay("frClose");
	}
	
	public function onInstructionsFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}
}