/* Report1
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report1
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		16.07.2004
zuletzt bearbeitet:	16.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report1 extends Report {

	// Attributes
	
	// Operations
	
	public  function Report1()
	{
		// nummer des reports
		myReportNum = 1;
		// aktuelle ansicht
		myView = "chartview";
		// nach kurzer pause chart aufbauen
		myInterval = setInterval(this, "onNaviAction", 500, myView);
	}

} /* end class Report1 */
