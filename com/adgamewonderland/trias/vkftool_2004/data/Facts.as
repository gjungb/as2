/* Facts
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Facts
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		29.06.2004
zuletzt bearbeitet:	14.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.data.Facts {

	// Attributes
	
	private var myParams:Object;
	
	private var myCalculation:Object;
	
	// Operations
	
	public  function Facts()
	{
		// parameter, die der user eintragen muss
		params = {revenue : "", revenue0309 : "", revenue0310 : "", revenue0311 : "", revenue0312 : "", intake : "", price : "", revenuesum : ""};
		// parameter, die im rahmen der analyse ausgerechnet werden
		calculation = {revenue : 0, revenue0309 : 0, revenue0310 : 0, revenue0311 : 0, revenue0312 : 0, intake : 0, price : 0, revenuesum : 0, outletranking : 0, revenuesumpercent : 0, softwarerevenuepercent : 0}; 
	}
	
	public function get params():Object
	{
		// parameter, die der user eintragen muss
		return(myParams);
	}
	
	public function set params(obj:Object ):Void
	{
		// parameter, die der user eintragen muss
		myParams = obj;
	}
	
	public function get calculation():Object
	{
		// parameter, die im rahmen der analyse ausgerechnet werden
		return(myCalculation);
	}
	
	public function set calculation(obj:Object ):Void
	{
		// parameter, die im rahmen der analyse ausgerechnet werden
		myCalculation = obj;
	}
	
	public function updateParams():Void
	{
		// summe der umsaetze im jahresendgeschaeft
		params.revenuesum = Number(params.revenue0309) + Number(params.revenue0310) + Number(params.revenue0311) + Number(params.revenue0312);
	}
	
	public function updateCalculationIntern(totalrevenue:Number ):Void
	{
		// summe der umsaetze im jahresendgeschaeft
		updateParams();
		
		// prozentualer anteil umsatz jahresendgeschaft am jahresumsatz
		calculation.revenuesumpercent = Math.round(params.revenuesum / params.revenue * 100 * 100) / 100;
		// prozentualer anteil umsatz am software gesamt umsatz
		calculation.softwarerevenuepercent = Math.round(params.revenue / totalrevenue * 100 * 100)  / 100;
	}
	
	public function updateCalculationExtern(sum:Object ):Void
	{
		// prozentuale anteile der parameter dieses suppliers relativ zu der summe der supplier
		for (var i:String in params) {
			// prozentanteil
			var percent:Number = Number(params[i]) / sum[i] * 100;
			// auf zwei stellen gerundet in kalkulation speichern
			calculation[i] = Math.round(percent * 100) / 100;
		}
	}
	

} /* end class Facts */
