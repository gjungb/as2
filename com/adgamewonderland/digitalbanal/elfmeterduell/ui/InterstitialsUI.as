/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.*;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.ui.InterstitialsUI extends MovieClip {
	
	private var interstitials:Array;
	
	private var interstitial1_mc:InterstitialUI;
	
	private var interstitial2_mc:InterstitialUI;
	
	public function InterstitialsUI() {
		this.interstitials = new Array();
		this.interstitials[SoccerController.MODE_OFFENSE] = interstitial1_mc;
		this.interstitials[SoccerController.MODE_DEFENSE] = interstitial2_mc;
	}
	
	public static function getInterstitialsUI():InterstitialsUI
	{
		return (_root.content_mc.interstitials_mc);
	}
	
	public function showInterstitial(mode:Number ):Void
	{
		// entsprechendes interstitial
		var mc:MovieClip = this.interstitials[mode];
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(mc, "onInterstitialFinished", null);
		// abspielen verfolgen
		mc.onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		mc.gotoAndPlay("frIn");
	}
	
	public function onInterstitialFinished():Void
	{
		// spielfeld aufbauen
		SoccerUI.getSoccerUI().startSoccerUI();
	}
	
}