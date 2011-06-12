/* Menue
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Menue
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		08.07.2004
zuletzt bearbeitet:	16.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

class com.adgamewonderland.trias.vkftool.Menue extends MovieClip {

	// Attributes
	
	private var myDataconnector:Dataconnector;
	
	private var myPopups:Object;
	
	private var myReportNum:Number;
	
	private var myInterval:Number;
	
	private var headline_txt:TextField;
	
	private var datamanager_mc:MovieClip, reportsmanager_mc:MovieClip, startmessage_mc:MovieClip, back_mc:MovieClip;
	
	// Operations
	
	public  function Menue()
	{
		// global verfuegbar
		_global.Menue = this;
		// dataconnector zum laden / speichern / aufbewahren aller relevanten daten
		myDataconnector = _root.getDataconnector();
		// object zur aufnahme der popups
		myPopups = {};
		// report, der aktuell angezeigt wird
		myReportNum = 0;
		
		// beim ersten start linkes, sonst rechtes popup oeffnen
		var popup:String = (myDataconnector.firstrun == true ? "datamanager_mc" : "reportsmanager_mc");
		// nach pause oeffnen
		myInterval = setInterval(this, "togglePopup", 2000, popup, true);
		
		// headline anzeigen
		showHeadline("Herzlich Willkommen");
	}
	
	public  function registerPopup(mc:MovieClip):Void
	{
		// name des parents als index
		var index:String = mc._parent._name;
		// speichern
		myPopups[index] = mc;
	}
	
	public  function togglePopup(index:String, bool:Boolean ):Void
	{
		// interval loeschen
		clearInterval(myInterval);
		// movieclip aus object
		var mc:MovieClip = myPopups[index];
		// oeffnen / schliessen
		mc.open = bool;
	}
	
	public  function getFirstRun()
	{
		// zurueck geben, ob erster start
		return (myDataconnector.firstrun);
	}
	
	public  function showContent(index:String, num:Number ):Void
	{
		// je nach aufrufer
		switch (index) {
			// datamanager
			case "datamanager_mc" :
				// report, der aktuell angezeigt wird
				myReportNum = 0;
				// je nach nummer
				switch (num) {
					// 1: dateneingabe
					case 1 :
						// shutter schliessen und zum input springen
						_global.Shutter.closeShutter(this, "onShutterClosed", "input");
						
						break;
					// 2: speichern und schliessen
					case 2 :
						// speichern
						myDataconnector.updateUserdata();
						// schliessen
						fscommand("Quit", "");
						
						break;
					// 3: credits
					case 3 :
					
						break;
				}
				break;
			// reportsmanager
			case "reportsmanager_mc" :
				// testen, ob aktuell ein report angezeigt wird
				if (myReportNum != 0) {
					// report, der aktuell angezeigt wird
					myReportNum = num;
					// report anzeigen
					onShutterClosed("reports");
				
				} else {
					// report, der aktuell angezeigt wird
					myReportNum = num;
					// shutter schliessen und zu reports springen
// 					_global.Shutter.closeShutter(this, "onShutterClosed", "reports");
					onShutterClosed("reports");
				}
			
				break;
			// input
			case "input_mc" :
				// report, der aktuell angezeigt wird
				myReportNum = 0;
				// shutter schliessen und zum menue springen
				_global.Shutter.closeShutter(this, "onShutterClosed", "menue");
			
				break;
		}
	
	}
	
	public function onShutterClosed(param:String ):Void
	{
		// je nach parameter
		switch (param) {
			// zur dateneingabe
			case "input" :
				// popup schliessen
				togglePopup("datamanager_mc", false);
				// menue ausblenden
				this._visible = false;
				// hinspringen
				_root.gotoAndStop("frInput");
				// headline anzeigen
				showHeadline("Daten-Manager");
			
				break;
			// zu reports
			case "reports" :
				// nachricht ausblenden
				startmessage_mc._visible = false;
				// hintergrund ausblenden
				back_mc._visible = false;
				// beide popups schliessen
				togglePopup("datamanager_mc", false);
				togglePopup("reportsmanager_mc", false);
				// hinspringen
				_root.gotoAndStop("frReports");
				// report anzeigen
				_global.Reports.showReport(myReportNum);
				// headline anzeigen
				showHeadline("Reports");
			
				break;
			// zum menue
			case "menue" :
				// menue einblenden
				this._visible = true;
				// nachricht einblenden
				startmessage_mc._visible = true;
				// nachricht updaten
				startmessage_mc.gotoAndStop(myDataconnector.firstrun == true ? 2 : 3);
				// hintergrund einblenden
				back_mc._visible = true;
				// linkes popup schliessen
				togglePopup("datamanager_mc", myDataconnector.firstrun);
				// rechtes popup oeffnen
				togglePopup("reportsmanager_mc", !myDataconnector.firstrun);
				// hinspringen
				_root.gotoAndStop("frMenue");
				// headline anzeigen
				showHeadline("Daten-Manager");
			
				break;
		}
	}
	
	public function showHeadline(str:String ):Void
	{
		// anzeigen
		_parent.headline_txt.autoSize = "center";
		_parent.headline_txt.text = str;
	}
	

} /* end class Menue */
