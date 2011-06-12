/* Rating
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Rating
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		29.06.2004
zuletzt bearbeitet:	07.07.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.trias.vkftool.data.Rating {

	// Attributes
	
	private var myParams:Object;
	
	private var myLoading:Object;
	
	private var myResult:Number;
	
	// Operations
	
	public  function Rating()
	{
		// parameter, die der user eintragen muss (skala von 0 - 100)
		myParams = {portfolio : -1, revenue : -1, grossprofit : -1, innovation : -1, salesforce : -1, promotion : -1, reputation : -1, consulting : -1, returns : -1};
		// gewichtung der parameter
		myLoading = {portfolio : 0.10, revenue : 0.15, grossprofit : 0.14, innovation : 0.12, salesforce : 0.09, promotion : 0.10, reputation : 0.11, consulting : 0.08, returns : 0.11};
		// gewichtetes durchschnittsergebnis der bewertung
		myResult = null;
	}
	
	public function get params():Object
	{
		// parameter, die der user eintragen muss
		return(myParams);
	}
	
	public function get result():Number
	{
		// gewichtetes durchschnittsergebnis der bewertung
		var res:Number = 0;
		// anzahl der parameter
		var count:Number = 0;
		// schleife ueber alle parameter
		for (var param:String in myParams) {
			// abbrechen, falls kein wert
			if (myParams[param] == -1) {
				// kein result
				return(null);
			}
			// gewichtet summieren
			res += (myParams[param] * myLoading[param]);
			// zaehlen
			count ++;
		}
		// gerundeter mittelwert
		res = Math.round(res);
		// result speichern
		myResult = res;
		// zurueck geben
		return(myResult);
	}

} /* end class Rating */
