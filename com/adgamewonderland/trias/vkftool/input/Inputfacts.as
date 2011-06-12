/* Inputfacts
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputfacts
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		30.06.2004
zuletzt bearbeitet:	05.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Inputfacts extends MovieClip {

	// Attributes
	
	private var myInputfields:Object;
	
	private var headline_txt:TextField;
	
	private var inputfield1_mc:Inputfield, inputfield2_mc:Inputfield, inputfield3_mc:Inputfield, inputfield4_mc:Inputfield, inputfield5_mc:Inputfield, inputfield6_mc:Inputfield, inputfield7_mc:Inputfield;
	
	// Operations
	
	public  function Inputfacts()
	{
		// eingabefelder (parameter siehe Facts)
		myInputfields = {};
	}
	
	public  function registerInputfield(mc:Inputfield, param:String ):Void
	{
		// entsprechend parameter (siehe Facts) in object schreiben
		myInputfields[param] = mc;
	}
	
	public  function showFacts(name:String, facts:Facts ):Void
	{
		// linksbuendig
		headline_txt.autoSize = "left";
		// headline
		headline_txt.text = name;
		// schleife ueber parameter der facts
		for (var param in facts.params) {
			// entsprechendes eingabefeld
			var field:Inputfield = myInputfields[param];
			// anzeigen lassen
			field.value = facts.params[param];
		}
	}

} /* end class Inputfacts */
