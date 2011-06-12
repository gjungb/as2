import com.adgamewonderland.ea.bat.ui.*;
import com.adgamewonderland.ea.bat.data.*;
import com.adgamewonderland.ea.bat.logic.*;
import com.adgamewonderland.agw.util.*;
import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.ea.bat.App
{
	// UI
	var table:DataTable;
	var resultPanel:ResultPanel;
	var inputPanel:InputPanel;
	var publisherInfo:PublisherInfo;
	var unitsInfo:UnitsInfo;

	// Basisdaten
	private var _publishers:Array;
	private var _anualDistribution:Array; 
	
	// Berechnung
	private var _predictor:Predictor;
	private var _monthlyValues:Array;
	private var _avgPrice:Number;

	// Interval ID
	private var ivID:Number = -1;

	// Konstanten
	private var LSO_NAME:String = "EA_BAT";

	// -------------------------------------------------------------------

	// Event
	private var _event:EventBroadcaster;
	function addListener(o:Object) : Void { _event.addListener(o); }
	function removeListener(o:Object) : Void { _event.removeListener(o); }

	// -------------------------------------------------------------------
	
	function init() : Void
	{
		if (ivID>-1) clearInterval(ivID);
		ivID = -1;

		// default
		inputPanel.targetRevenue = 2000000;
		inputPanel.gamesPercentage = 89;
		inputPanel.stockTurn = 6;
		
		reset();
		update();
		inputPanel.updateView();

		_event.send("onInitialized",this);
	}

	// -------------------------------------------------------------------

	function onPublishersLoaded(sender,publishers,distribution) : Void
	{
		for (var i:Number=0; i<publishers.length; i++)
		{
			var publisher:PublisherData = publishers[i];

			var row:DataRow = table.addRow(i);
			row.no = i+1;
			row.publisher = publisher.name;
		}
		
		ivID = setInterval(this,"init",1000);

		_anualDistribution = distribution;
		_publishers = publishers;
		_predictor = new Predictor(_publishers);
	}

	function onValueChanged(sender:Object,stockTurnChanged:Boolean) : Void
	{
		if (stockTurnChanged===true) 
		{
			var avgTurn:Number = inputPanel.stockTurn;

			for (var i:Number=0; i<table.count; i++)
			{
				var row:DataRow = table.getRow(i);
				row.stockTurn = avgTurn;
			}
		}
		update();
	}
	
	function onClickPublisherInfo(sender:Object,index:Number)
	{
		publisherInfo.publisher = _publishers[index].name;
		publisherInfo.monthlyData = _monthlyValues[index];
	}

	function onClickSave(sender:Object) : Void
	{
		save();
	}

	function onClickLoad(sender:Object) : Void
	{
		load();
	}

	function onClickPrint(sender:Object) : Void
	{
		printData();
	}

	function onClickReset(sender:Object) : Void
	{
		reset();
	}

	function onClickUnitsInfo(sender:Object) : Void
	{
		unitsInfo.units = _predictor.calculateDailyUnits(inputPanel.targetRevenue, inputPanel.gamesPercentage * 0.01);
	}

	// -------------------------------------------------------------------

	function reset() : Void
	{
		var avgTurn:Number = inputPanel.stockTurn;

		for (var i:Number=0; i<table.count; i++)
		{
			var row:DataRow = table.getRow(i);
			row.stockTurn = avgTurn;
		}

		update();
	}

	function save() : Void
	{
		// speicherdialog
		ssCore.FileSys.fileSave({fileName:"daten.xml", caption:"Speichern Ihrer aktuellen Daten", path:"startdir://", filter:"XML Dateien|*.xml||"}, {callback:onSave, scope:this});
	}
	
	function onSave(returnObj:Object, callbackObj:Object, errorObj:Object ):Void
	{
		// pfad und dateiname
		var result:String = returnObj.result;
		ssDebug.trace("onSave: " + result);
		if (result != "") {
			// daten als xml speichern
			var conn:XMLConnector = new XMLConnector(null, null);
			// aktuelles datum
			var date:Date = new Date();
			// header
			var content:XML = conn.getXMLHead("ea_bat", {date : date.toLocaleString()});
			// daten
			var data:XMLNode = conn.getXMLNode("data", {revenue : inputPanel.targetRevenue, percentage : inputPanel.gamesPercentage, turn : inputPanel.stockTurn});
			// drehungen
			for (var i:Number=0; i<table.count; i++) {
				// datenzeile
				var row:DataRow = table.getRow(i);
				// drehung
				var turn:XMLNode = conn.getXMLNode("turn", {row:i});
				// aktueller wert
				turn.appendChild(content.createTextNode(row.stockTurn));
				// als xml
				data.appendChild(turn);
			}
			// daten in content
			content.firstChild.appendChild(data);
			// speichern
			ssCore.FileSys.writeToFile({path:result, data:content.toString()});
		}
	}
	
	function load():Void
	{
		// ladedialog
		ssCore.FileSys.fileOpen({caption:"Laden Ihrer gespeicherten Daten", path:"startdir://", filter:"XML Dateien|*.xml||"}, {callback:onLoad, scope:this});
	}
	
	function onLoad(returnObj:Object, callbackObj:Object, errorObj:Object ):Void
	{
		// pfad und dateiname
		var result:String = returnObj.result;
		// laden erfolgreich oder nicht
		var success:Boolean = false;
		// testen, ob datei existiert
		var existsObj = ssCore.FileSys.fileExists({path:result});
		// existiert
		if (existsObj.result == "TRUE") {
			// einlesen
			var readObj:Object = ssCore.FileSys.readFile({path:result});
			// content
			var content:String = readObj.result;
			// als xml
			var contentXML:XML = new XML();
			// parsen
			contentXML.parseXML(content);
			// erfolgreich oder nicht
			if (contentXML.status == 0) {
				// daten als xml verarbeiten
				var conn:XMLConnector = new XMLConnector(null, null);
				// data
				var dataXML:XMLNode = XMLHelper.nodeByName("data", contentXML.firstChild);
				// als object
				var dataObj:Object = conn.parseXMLNode(dataXML);
				// revenue
				inputPanel.targetRevenue = dataObj["revenue"];
				// percentage
				inputPanel.gamesPercentage = dataObj["percentage"];
				// turn
				inputPanel.stockTurn = dataObj["turn"];
				// einzelne drehungen
				var turns:Array = dataXML.childNodes;
				// schleife ueber drehungen
				for (var j : Number = 0; j < turns.length; j++) {
					// als xml
					var turnXML:XMLNode = turns[j];
					// zeilennummer
					var rownum:Number = Number(turnXML.attributes["row"]);
					// drehung
					var turn:Number = Number(turnXML.firstChild.nodeValue);
					// abbrechen, wenn keine zahlen
					if (isNaN(rownum) || isNaN(turn)) break;
					// zeile
					var row:DataRow = table.getRow(rownum);
					// drehung aktualisieren
					row.stockTurn = turn;
				}
				ssDebug.trace("onLoad: " + j + " # " + turns.length)
				// erfolgreich, wenn alle fehlerfrei durch
				if (j == turns.length) success = true;
			}
		}
		// bei erfolg neu berechnen, sonst fehlermeldung
		if (success) {
			update();
		} else {
			// TODO: fehlermeldung	
		}
	}

	function printData() : Void
	{
		// druckdialog oeffnen
		var printObj:Object = ssCore.Printer.showPrintDialog({});
		// drucken, wenn gewuenscht
		if (printObj.button == "PRINT") {
			// nach pause drucken, weil sonst druckdialog mit gedruckt wird
			var interval:Number;
			// druck function
			var doPrint:Function = function():Void {
				// interval loeschen
				clearInterval(interval);
				// druckparameter
				var paramsObj:Object = new Object;
				// x
				paramsObj["x"] = 25; // 155;
				// y
				paramsObj["y"] = 65;
				// width
				paramsObj["width"] = 900; // 770;
				// height
				paramsObj["height"] = 575;
				// fitToPage
				paramsObj["fitToPage"] = true;
				// drucken ohne dialog
				ssCore.Printer.printWindow(paramsObj);
			};
			// nach pause drucken
			interval = setInterval(doPrint, 2000);
		}
	}

	function update() : Void
	{
		var totalRevenue:Number = inputPanel.targetRevenue;
		var percentage:Number = inputPanel.gamesPercentage / 100;
		var avgTurn:Number = inputPanel.stockTurn;
		
		var i:Number;
		var stockTurns:Array = [];

		for (var i=0; i<table.count; i++)
		{
			var row:DataRow = table.getRow(i);
			stockTurns[i] = row.stockTurn;
		}
		
		var gamesRevenue:Number = totalRevenue*percentage;
		var predictions:Array = _predictor.compute(gamesRevenue,stockTurns,avgTurn);

		var total:Number = 0;
		for (var i=0; i<table.count; i++)
		{
			var result:ComputedValues = predictions[i];

			var row:DataRow = table.getRow(i);
			row.revenue = result.targetRevenue;
			row.stockValue = result.inStoreValue;
			row.reach = result.reach;
			row.result = result.realRevenue;

			total += result.realRevenue;
		}
		
		resultPanel.gamesTotal = gamesRevenue;
		resultPanel.realRevenue = 12 * total;
		resultPanel.diff = 12 * total - gamesRevenue;

		// --------------------------------------------

		_monthlyValues = [];
		for (var i=0; i<table.count; i++)
		{
			_monthlyValues[i] = _predictor.calculateMonthlyValues(_anualDistribution,predictions[i],avgTurn);
		}
	}
	
	// -------------------------------------------------------------------

	// Konstruktor
	function App()
	{
		_predictor = new Predictor();
		_avgPrice = 1;	
		_event = new EventBroadcaster();
	}
}