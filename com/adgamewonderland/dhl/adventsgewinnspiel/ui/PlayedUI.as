/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.dhl.adventsgewinnspiel.ui.*;

class com.adgamewonderland.dhl.adventsgewinnspiel.ui.PlayedUI extends MovieClip {

	private var myCalendarUI:CalendarUI;

	private var close_btn:Button;

	public function PlayedUI() {
		myCalendarUI = CalendarUI(_parent);
	}

	public function showPlayed():Void
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
	 		this._parent.stopPlayed();
	 	};
	}

	public function stopPlayed():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onPlayedFinished");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frClose");
	}

	public function onPlayedFinished():Void
	{
		// zum kalender
		myCalendarUI.showCalendar();
	}

	public function closePlayed():Void
	{
		// abspielen
		gotoAndPlay("frClose");
	}
}