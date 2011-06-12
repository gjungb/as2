/* Chart3
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Chart3
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

class com.adgamewonderland.trias.vkftool.reports.Chart3 extends Chart {

	// Attributes
	
	// Operations
	
	public  function Chart3()
	{
		// saeulen
		myColumns = [];
		// x-abstand der saeulen
		myXdiff = 56;
		// typen der werte, die angezeigt werden sollen
		myTypes = ["resultvalue"];
		// breiten und maximale hoehen der columns
		mySizes = [{width : 25, height : 370}];
		// haben die einzelnen columns beschriftungen
		hasLabels = [true, true];
	}

} /* end class Chart3 */
