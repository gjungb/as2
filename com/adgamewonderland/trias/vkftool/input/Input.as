/* Input
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Input
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	08.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Input extends MovieClip {

	// Attributes
	
	private var myDataconnector:Dataconnector;
	
	private var mySuppliers:Array;
	
	private var supplierlist_mc:Supplierlist, supplierinput_mc:Supplierinput, inputrevenue_mc:Inputrevenue, save_btn:MovieClip, leave_btn:MovieClip;
	
	// Operations
	
	public  function Input()
	{
		// dataconnector zum laden / speichern / aufbewahren aller relevanten daten
		myDataconnector = _root.getDataconnector();
		// suppliers
		mySuppliers = myDataconnector.suppliers;
	}
	
	public  function get suppliers():Array
	{
		// suppliers
		return(mySuppliers);
	}
	
	public  function saveInput():Void
	{
		// eingaben speichern (details zu suppliern werden ohnehin laufend auf den neuesten stand gebracht)
		myDataconnector.updateUserdata();
	}
	
	public  function leaveInput():Void
	{
		// speichern
		saveInput();
		// menue anzeigen
		_global.Menue.showContent("input_mc", 0);
	}
	
	public  function changeSupplier(id:Number ):Void
	{
		// anzeigen
		supplierinput_mc.showSupplier(mySuppliers[id]);
	}
	
	public function onEditSupplier():Void
	{
		// ausgewaehltes listitem updaten
		supplierlist_mc.updateSelected();
	}
	
	public function onChangeRevenue(param:String, num:Number ):Void
	{
		// gesamtumsatz speichern
		myDataconnector.revenue = num;
	}

} /* end class Input */
