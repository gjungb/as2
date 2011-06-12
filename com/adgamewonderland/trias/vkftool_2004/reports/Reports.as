/* Reports
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Reports
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

class com.adgamewonderland.trias.vkftool.reports.Reports extends MovieClip {

	// Attributes
	
	private var myDataconnector:Dataconnector;
	
	private var mySuppliers:Array;
	
	private var myReportNum:Number;
	
	private var myReport:Report;
	
	private var report1_mc:Report, report2_mc:Report, report3_mc:Report, report4_mc:Report, report5_mc:Report, report6_mc:Report, report7_mc:Report, report8_mc:Report, back_mc:MovieClip;
	
	// Operations
	
	public  function Reports()
	{
		// global verfuegbar
		_global.Reports = this;
		// dataconnector zum laden / speichern / aufbewahren aller relevanten daten
		myDataconnector = _root.getDataconnector();
		// suppliers
		mySuppliers = myDataconnector.suppliers;
		// nummer des aktuellen reports
		myReportNum = null;
		// movieclip des aktuellen reports
		report = null;
	}
	
	public  function get suppliers():Array
	{
		// suppliers
		return(mySuppliers);
	}
	
	public  function get report():Report
	{
		// movieclip des aktuellen reports
		return(myReport);
	}
	
	public function set report(mc:Report ):Void
	{
		// movieclip des aktuellen reports
		myReport = mc;
	}
	
	public  function showReport(num:Number ):Void
	{
		// abbrechen, wenn dieser report aktuell angezeigt wird
		if (myReportNum == num) return;
		// reportnummer speichern
		myReportNum = num;
		
		// shutter abspielen
		_global.Shutter.closeShutter(this, "gotoAndPlay", "frReport" + num);
		
		// hinspringen
// 		gotoAndPlay("frReport" + num);
		// movieclip des reports
		report = this["report" + num + "_mc"];
	}

} /* end class Reports */
