/* Supplierpoolitem
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplierpoolitem
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		02.07.2004
zuletzt bearbeitet:	06.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Supplierpoolitem extends MovieClip {

	// Attributes
	
	private var _mySupplier:Supplier, mySupplier:Supplier;
	
	private var isSelected:Boolean;
	
	private var number_txt:TextField, supplier_txt:TextField;
	
	// Operations
	
	public  function Supplierpoolitem()
	{
		// lieferant, der angezeigt wird (im constructor uebergeben)
		supplier = _mySupplier;
		// ausgewaehlt oder nicht
		selected = false;
	}
	
	public  function get supplier():Supplier
	{
		// lieferant, der angezeigt wird
		return(mySupplier);
	}
	
	public  function set supplier(supp:Supplier ):Void
	{
		// lieferant, der angezeigt wird
		mySupplier = supp;
// 		// activieren (sonderbehandlung fuer EA)
// 		selected = (supp.id == 17 ? true : false);
		// nicht ausgewaehlt
// 		selected = false;
		// nummer anzeigen
		number_txt.autoSize = "left";
		number_txt.text = (supp.id < 10 ? "0" : "") + supp.id + ".";
		// name anzeigen
		supplier_txt.autoSize = "left";
		supplier_txt.text = supp.name;
	}
	
	public  function get selected():Boolean
	{
		// ausgewaehlt oder nicht
		return(isSelected);
	}
	
	public  function set selected(bool:Boolean ):Void
	{
		// ausgewaehlt oder nicht
		isSelected = bool;
		// auswaehlbar oder nicht
		enabled = !bool;
		// alpha umschalten
		_alpha = (bool ? 50 : 100);
	}
	
	private function onRelease():Void
	{
		// gilt nur fuer anklickbare
		if (selected == false) {
			// speichern, ob ausgewaehlt
// 			selected = _parent._parent._parent.addSupplier(supplier.id);
			_parent._parent._parent.addSupplier(supplier.id);
		}
	}

} /* end class Supplierpoolitem */
