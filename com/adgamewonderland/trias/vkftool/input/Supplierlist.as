/* Supplierlist
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplierlist
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	14.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.*

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Supplierlist extends MovieClip {

	// Attributes
	
	private var myDataconnector:Dataconnector;
	
	private var myListitems:Array;
	
	private var mySuppliers:Array;
	
	private var myNumSuppliers:Number;
	
	private var mySelected:Supplierlistitem;
	
	private var supplierpool_mc:MovieClip, blind_mc:MovieClip;
	
	// Operations
	
	public  function Supplierlist()
	{
		// dataconnector zum laden / speichern / aufbewahren aller relevanten daten
		myDataconnector = _root.getDataconnector();
		// listitems auf buehne (registrieren sich)
		myListitems = [];
		// suppliers
		mySuppliers = _parent.suppliers;
		// anzahl der supplier in der liste
		myNumSuppliers = 0;
		// ausgewaehltes listitem
		mySelected = null;
	}
	
	public  function registerSupplierlistitem(mc:Supplierlistitem, id:Number ):Number
	{
		// nummer aus instanzname
		var num:Number = Number(mc._name.substring(mc._name.indexOf("m") + 1, mc._name.indexOf("_")));
		// in array schreiben
		myListitems[num] = mc;
		
		// testen, ob erster start
		if (myDataconnector.firstrun == true) {
			// supplier entsprechend uebergebener id aus komponentenparameter hinzufuegen
			if (id != 0) addSupplier(id);
		// gespeicherte daten vorhanden 
		} else {
			// supplier an dieser position
			var supp:Supplier = myDataconnector.getSupplierByParam("listpos", num);
			// hinzufuegen
			if (supp.listpos > 0) addSupplier(supp.id);
		}
		
		// oberen supplier auswaehlen
		myListitems[1].onReleaseBack();
		
		// zurueck geben
		return (num);
	}
	
	public  function onSelectSupplier(num:Number, id:Number):Void
	{
		// bisher ausgewaehltes abwaehlen
		mySelected.selected = false;
		// ausgewaehltes merken
		mySelected = myListitems[num];
		// speichern, dass ausgewaehlt
		mySelected.selected = true;
		// daten anzeigen lassen
		_parent.changeSupplier(id);
	}
	
	public  function showPool(bool:Boolean ):Void
	{
		// ein / ausblenden
		switch (bool) {
			// einblenden
			case true :
				// abbrechen, falls supplierpool schon eingeblendet
				if (supplierpool_mc.active == true) return;
				// reinfahren
				gotoAndPlay("frIn");
				// aktiv schalten
				supplierpool_mc.active = true;
				// blende reinfahren (zeigt unsichtbaren button an)
				blind_mc.gotoAndPlay("frIn");
			
				break;
			// ausblenden
			case false :
				// rausfahren
				gotoAndPlay("frOut");
				// inaktiv schalten
				supplierpool_mc.active = false;
				// blende rausfahren
				blind_mc.gotoAndPlay("frOut");
			
				break;
		}
	}
	
	public function addSupplier(id:Number ):Boolean
	{
		// abbrechen, falls liste voll
		if (myNumSuppliers == myListitems.length - 1) return (false);
		// hochzaehlen
		myNumSuppliers++;
		// uebergeben
		myListitems[myNumSuppliers].supplier = mySuppliers[id];
		// speichern, dass vom user ausgewaehlt
		mySuppliers[id].listpos = myNumSuppliers;
		// in pool auf ausgewaehlt schalten
		supplierpool_mc.setItemSelected(id, true);
		// auswaehlen
		myListitems[myNumSuppliers].onReleaseBack();
		// auswaehlen erlaubt
		return (true);
	}
	
	public function updateSelected():Void
	{
		// auf vollstaendigkeit der eingaben pruefen
		mySelected.supplier.checkIntegrity();
		// status umschalten
		mySelected.state = (mySelected.supplier.integrity == true ? "complete" : "active");
	}
	
	public function removeSupplier(num:Number, id:Number ):Void
	{
		// speichern, dass nicht vom user ausgewaehlt
		mySuppliers[id].listpos = 0;
		// auf vollstaendigkeit der eingaben pruefen
		mySuppliers[id].checkIntegrity();
		// in pool auf nicht ausgewaehlt schalten
		supplierpool_mc.setItemSelected(id, false);
		// schleife, um items von unten nach oben aufzufuellen
		for (var i:Number = num; i < myNumSuppliers; i++) {
			// supplier verschieben
			myListitems[i].supplier = myListitems[i + 1].supplier;
			// neue position speichern
			myListitems[i].supplier.listpos = i;
		}
		// unteren supplier leeren
		myListitems[myNumSuppliers].supplier = new Supplier(null, "");
		// und deaktivieren
		myListitems[myNumSuppliers].state = "inactive";
		// runterzaehlen
		myNumSuppliers--;
		// obersten auswaehlen
		myListitems[1].onReleaseBack();
	}
	
	private function getItemById(id:Number ):Supplierlistitem
	{
		// schleife ueber alle listitems
		for (var i in myListitems) {
			// zurueck geben, wenn passende id gefunden
			if (myListitems[i].supplier.id == id) return (myListitems[i]);
		}
		// nix gefunden
		return (null);
	}

} /* end class Supplierlist */
