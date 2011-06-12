/* Supplierinput
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Supplierinput
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	07.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Supplierinput extends MovieClip {

	// Attributes
	
	private var mySupplier:Supplier;
	
	private var isActive:Boolean;
	
	private var inputfacts_mc:Inputfacts;
	
	private var inputcomment_mc:Inputcomment;
	
	private var inputrating_mc:Inputrating;
	
	// Operations
	
	public  function Supplierinput()
	{
		// lieferant, der aktuell angezeit / bearbeitet wird
		mySupplier = new Supplier(null, "");
		// erst mal inaktiv
		active = false;
	}
	
	public function set active(bool:Boolean ):Void
	{
		// aktivitaet umschalten
		isActive = bool;
	}
	
	public function get active():Boolean
	{
		// zurueck geben
		return (isActive);
	}
	
	public function showSupplier(supp:Supplier ):Void
	{
		// speichern
		mySupplier = supp;
		// facts anzeigen
		inputfacts_mc.showFacts(mySupplier.name, mySupplier.facts);
		// comment anzeigen
		inputcomment_mc.value = mySupplier.comment;
		// rating anzeigen
		inputrating_mc.showRating(mySupplier);
	}
	
	public function onChangeFacts(param:String, num:Number ):Void
	{
		// in string umwandeln
		var value:String = (num != null ? String(num) : "");
		// speichern
		mySupplier.facts.params[param] = value;
		// supplier wurde geaendert
		_parent.onEditSupplier();
	}
	
	public function onChangeComment(str:String ):Void
	{
		// speichern
		mySupplier.comment = str;
		// supplier wurde geaendert
		_parent.onEditSupplier();
	}
	
	public function onChangeRating(param:String, num:Number ):Void
	{
		// speichern
		mySupplier.rating.params[param] = num;
		// supplier wurde geaendert
		_parent.onEditSupplier();
	}

} /* end class Supplierinput */
