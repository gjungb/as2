/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.WinningsUI extends MovieClip {

	private var myCalendarUI:CalendarUI;

	private var close_btn:Button;

	public function WinningsUI() {
		myCalendarUI = CalendarUI(_parent);
	}

	public function showWinnings():Void
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
	 		this._parent.stopWinnings();
	 	};
	}

	public function stopWinnings():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onWinningsFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frClose");
	}

	public function onWinningsFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}

	public function closeWinnings():Void
	{
		// abspielen
		gotoAndPlay("frClose");
	}
}