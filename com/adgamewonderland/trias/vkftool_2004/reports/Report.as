/* Report
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		09.07.2004
zuletzt bearbeitet:	23.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report extends MovieClip {

	// Attributes
	
	private var myReportNum:Number;
	
	private var myAnalysis:Analysis;
	
	private var myView:String;
	
	private var myValues:Array;
	
	private var myInterval:Number;
	
	private var headline_txt:TextField, headline2_txt:TextField;
	
	private var reportnavi_mc:MovieClip, chart_mc:MovieClip, table_mc:MovieClip, mask_mc:MovieClip, back_mc:MovieClip, footer_mc:MovieClip;
	
	// Operations
	
	public  function Report()
	{
		// nummer des reports
		myReportNum = null;
		// analyse der eingegebenen daten (nur vollstaendig ausgefuellte datensaetze)
		myAnalysis = _global.dataconn.analysis;
		// aktuelle ansicht
		myView = null;
		// navigation updaten
		reportnavi_mc.updateNavi(this);
		// chart ausblenden
		chart_mc._visible = false;
		// tabelle ausblenden
		table_mc._visible = false;
		// druckhintergrund ausblenden
		back_mc._visible = false;
	}
	
	public function get reportnum():Number
	{
		// nummer des reports
		return (myReportNum);
	}
	
	public function get analysis():Analysis
	{
		// analyse der eingegebenen daten (nur vollstaendig ausgefuellte datensaetze)
		return (myAnalysis);
	}
	
	public  function onNaviAction(action:String ):Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// je nach action
		switch (action) {
			// drucken
			case "print" :
				// drucken
				printReport();
			
				break;
			// chart anzeigen
			case "chartview" :
				// aktuelle ansicht
				myView = "chartview";
				// chart einblenden
				chart_mc._visible = true;
				// tabelle ausblenden
				table_mc._visible = false;
				// chart anzeigen
				showChart(true);
			
				break;
			// tabelle anzeigen
			case "dataview" :
				// aktuelle ansicht
				myView = "dataview";
				// chart ausblenden
				chart_mc._visible = false;
				// tabelle einblenden
				table_mc._visible = true;
				// tabelle anzeigen
				showTable(true);
			
				break;
		}
	}
	
	private  function printReport():Void
	{
		// neuer druckjob
		var pj:PrintJob = new PrintJob();
		// druck-dialog anzeigen
		var started:Boolean = pj.start();
		// testen, ob drucken gewuenscht
		if (started) {
			// reportnavi ausblenden
			reportnavi_mc._visible = false;
			
			// headlines faerben
			headline_txt.textColor = 0x000000;
			headline2_txt.textColor = 0x000000;
		
			// chart anzeigen
			showChart(false);
			// chart einblenden
			chart_mc._visible = true;
			// druckversion des charts
			chart_mc.showPrintversion(true);
			
			// tabelle anzeigen
			showTable(false);
			// tabelle einblenden
			table_mc._visible = true;
			// tabelle unter chart
			table_mc._y = chart_mc.getBounds().yMax;
			// druckversion der tabelle
			table_mc.showPrintversion(true);
			
			// report skalieren, damit er auf seite passt
			this._xscale = this._yscale = pj.pageWidth / Stage.width * 100;
			
			// halber abstand chart zu rand chart
			var xchart:Number = chart_mc.getBounds().xMin / 2;
			// headline, chart und tabelle nach links verschieben, damit report zentriert steht
			headline_txt._x -= xchart;
			headline2_txt._x -= xchart;
			chart_mc._x -= xchart;
			table_mc._x -= xchart;
			
			// umrandung chart
			var bounds:Object = chart_mc.getBounds();
			// druckhintergrund auf groesse und an position des charts bringen
			back_mc._x = bounds.xMin - xchart;
			back_mc._y = bounds.yMin;
			back_mc._width = bounds.xMax - bounds.xMin;
			back_mc._height = bounds.yMax - bounds.yMin;
			// druckhintergrund einblenden
			back_mc._visible = true;
			
			// footer ganz nach unten
			footer_mc._y = pj.pageHeight * Stage.width / pj.pageWidth;
// 			footer_mc._y = table_mc.getBounds().yMax + 20;
			// footer nach links
// 			footer_mc._x = back_mc._x;
			// datum in footer
			var now:Date = new Date();
			footer_mc.date_txt.autoSize = "right";
			footer_mc.date_txt.text = now.getDate() + "." + (now.getMonth() + 1) + "." + now.getFullYear();
			// seitenzahl in footer
			footer_mc.page_txt.autoSize = "right";
			footer_mc.page_txt.text = "Seite 1 von 1";
			// datum und seitenzahl nach rechts
// 			footer_mc.page_txt._x = Stage.width - footer_mc.page_txt._width; // back_mc._width
			footer_mc.date_txt._x = footer_mc.page_txt._x - footer_mc.date_txt._width - 20;
			
			// frame 1 des reports in warteschlange
			pj.addPage(targetPath(this), null, null, 1);
			// an drucker schicken
			pj.send();
			
			// footer ganz nach oben
			footer_mc._y = 0;

			// druckhintergrund ausblenden
			back_mc._visible = false;
			
			// headline, chart und tabelle nach rechts verschieben
			headline_txt._x += xchart;
			headline2_txt._x += xchart;
			chart_mc._x += xchart;
			table_mc._x += xchart;
			
			// report auf urspruengliche skalierung
			this._xscale = this._yscale = 100;
			// report an ursruengliche position
			this._x = 0;
			// tabelle nach oben
			table_mc._y = 0;
			// bildschirmversion der tabelle
			table_mc.showPrintversion(false);
			// bildschirmversion des charts
			chart_mc.showPrintversion(false);
			
			// headlines faerben
			headline_txt.textColor = 0xFFFFFF;
			headline2_txt.textColor = 0xFFFFFF;
			
			// reportnavi einblenden
			reportnavi_mc._visible = true;
			// bisherigen view wiederherstellen
			if (myView == "chartview") {
				// tabelle ausblenden
				table_mc._visible = false;
				// chart anzeigen
				showChart(false);
			} else if (myView == "dataview") {
				// chart ausblenden
				chart_mc._visible = false;
				// tabelle anzeigen
				showTable(false);
			}
		}
		// druckjob loeschen
		delete pj;
	}
	
	public  function showChart(mask:Boolean ):Void
	{
		// werte holen
		var values:Array = analysis.getValues(reportnum);
		// anzeigen
		chart_mc.showValues(values);
		// aufblaettern
		if (mask == true) mask_mc.gotoAndPlay(2);
	}
	
	public  function showTable(mask:Boolean ):Void
	{
		// werte holen
		var values:Array = analysis.getValues(reportnum);
		// anzeigen
		table_mc.showValues(values);
		// aufblaettern
		if (mask == true) mask_mc.gotoAndPlay(2);
	}

} /* end class Report */
