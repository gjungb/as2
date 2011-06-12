/* Report2
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report2
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		16.07.2004
zuletzt bearbeitet:	21.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report2 extends Report {

	// Attributes
	
	private var myTableNum:Number;
	
	private var myFramesNum:Number;
	
	private var navi_btn:Multibutton;
	
	// Operations
	
	public  function Report2()
	{
		// nummer des reports
		myReportNum = 2;
		// nummer der aktuellen tabelle
		myTableNum = null;
		// anzahl der frames zwischen zwei vollstaendigen tabellen
		myFramesNum = 16;
		// print button deaktivieren
		reportnavi_mc.changeButton("print", false);
	}
	
	public  function showMenue():Void
	{
		// auswahl button deaktivieren
		navi_btn.state = "disabled";
		// hinspringen
		gotoAndStop("frMenue");
		// print button deaktivieren
		reportnavi_mc.changeButton("print", false);
	}
	
	public  function showTable(num:Number ):Void
	{
		// nummer der aktuellen tabelle
		myTableNum = num;
		// auswahl button aktivieren
		navi_btn.state = "enabled";
		// hinspringen
		gotoAndStop("fr" + num);
		// print button aktivieren
		reportnavi_mc.changeButton("print", true);
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
			// auswahl button ausblenden
			navi_btn._visible = false;
		
			// aktuelle tabelle
			var table_mc:MovieClip = this["table" + myTableNum + "_mc"];
			
			// druckversion der tabelle
			table_mc.lines_mc._visible = false;
			// headlines faerben
			table_mc.headline_txt.textColor = 0x000000;
			table_mc.headline2_txt.textColor = 0x000000;
			// report skalieren, damit er auf seite passt
			table_mc._xscale = table_mc._yscale = pj.pageWidth / Stage.width * 100;
			
			// footer ganz nach unten
			table_mc.footer_mc._y = pj.pageHeight * 1.8;
			// footer nach links
			table_mc.footer_mc._x = table_mc.getBounds().xMin;
			// datum in footer
			var now:Date = new Date();
			table_mc.footer_mc.date_txt.autoSize = "right";
			table_mc.footer_mc.date_txt.text = now.getDate() + "." + (now.getMonth() + 1) + "." + now.getFullYear();
			// datum und seitenzahl nach rechts
// 			table_mc.footer_mc.page_txt._x = table_mc.getBounds().xMax - table_mc.footer_mc.page_txt._width;
// 			table_mc.footer_mc.date_txt._x = table_mc.getBounds().xMax - table_mc.footer_mc.date_txt._width;
			table_mc.footer_mc.date_txt._x = table_mc.footer_mc.date_txt._x - table_mc.footer_mc.date_txt._width - 20;
			
			// anzahl der einzelnen tabellen
			var tables:Number = table_mc._totalframes / myFramesNum;
			// schleife ueber alle einzelnen tabellen
			for (var i:Number = 1; i <= tables; i ++) {
				// seitenzahl in footer
				table_mc.footer_mc.page_txt.autoSize = "right";
				table_mc.footer_mc.page_txt.text = "Seite " + i + " von " + tables;
				// entsprechender frame
				var frame:Number = i * myFramesNum;
				// frame in warteschlange
				pj.addPage(targetPath(table_mc), null, null, frame);
			}
			// an drucker schicken
			pj.send();
			
			// report auf urspruengliche skalierung
			table_mc._xscale = table_mc._yscale = 100;
			// headlines faerben
			table_mc.headline_txt.textColor = 0xFFFFFF;
			table_mc.headline2_txt.textColor = 0xFFFFFF;
			// bildschirmversion der tabelle
			table_mc.lines_mc._visible = true;
			
			// auswahl button ausblenden
			navi_btn._visible = true;
			// reportnavi einblenden
			reportnavi_mc._visible = true;
		}
		// druckjob loeschen
		delete pj;
	}

} /* end class Report2 */
