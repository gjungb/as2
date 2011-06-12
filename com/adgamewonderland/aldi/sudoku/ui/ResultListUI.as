/**
 * @author gerd
 */

import com.adgamewonderland.agw.util.*;

import com.adgamewonderland.agw.net.RemotingBeanCaster;

import com.adgamewonderland.aldi.sudoku.beans.*;

import com.adgamewonderland.aldi.sudoku.ui.*;

class com.adgamewonderland.aldi.sudoku.ui.ResultListUI extends MovieClip {
	
	private static var DATESTART:Date = new Date(2006, 1, 28);
	
	private static var DAYSINLIST:Number = 28;
	
	private static var MSPERDAY:Number = 1000 * 60 * 60 * 24;
	
	private static var DIFFX:Number = 160;
	
	private static var DIFFY:Number = 55;
	
	private var dateend:Date;
	
	private var lso:SharedObject;
	
	private var list_mc:MovieClip;
	
	private var open_btn:Button;
	
	private var close_btn:Button;
	
	private var blind_btn:Button;
	
	private var scrollbar_mc:MovieClip;
	
	public function ResultListUI() {
		// heute, 0 uhr
		this.dateend = new Date(); // 2006, 2, 8
		dateend.setHours(0);
		dateend.setMinutes(0);
		dateend.setSeconds(0);
		dateend.setMilliseconds(0);
		// shared object zum speichern der spielergebnisse
		this.lso = SharedObject.getLocal("sudoku");
		// initialisieren
		initLso();
		// button open
		open_btn.onRelease = function() {
			this._parent.showList();
		};
	}
	
	public function showList():Void
	{
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "initList");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		}
		// einblenden
		gotoAndPlay("frOpen");
	}
	
	public function hideList():Void
	{
		// liste loeschen
		list_mc.removeMovieClip();
		// ausblenden
		gotoAndPlay("frClose");
	}
	
	private function initList():Void
	{
		// button close
		close_btn.onRelease = function() {
			this._parent.hideList();
		};
		// blind button
		blind_btn.useHandCursor = false;
		
		// schleife ueber alle tage
		for (var i:Number = 0; i < DAYSINLIST; i++) {
			// aktuelles datum
			var dateact:Date = new Date();
			// ms
			dateact.setTime(getDateend().getTime() - i * MSPERDAY);
			// abbrechen, wenn zu weit in vergangenheit
			if (dateact.getTime() < DATESTART.getTime()) break;
			// schleife ueber schwierigkeitsgrade
			for (var difficulty:Number = Solution.DIFFICULTY_EASY; difficulty <= Solution.DIFFICULTY_HARD; difficulty++) {
				// spielergebnis
				var result:Result;
				// ggf. gespeichertes result laden
				result = loadResult(dateact, difficulty);
				// wenn nicht geladen, neues spielergebnis
				if (result == null) result = new Result();
				// datum
				result.setDate(dateact);
				// schwierigkeitsgrad
				result.setDifficulty(difficulty);
				// spielergebnis auf buehne
				var constructor:Object = {};
				// positionieren
				constructor._x = (difficulty - 1) * DIFFX;
				constructor._y = i * DIFFY;
				// result uebergeben
				constructor.result = result;
				// attachen
				var mc:ResultUI = ResultUI(list_mc.attachMovie("ResultUI", "result" + i + "" + difficulty + "_mc", list_mc.getNextHighestDepth(), constructor));
			}
		}
		// scrollbar
		scrollbar_mc.setScrollTarget(list_mc);
	}
	
	public function saveResult(date:Date, difficulty:Number, time:Number ):Void
	{
		// result
		var result:Result;
		// laden
		result = loadResult(date, difficulty);
		// wenn nicht geladen, neues spielergebnis
		if (result == null) {
			// neues result
			result = new Result();	
			// date
			result.setDate(date);
			// difficulty
			result.setDifficulty(difficulty);
			// time
			result.setTime(time);
		} else {
			// testen, ob zeit verbessert
			if(time < result.getTime()) result.setTime(time);
		}
		// schluessel
		var key:String = getResultKey(date, difficulty);
		// result hinzufuegen
		this.lso.data.results[key] = result;
		// speichern
		this.lso.flush();
	}
	
	public function loadResult(date:Date, difficulty:Number ):Result
	{
		// gesuchtes spielergebnis
		var result:Result = null;
		// assoziatives array fuer ergebnisse
		var results:Object = this.lso.data.results;
		// schluessel
		var key:String = getResultKey(date, difficulty);
		// gespeichertes ergebnis
		if (results[key] != undefined) result = Result(RemotingBeanCaster.getCastedInstance(new Result(), results[key]));
		// zurueck geben
		return result;
	}

	public function getDateend():Date {
		return dateend;
	}

	public function setDateend(dateend:Date):Void {
		this.dateend = dateend;
	}
	
	private function getResultKey(date:Date, difficulty:Number ):String
	{
		// aus buchstaben, datum und schwierigkeitsgrad zusammen gesetzter schluessel fuer assoziatives array
		return ("d" + date.valueOf() + "d" + difficulty);
	}
	
	private function initLso():Void
	{
		// testen, ob schon initialisiert
		if (this.lso.data.results == undefined) {
			// assoziatives array fuer ergebnisse
			this.lso.data.results = new Object();
			// speichern
			this.lso.flush();
		}
	}

}