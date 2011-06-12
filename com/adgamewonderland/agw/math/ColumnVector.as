/* 
 * Generated by ASDT 
*/ 

class com.adgamewonderland.agw.math.ColumnVector {
	
	private var myElements:Array;
	
	private var myLength:Number;
	
	public function ColumnVector()
	{
		// elemente des spalten-vektors
		myElements = new Array();
		// schleife ueber alle argumente
		for (var i:Number = 0; i < arguments.length; i++)
		{
			// wert speichern
			addElement(arguments[i]);
		}
		// anzahl der elemente
		myLength = myElements.length;
	}
	
	public function get length():Number
	{
		// anzahl der elemente
		return myElements.length;
	}
	
	public function addElement(val:Number ):Void
	{
		// wert speichern
		myElements.push(val);
	}
	
	public function getElements():Array
	{
		// elemente des spalten-vektors
		return myElements;
	}
	
	public function getElement(row:Number ):Number
	{
		// element in uebergebener zeile (1-basiert)
		return myElements[row - 1];
	}
}