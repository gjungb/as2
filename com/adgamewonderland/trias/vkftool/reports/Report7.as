/* Report7
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report7
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		10.07.2004
zuletzt bearbeitet:	15.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report7 extends Report {

	// Attributes
	
	// Operations
	
	public  function Report7()
	{
		// nummer des reports
		myReportNum = 7;
		// aktuelle ansicht
		myView = "chartview";
		// nach kurzer pause chart aufbauen
		myInterval = setInterval(this, "onNaviAction", 500, myView);
	}

} /* end class Report7 */
