/* Supplierlistitem
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplierlistitem
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

class com.adgamewonderland.trias.vkftool.input.Supplierlistitem extends MovieClip {

	// Attributes
	
	private var _myId:Number;
	
	private var mySupplier:Supplier;
	
	private var myState:String;
	
	private var isSelected:Boolean;
	
	private var myNumber:Number;
	
	private var number_txt:TextField, supplier_txt:TextField;
	
	private var add_btn:MovieClip, edit_btn:MovieClip, remove_btn:MovieClip;
	
	private var over_mc:MovieClip, back_mc:MovieClip;
	
	// Operations
	
	public  function Supplierlistitem()
	{
		// lieferant, der angezeigt wird
		supplier = new Supplier(null, "");
		// status
		state = "inactive"; // "active", "special"
		// ausgewaehlt oder nicht
		selected = false;
		// nummer in liste
		myNumber = _parent.registerSupplierlistitem(this, _myId);
		// nummer anzeigen
		number_txt.autoSize = "left";
		number_txt.text = (myNumber < 10 ? "0" : "") + myNumber + ".";
		
		// buttons initialisieren
		// hinzufuegen von suppliers
		add_btn.onRelease = function () {
			this._parent.onReleaseAdd();
		}
		// loeschen des suppliers
		remove_btn.onRelease = function () {
			this._parent.onReleaseRemove();
		}
		// auswaehlen des suppliers
		back_mc.onRollOver = function() {
			this._parent.onRollOverBack();
		}
		back_mc.onRollOut = function() {
			this._parent.onRollOutBack();
		}
		back_mc.onReleaseOutside = function() {
			this._parent.onReleaseOutsideBack();
		}
		back_mc.onRelease = function() {
			this._parent.onReleaseBack();
		}
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
		// activieren (sonderbehandlung fuer EA)
// 		state = (supp.id == 17 ? "special" : "active");
		state = (supp.integrity == true ? "complete" : "active"); 
		// name anzeigen
		supplier_txt.autoSize = "left";
		supplier_txt.text = supp.name;
	}
	
	public  function get state():String
	{
		// status
		return(myState);
	}
	
	public  function set state(str:String ):Void
	{
		// status
		myState = str;
		// verhalten und aussehen aendern
		switch (str) {
			// inactive
			case "inactive" :
				// hintergrund aendern
				back_mc.gotoAndStop("frInactive");
				// add einblenden
				add_btn._visible = true;
				// edit ausblenden
				edit_btn._visible = false;
				// remove ausblenden
				remove_btn._visible = false;
			
				break;
			// active
			case "active" :
				// hintergrund aendern
				back_mc.gotoAndStop("frActive");
				// add ausblenden
				add_btn._visible = false;
				// edit einblenden
				edit_btn._visible = true;
				// remove einblenden
				remove_btn._visible = true;
			
				break;
			// complete
			case "complete" :
				// hintergrund aendern
				back_mc.gotoAndStop("frComplete");
				// add ausblenden
				add_btn._visible = false;
				// edit einblenden
				edit_btn._visible = true;
				// remove einblenden
				remove_btn._visible = true;
			
				break;
		}
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
		// rahmen ein- / ausblenden
		over_mc._visible = bool;
	}
	
	private function onRollOverBack():Void
	{
		// rahmen einblenden, wenn nicht inaktiv
		if (state != "inactive") over_mc._visible = true;
	}
	
	private function onRollOutBack():Void
	{
		// ggf. rahmen ausblenden
		over_mc._visible = selected;
	}
	
	private function onReleaseOutsideBack():Void
	{
		// ggf. rahmen ausblenden
		onRollOutBack();
	}
	
	public function onReleaseBack():Void
	{
		// gilt nur fuer anklickbare
		if (state != "inactive" && selected == false) {
			// auswaehlen
			_parent.onSelectSupplier(myNumber, supplier.id);
		}
	}
	
	private function onReleaseAdd():Void
	{
		// supplier pool anzeigen
		_parent.showPool(true);
	}
	
	private function onReleaseRemove():Void
	{
		// supplier loeschen
		_parent.removeSupplier(myNumber, supplier.id);
	}

} /* end class Supplierlistitem */
