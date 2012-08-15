/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.beans.*;

import com.adgamewonderland.digitalbanal.elfmeterduell.ui.CounteraniUI;
 
class com.adgamewonderland.digitalbanal.elfmeterduell.ui.ResultaniUI extends MovieClip {
	
	private var offender:String;
	
	private var defender:String;
	
	private var nick_offender_txt:TextField;
	
	private var nick_defender_txt:TextField;
	
	private var progress_offense_mc:MovieClip;
	
	private var progress_defense_mc:MovieClip;
	
	private var count_offense_mc:CounteraniUI;
	
	private var count_defense_mc:CounteraniUI;
	
	public function ResultaniUI() {
		// nickname des angreifers
		this.offender = "";
		// nickname des torwarts
		this.defender = "";
	}
	
	public function showResultani(inout:Boolean, offender:String, defender:String ):Void
	{
		// nickname des angreifers
		setOffender(offender);
		// nickname des torwarts
		setDefender(defender);
		// frame
		var frame:String = (inout ? "frIn" : "frOut");
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "onResultaniFinished", null);
		// abspielen verfolgen
		this.onEnterFrame = function() {
			follower.followTimeline();
		}
		// abspielen
		gotoAndPlay(frame);
	}
	
	public function onResultaniFinished():Void
	{
		// runde initialisieren
		if (_parent.getMode() == GameDetail.MODE_OPPONENT) {
			// fortschritt anzeigen	
			progress_defense_mc.gotoAndStop(6);
			// anzahl tore challenger
			var goals:Number = GameController.getInstance().getGame().getDetail(GameDetail.MODE_CHALLENGER).getGoals();
			// anzeigen
			count_defense_mc.showCounterani(goals);
		} else {
			// anzahl tore verteidiger resetten
			count_defense_mc.showCounterani(0);
		}
		// anzahl tore angreifer resetten
		count_offense_mc.showCounterani(0);
		// textfelder linksbuendig
		nick_offender_txt.autoSize = "left";
		nick_defender_txt.autoSize = "left";
		// nickname des angreifers
		nick_offender_txt.text = getOffender();
		// nickname des torwarts
		nick_defender_txt.text = getDefender();
	}
	
	public function countShot(mode:Number, counter:Number, goal:Boolean ):Void
	{
		// fortschritt anzeigen
		progress_offense_mc.gotoAndStop(counter + 1);
		// tor zaehlen
		if (goal) {
			// tor zaehlen
			var goals:Number = count_offense_mc.getCount() + 1;
			// anzeigen
			count_offense_mc.showCounterani(goals);
		}
	}

	public function getOffender():String {
		return offender;
	}

	public function setOffender(offender:String):Void {
		this.offender = offender;
	}

	public function getDefender():String {
		return defender;
	}

	public function setDefender(defender:String):Void {
		this.defender = defender;
	}

}