/* Inputrevenue
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputrevenue
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		07.07.2004
zuletzt bearbeitet:	07.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Inputrevenue extends MovieClip {

	// Attributes
	
	private var inputfield0_mc:Inputfield;
	
	// Operations
	
	public  function Inputrevenue()
	{
	}
	
	public  function registerInputfield(mc:Inputfield, param:String ):Void
	{
		// gesamtumsatz
		var revenue:Number = _root.getDataconnector().revenue;
		// anzeigen
		mc.value = revenue;
	}

} /* end class Inputrevenue */
