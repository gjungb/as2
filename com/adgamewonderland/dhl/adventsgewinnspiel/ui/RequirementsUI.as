/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.RequirementsUI extends MovieClip {

	private var myCalendarUI:CalendarUI;

	private var close_btn:Button;

	public function RequirementsUI() {
		myCalendarUI = CalendarUI(_parent);
	}

	public function showRequirements():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "init");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frOpen");
	}

	public function init():Void
	{
	 	// button zurueck
	 	close_btn.onRelease = function () {
	 		this._parent.stopRequirements();
	 	};
	}

	public function stopRequirements():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onRequirementsFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frClose");
	}

	public function onRequirementsFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}

	public function closeRequirements():Void
	{
		// abspielen
		gotoAndPlay("frClose");
	}
}