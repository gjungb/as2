/* Tablenavi
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Tablenavi
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		10.07.2004
zuletzt bearbeitet:	16.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Tablenavi extends MovieClip {

	// Attributes
	
	private var _myTableMax:Number;
	
	private var myTableNum:Object; // max, act
	
	private var previous_btn:Button, next_btn:Button, counter_txt:TextField;
	
	// Operations
	
	public  function Tablenavi()
	{
		// anzahl tabellen (maximal, aktuell)
		myTableNum = {max : 1, act : 1};
		// maximale anzahl tabellen
		max = _myTableMax;
		// buttons initialisieren
		previous_btn.onRelease = function () {
			// nach links
			this._parent.onReleaseButton(-1);
		}
		next_btn.onRelease = function () {
			// nach rechts
			this._parent.onReleaseButton(1);
		}
	}
	
	public function get max():Number
	{
		// maximale anzahl tabellen
		return (myTableNum.max);
	}
	
	public function set max(num:Number ):Void
	{
		// maximale anzahl tabellen
		myTableNum.max = num;
		// anzeige updaten
		updateNavi();
	}
	
	private function updateNavi(mc:Report ):Void
	{
		// counter anzeigen
		counter_txt.autoSize = "center";
		counter_txt.text = myTableNum.act + " / " + myTableNum.max;
		// buttons ein- / ausblenden
		previous_btn._visible = (myTableNum.act > 1);
		next_btn._visible = (myTableNum.act < myTableNum.max);
	}
	
	public function onReleaseButton(dir:Number ):Void
	{
		// aktuelle tabelle zaehlen
		myTableNum.act += dir;
		// anzeigen lassen
		_parent.swapTable(myTableNum.act, true);
		// anzeige updaten
		updateNavi();
	}

} /* end class Tablenavi */
