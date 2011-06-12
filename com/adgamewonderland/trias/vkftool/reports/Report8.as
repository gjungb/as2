/* Report8
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report8
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		10.07.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report8 extends Report {

	// Attributes
	
	private var navi_btn:Multibutton;
	
	private var inited:Boolean;
	
	// Operations
	
	public  function Report8()
	{
		// nummer des reports
		myReportNum = 8;
		// aktuelle ansicht
		myView = "chartview";
		// nicht initialisiert
		inited = false;
		// nach kurzer pause chart aufbauen
		myInterval = setInterval(this, "onNaviAction", 500, myView);
	}
	
	public  function showChart(mask:Boolean ):Void
	{
		// werte holen
		var values:Array = analysis.getValues(reportnum);
		// umsortieren nach stueckzahl fuer korrekte depth
		values.sort(sortOnIntake);
		// anzeigen
		chart_mc.showValues(values);
		// aufblaettern
		if (mask == true) mask_mc.gotoAndPlay(2);
		// einmalig labels ausblenden
		if (!inited) {
			swapLabels(navi_btn);
			inited = true;
		}
	}
	
	private function sortOnIntake(val1:Object, val2:Object):Number
	{
		// intake vergleichen
		return (val2.intakevalue - val1.intakevalue);
	}
	
	public  function swapLabels(mc:Multibutton ):Void
	{
		// an chart weiter geben
		chart_mc.swapLabels(mc);
	}

} /* end class Report8 */
