/* Report4
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Report4
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		14.07.2004
zuletzt bearbeitet:	23.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.reports.*

class com.adgamewonderland.trias.vkftool.reports.Report4 extends Report {

	// Attributes
	
	private var mySupplierId:Number;
	
	private var myPlatform:String;
	
	private var myGames:Array;
	
	private var myNumLines:Number;
	
	private var navi_btn:Multibutton, menue_mc:MovieClip, table_supplier_mc:MovieClip, table_games_mc:MovieClip, tablenavi_mc:MovieClip;
	
	// Operations
	
	public  function Report4()
	{
		// nummer des reports
		myReportNum = 4;
		// id des aktuellen suppliers
		mySupplierId = null;
		// platform der aktuellen spieleliste
		myPlatform = "";
		// aktuelle spieleliste
		myGames = [];
		// anzahl zeilen in der spieletabelle
		myNumLines = 15;
	}
	
	public  function showMenue():Void
	{
		// id des aktuellen suppliers
		mySupplierId = null;
		// hinspringen
		gotoAndStop("frMenue");
		// navi button abschalten
		navi_btn.state = "disabled";
		// print button deaktivieren
		reportnavi_mc.changeButton("print", false);
	}
	
	public  function registerMenue(mc:MovieClip ):Void
	{
		// werte der supplier zur anzeige in auswahlmenue
		var values:Array = analysis.getSuppliers();
		// anzeigen
		mc.showValues(values);
		// aufblaettern
		mask_mc.gotoAndPlay(2);
	}
	
	public  function showSupplier(id:Number ):Void
	{
		// id des aktuellen suppliers
		if (typeof id == "number") mySupplierId = id;
		// hinspringen
		gotoAndStop("frSupplier");
		// navi button einschalten
		navi_btn.state = "enabled";
		// print button aktivieren
		reportnavi_mc.changeButton("print", true);
	}
	
	public  function registerSupplierTable(mc:MovieClip ):Void
	{
		// werte holen
		var values:Array = analysis.getValues(reportnum, mySupplierId);
		// werte fuer aktuellen supplier
		var suppvalues:Object = values[0];
		// schliefe ueber werte
		for (var i:String in suppvalues) {
			// aktueller wert
			var value = suppvalues[i];
			// dazu gehoeriges textfeld
			var field:TextField = mc[i + "_txt"];
			// aktuelles format des textfelds, um ausrichtung raus zu bekommen
			var format:TextFormat = field.getTextFormat();
			// ausrichtung
			var align:String = format.align;
			// entspreched auto ausrichten
			field.autoSize = align;
			// anzeigen
			field.text = value;
		}
		
		// buttons initialisieren
		mc.pccd_btn.onRelease = function () {
			this._parent._parent.showGames("pccd");
		}
		mc.ps2_btn.onRelease = function () {
			this._parent._parent.showGames("ps2");
		}
		mc.xbox_btn.onRelease = function () {
			this._parent._parent.showGames("xbox");
		}
		mc.gamecube_btn.onRelease = function () {
			this._parent._parent.showGames("gamecube");
		}
		mc.gba_btn.onRelease = function () {
			this._parent._parent.showGames("gba");
		}
		// aufblaettern
		mask_mc.gotoAndPlay(2);
	}
	
	public  function showGames(platform:String ):Void
	{
		// platform der aktuellen spieleliste
		myPlatform = platform;
		// hinspringen
		gotoAndStop("frGames");
		// navi button einschalten
		navi_btn.state = "enabled";
		// print button aktivieren
		reportnavi_mc.changeButton("print", true);
	}
	
	public  function registerGamesTable(mc:MovieClip ):Void
	{
		// dataconnector
		var datacon:Dataconnector = _root.getDataconnector();
		// daten fuer spiele des aktuellen suppliers und der aktuellen plattform holen
		datacon.loadGames(myPlatform, mySupplierId, this, "onGamesLoaded");
	}
	
	public  function onGamesLoaded(res:Array ):Void
	{
		// werte speichern
		myGames = res;
		// anzahl der tabellen
		var max:Number = Math.ceil(myGames.length / myNumLines);
		// tabellen navigation updaten
		tablenavi_mc.max = max;
		// erste seite anzeigen
		swapTable(1);
	}
	
	public  function swapTable(page:Number, mask:Boolean ):Void
	{
		// tabelle leeren
		table_games_mc.clearValues();
		// erste zeile
		var firstline:Number = (page - 1) * myNumLines;
		// letzte zeile
		var lastline:Number = page * myNumLines;
		// teil der spiele, der angezeigt werden soll
		var games:Array = myGames.slice(firstline, lastline);
		// schleife ueber die spiele, um listenposition und formatierung hinzuzufuegen
		for (var i:Number = 0; i < games.length; i++) {
			// position
			games[i].pos = (firstline + i + 1) + ".";
			// formatierung revenue
			games[i].revenueformatted = analysis.getDottedValue(Math.round(games[i].revenue)) + ",-";
		}
		// anzeigen
		table_games_mc.showValues(games);
		// aufblaettern
		if (mask == true) mask_mc.gotoAndPlay(2);
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
			var table_mc:MovieClip = (_currentframe == 2 ? table_supplier_mc : table_games_mc);
			
			// druckversion der tabelle
			table_mc.showPrintversion(true);
			// headlines ausblenden
			headline_txt._visible = headline2_txt._visible = false;
			// headlines faerben
			table_mc.headline_txt.textColor = 0x000000;
			table_mc.headline2_txt.textColor = 0x000000;
			// report skalieren, damit er auf seite passt
			table_mc._xscale = table_mc._yscale = pj.pageWidth / Stage.width * 100;
			// footer skalieren, damit er aussieht wie in allen anderen reports
			footer_mc._xscale = footer_mc._yscale = pj.pageWidth / Stage.width * 100;
			
			// footer ganz nach unten
			footer_mc._y = pj.pageHeight;
			// footer nach links
// 			footer_mc._x = table_mc._x;
			// datum in footer
			var now:Date = new Date();
			footer_mc.date_txt.autoSize = "right";
			footer_mc.date_txt.text = now.getDate() + "." + (now.getMonth() + 1) + "." + now.getFullYear();
			// seitenzahl in footer
			footer_mc.page_txt.autoSize = "right";
			footer_mc.page_txt.text = "Seite 1 von 1";
			// datum und seitenzahl nach rechts
// 			footer_mc.page_txt._x = table_mc._width - footer_mc.page_txt._width;
// 			footer_mc.date_txt._x = table_mc._width - footer_mc.date_txt._width;
			footer_mc.date_txt._x = footer_mc.page_txt._x - footer_mc.date_txt._width - 20;
			
			// je nach tabelle
			switch (_currentframe) {
				// supplier
				case 2 :
					// seitenzahl in footer
					footer_mc.page_txt.autoSize = "right";
					footer_mc.page_txt.text = "Seite 1 von 1";
					// frame in warteschlange
					pj.addPage(targetPath(this), null, null, 2);
				
					break;
				// games
				case 3 :
					// anzahl der tabellen
					var tables:Number = tablenavi_mc.max;
					// schleife ueber alle einzelnen tabellen
					for (var i:Number = 1; i <= tables; i ++) {
						// tabelle anzeigen
						swapTable(i, false);
						// seitenzahl in footer
						footer_mc.page_txt.autoSize = "right";
						footer_mc.page_txt.text = "Seite " + i + " von " + tables;
						// frame in warteschlange
						pj.addPage(targetPath(this), null, null, 3);
					}
					break;
			}
			// an drucker schicken
			pj.send();
			
			// report auf urspruengliche skalierung
			table_mc._xscale = table_mc._yscale = 100;
			// report auf urspruengliche skalierung
			footer_mc._xscale = footer_mc._yscale = 100;
			// headlines faerben
			table_mc.headline_txt.textColor = 0xFFFFFF;
			table_mc.headline2_txt.textColor = 0xFFFFFF;
			// headlines einblenden
			headline_txt._visible = headline2_txt._visible = true;
			// bildschirmversion der tabelle
			table_mc.showPrintversion(false);
			
			// auswahl button ausblenden
			navi_btn._visible = true;
			// reportnavi einblenden
			reportnavi_mc._visible = true;
		}
		// druckjob loeschen
		delete pj;
	}

} /* end class Report4 */
