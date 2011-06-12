/* Reportnavi
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Reportnavi
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

class com.adgamewonderland.trias.vkftool.reports.Reportnavi extends MovieClip {

	// Attributes
	
	private var _hasPrint:Boolean, _hasChartview:Boolean, _hasDataview:Boolean;
	
	private var print_btn:Multibutton, chartview_btn:Multibutton, dataview_btn:Multibutton;
	
	// Operations
	
	public  function Reportnavi()
	{
	}
	
	public function onEnterFrame():Boolean
	{
		// beenden, wenn buttons initialisiert
		if (print_btn.state == "enabled" || print_btn.state == "disabled") return(delete(onEnterFrame));
		// navigationsbuttons updaten
		updateNavi();
	}
	
	public function updateNavi():Void
	{
		// status der buttons umschalten
		// print
		print_btn.state = (_hasPrint ? "enabled" : "disabled");
		// chartview
		chartview_btn.state = (_hasChartview ? "enabled" : "disabled");
		// dataview
		dataview_btn.state = (_hasDataview ? "enabled" : "disabled");
	}
	
	public function onReleaseButton(mc:MovieClip):Void
	{
		// aktion aus instanzname
		var action:String = mc._name.substring(0, mc._name.indexOf("_"));
		// an report uebergeben
		_parent.onNaviAction(action);
	}
	
	public function changeButton(btnstr:String, bool:Boolean ):Void
	{
		// entsprechenden button umschalten
		this[btnstr + "_btn"].state = (bool ? "enabled" : "disabled");
	}

} /* end class Reportnavi */
