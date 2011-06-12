/* Chart7
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Chart7
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		12.07.2004
zuletzt bearbeitet:	12.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Chart7 extends Chart {

	// Attributes
	
	// Operations
	
	public  function Chart7()
	{
		// saeulen
		myColumns = [];
		// x-abstand der saeulen
		myXdiff = 56;
		// typen der werte, die angezeigt werden sollen
		myTypes = ["outletshare", "priceshare", "sharediff"];
		// breiten und maximale hoehen der columns
		mySizes = [{width : 20, height : 342}, {width : 20, height : 342}, {width : 15, height : 342}];
		// haben die einzelnen columns beschriftungen
		hasLabels = [true, false, false];
	}

} /* end class Chart7 */
