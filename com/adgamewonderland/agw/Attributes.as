/* Attributes
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Attributes
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		28.11.2003
zuletzt bearbeitet:	30.11.2003
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.agw.Attributes{

  // Attributes

  public var myValues:Object;

  // Operations

  public  function Attributes(){
	myValues = new Object();
  }

  public  function setValue(tag:String , value):Void {
	// speichern
	myValues[tag] = value;
  }

  public  function getValue(tag:String ) {
	// zurueck geben
	return (myValues[tag]);
  }

  public  function getAllValues():Object {
	// zurueck geben
	return (myValues);
  }

} /* end class Attributes */
