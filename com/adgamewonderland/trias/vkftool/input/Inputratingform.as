/* Inputratingform
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Inputratingform
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		07.07.2004
zuletzt bearbeitet:	07.07.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.trias.vkftool.data.*

import com.adgamewonderland.trias.vkftool.input.*

class com.adgamewonderland.trias.vkftool.input.Inputratingform extends MovieClip {

	// Attributes
	
	private var myInputscales:Object;
	
	private var headline_txt:TextField;
	
	private var close_btn:MovieClip;
	
	private var inputscale1_mc:Inputscale, inputscale2_mc:Inputscale, inputscale3_mc:Inputscale, inputscale4_mc:Inputscale, inputscale5_mc:Inputscale, inputscale6_mc:Inputscale, inputscale7_mc:Inputscale, inputscale8_mc:Inputscale, inputscale9_mc:Inputscale;
	
	// Operations
	
	public  function Inputratingform()
	{
		// eingabefelder (parameter siehe Rating)
		myInputscales = {};
		// button aktivieren
		close_btn.onRelease = function () {
			// schliessen
			this._parent._parent.showForm(false);
		}
	}
	
	public  function registerInputscale(mc:Inputscale, param:String ):Void
	{
		// entsprechend parameter (siehe Rating) in object schreiben
		myInputscales[param] = mc;
	}
	
	public  function showRating(name:String, rating:Rating ):Void
	{
		// linksbuendig
		headline_txt.autoSize = "left";
		// headline
		headline_txt.text = name;
		// schleife ueber parameter der rating
		for (var param in rating.params) {
			// entsprechendes eingabefeld
			var scale:Inputscale = myInputscales[param];
			// anzeigen lassen
			scale.value = rating.params[param];
		}
	}

} /* end class Inputratingform */
