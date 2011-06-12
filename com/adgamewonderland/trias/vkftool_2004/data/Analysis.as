/* Analysis
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Analysis
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		08.07.2004
zuletzt bearbeitet:	14.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

class com.adgamewonderland.trias.vkftool.data.Analysis {

	// Attributes
	
	private var myDataconnector:Dataconnector;
	
	private var mySuppliers:Array;
	
	// Operations
	
	public  function Analysis(dataconn:Dataconnector )
	{
		// dataconnector zum laden / speichern / aufbewahren aller relevanten daten
		myDataconnector = dataconn;
		// array mit suppliers, die komplett ausgefuellt sind
		mySuppliers = new Array();
	}
	
	public function get suppliers():Array
	{
		// array mit suppliers, die komplett ausgefuellt sind
		return (mySuppliers);
	}
	
	public function set suppliers(supparr:Array ):Void
	{
		// array mit suppliers, die komplett ausgefuellt sind
		mySuppliers = supparr;
	}
	
	public  function updateAnalysis():Void
	{
		// array mit suppliers, die komplett ausgefuellt sind
		suppliers = myDataconnector.getSuppliersByParam("integrity", true);
		// aktueller supplier in schleifen
		var supp:Supplier;
		// berechnungen fuer die einzelnen supplier durchfuehren lassen
		for (var i:String in suppliers) {
			// aktueller supplier
			supp = suppliers[i];
			// berechnen unter beruecksichtigung des gesamt software umsatzes
			supp.facts.updateCalculationIntern(myDataconnector.revenue);
		}
		
		// summen der parameter, die der user eintragen muss
		var sum:Object = {revenue : 0, revenue0309 : 0, revenue0310 : 0, revenue0311 : 0, revenue0312 : 0, revenuesum : 0, intake : 0, price : 0};
		// auf kopie der supplier weiter arbeiten
		var supparr:Array = suppliers;
		// sortieren nach umsatz im outlet
		supparr.sort(sortOnRevenue);
		// ranking vergeben, summenbildung fuer alle supplier
		for (var j:Number = 0; j < supparr.length; j ++) {
			// aktueller supplier
			supp = supparr[j];
			// ranking vergeben
			supp.facts.calculation.outletranking = j + 1;
			
			// schleife ueber parameter fuer summenbildung
			for (var k:String in supp.facts.params) {
				// summieren
				sum[k] += Number(supp.facts.params[k]);
			}
		}
		// berechnungen fuer die einzelnen supplier anhand der summen durchfuehren lassen
		for (var l:String in suppliers) {
			// aktueller supplier
			supp = suppliers[l];
			// berechnen unter beruecksichtigung der gebildeten summen
			supp.facts.updateCalculationExtern(sum);
		}
	}
	
	public function getSuppliers():Array
	{
		// array mit werten, die dargestellt werden sollen
		var values:Array = [];
		// komplett ausgefuellte supplier
		var supparr:Array = suppliers;
		// nach listenposition sortieren
		supparr.sort(sortOnListpos);
		// schleife ueber supplier
		for (var i:Number = 0; i < supparr.length; i ++) {
			// neuer wert
			var value = {pos : 0, name : "", id : 0};
			// position
			value.pos = (i + 1) + ".";
			// name
			value.name = supparr[i].name;
			// id
			value.id = supparr[i].id;
			
			// in werte array
			values.push(value);
		}
		// zurueck geben
		return values;
	}
	
	public function getValues(report:Number, id:Number ):Array
	{
		// array mit werten, die dargestellt werden sollen
		var values:Array = [];
		// komplett ausgefuellte supplier
		var supparr:Array = suppliers;
		
		// je nach report
		switch (report) {
		
			// report 3: subjektive lieferantenbewertung
			case 3 :
				// nach rating result sortieren
				supparr.sort(sortOnRatingResult);
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// neuer wert
					var value = {pos : 0, name : "", result : "0 %", resultvalue : 0};
					// position
					value.pos = (i + 1) + ".";
					// name
					value.name = supparr[i].name;
					// result
					value.result = supparr[i].rating.result + " %";
					
					// resultvalue
					value.resultvalue = supparr[i].rating.result;
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// report 4: lieferantenprofil
			case 4 :
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// aktueller supplier
					var supp:Supplier = supparr[i];
					// weiter machen, falls id nicht passt
					if (supp.id != id) continue;
					
					// neuer wert
					var value = {name : "", p_revenue : 0, p_revenue0309 : 0, p_revenue0310 : 0, p_revenue0311 : 0, p_revenue0312 : 0, p_intake : 0, p_price : 0, p_revenuesum : 0};
					// name
					value.name = supp.name;
					// schleife ueber alle parameter
					for (var j:String in supp.facts.params) {
						// in value speichern
						value["p_" + j] = getDottedValue(supp.facts.params[j]);
						 // bei waehrungen noch strich dran
						 if (j != "intake") value["p_" + j] += ",-";
					}
					// schleife ueber alle berechneten werte
					for (var k:String in supp.facts.calculation) {
						// in value speichern
						value["c_" + k] = supp.facts.calculation[k] + " %";
					}
					// ratingresult
					value.ratingresult = supparr[i].rating.result + " %";
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// report 5: umsatzranking markt / outlet
			case 5 :
				// nach marktanteil sortieren
				supparr.sort(sortOnMarketshare);
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// neuer wert
					var value = {name : "", ranking : 0, outletranking : 0, marketshare : 0, outletshare : 0};
					// name
					value.name = supparr[i].name;
					// ranking
					value.ranking = (supparr[i].ranking > 0 ? supparr[i].ranking : "-") + ".";
					// outletranking
					value.outletranking = "(" + supparr[i].facts.calculation.outletranking + ".)";
					
					// marketshare (prozentualer marktanteil aus csv-datei)
					value.marketshare = supparr[i].marketshare;
					// outletshare (prozentualer anteil des umsatzes des suppliers)
					value.outletshare = supparr[i].facts.calculation.revenue;
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// report 6: vergleich umsatz / stueckzahl
			case 6 :
				// nach umsatz im outlet im jahresendgeschaeft sortieren
				supparr.sort(sortOnRevenueSum);
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// neuer wert
					var value = {pos : 0, name : "", revenue : 0, intake : 0, outletshare : 0, intakeshare : 0, sharediff : 0};
					// position
					value.pos = (i + 1) + ".";
					// name
					value.name = supparr[i].name;
					// revenue
					value.revenue = getDottedValue(supparr[i].facts.params.revenuesum) + ",-";
					// intake
					value.intake = getDottedValue(supparr[i].facts.params.intake);
					
					// outletshare (prozentualer anteil des umsatzes des suppliers)
					value.outletshare = supparr[i].facts.calculation.revenuesum;
					// intakeshare (prozentualer anteil der stueckzahlen des suppliers)
					value.intakeshare = supparr[i].facts.calculation.intake;
					// sharediff (differenz der prozentualen anteile) auf zwei stellen gerundet
					value.sharediff = Math.round((value.outletshare - value.intakeshare) * 100) / 100;
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// report 7: vergleich umsatz / summe ek
			case 7 :
				// nach umsatz im outlet im jahresendgeschaeft sortieren
				supparr.sort(sortOnRevenueSum);
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// neuer wert
					var value = {pos : 0, name : "", revenue : 0, price : 0, outletshare : 0, priceshare : 0, sharediff : 0};
					// position
					value.pos = (i + 1) + ".";
					// name
					value.name = supparr[i].name;
					// revenue
					value.revenue = getDottedValue(supparr[i].facts.params.revenuesum) + ",-";
					// price
					value.price = getDottedValue(supparr[i].facts.params.price) + ",-";
					
					// outletshare (prozentualer anteil des umsatzes des suppliers)
					value.outletshare = supparr[i].facts.calculation.revenuesum;
					// priceshare (prozentualer anteil der einkaufssumme des suppliers)
					value.priceshare = supparr[i].facts.calculation.price;
					// sharediff (differenz der prozentualen anteile) auf zwei stellen gerundet
					value.sharediff = Math.round((value.outletshare - value.priceshare) * 100) / 100;
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// report 8: vergleich umsatz / summe ek / stueckzahl
			case 8 :
				// nach umsatz im outlet im jahresendgeschaeft sortieren
				supparr.sort(sortOnRevenueSum);
				// schleife ueber supplier
				for (var i:Number = 0; i < supparr.length; i ++) {
					// neuer wert
					var value = {pos : 0, name : "", revenue : 0, price : 0, intake : 0, revenuevalue : 0, pricevalue : 0, intakevalue : 0};
					// position
					value.pos = (i + 1) + ".";
					// name
					value.name = supparr[i].name;
					// revenue
					value.revenue = getDottedValue(supparr[i].facts.params.revenuesum) + ",-";
					// price
					value.price = getDottedValue(supparr[i].facts.params.price) + ",-";
					// intake
					value.intake = getDottedValue(supparr[i].facts.params.intake);
					
					// revenue
					value.revenuevalue = supparr[i].facts.params.revenuesum;
					// price
					value.pricevalue = supparr[i].facts.params.price;
					// intake
					value.intakevalue = supparr[i].facts.params.intake;
					
					// in werte array
					values.push(value);
				}
				
				break;
		
			// noch nicht implementiert
			default :
			
				break;
		
		}
		// zurueck geben
		return values;
	}
	
	private function sortOnRatingResult(supp1:Supplier, supp2:Supplier):Number
	{
		// rating result vergleichen
		return (supp2.rating.result - supp1.rating.result);
	}
	
	private function sortOnListpos(supp1:Supplier, supp2:Supplier):Number
	{
		// listenposition aus inputlist vergleichen
		return (supp1.listpos - supp2.listpos);
	}
	
	private function sortOnMarketshare(supp1:Supplier, supp2:Supplier):Number
	{
		// marktanteil vergleichen
		return (supp2.marketshare - supp1.marketshare);
	}
	
	private function sortOnRevenue(supp1:Supplier, supp2:Supplier):Number
	{
		// revenue vergleichen
		return (supp2.facts.params.revenue - supp1.facts.params.revenue);
	}
	
	private function sortOnRevenueSum(supp1:Supplier, supp2:Supplier):Number
	{
		// revenue im jahresendgeschaeft vergleichen
		return (supp2.facts.params.revenuesum - supp1.facts.params.revenuesum);
	}
	
	private function getDottedValue(num:Number ):String
	{
		// in string umwandeln
		var newval:String = String(num);
		// formatieren
		var formval:String = "";
		// rueckwaertsschleife ueber wert, um tausenderpunkte einuzfügen
		var dotcount:Number = 0;
		for (var i:Number = newval.length - 1; i >= 0; i --) {
			// aktuelle ziffer anhaengen
			formval =  newval.substr(i, 1) + formval;
			// alle 3 ziffern ein punkt (ausser ganz links)
			if (++dotcount % 3 == 0 && i > 0) formval = "." + formval;
		}
		// zurueck geben
		return formval;
	}

} /* end class Analysis */
