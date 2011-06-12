/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.controls.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

import com.adgamewonderland.sskddorf.mischpult.ui.*;

class com.adgamewonderland.sskddorf.mischpult.ui.WeightingUI extends MovieClip {
	
	private var headline_txt:TextField;
	
	private var slider1_mc:HSlider;
	
	private var slider2_mc:HSlider;
	
	private var slider3_mc:HSlider;
	
	private var sliders:Array;
	
	public function WeightingUI() {
		// slider
		this.sliders = new Array(slider1_mc, slider2_mc, slider3_mc);
	}
	
	public function init():Void
	{
		// als listener bei allen controls registrieren
		slider1_mc.addListener(this);
		slider2_mc.addListener(this);
		slider3_mc.addListener(this);
	}
	
	public function onUserInputChanged():Void
	{
		// eingaben des users
		var userinput:UserInput = DataProvider.getInstance().getUserinput();
		// schleife ueber produktkategorien
		for (var i:Number = 1; i <= DataProvider.getInstance().getNumProduktkategorien(); i++) {
			// aktuelle produktkategorie
			var produktkategorie:Produktkategorie = DataProvider.getInstance().getProduktkategorieByID(i);
			// gewichtung aus datenbank
			var gewichtung:Gewichtung = DataCalculator.getInstance().getGewichtung(userinput, produktkategorie);
			// entsprechende summe
			var summe:Number = Math.round(userinput.getPlanungssumme().getSummeact() * gewichtung.getWert());
			// speichern
			getWeighting().setSummeByProduktkategorie(produktkategorie, summe);
		}
		// alles neu berechnen
		updateWeighting(true);
	}
	
	public function onValueChanged(caller:HSlider, value:Number, oldval:Number ):Void
	{
		// abbrechen, wenn nicht bewegt
//		if (value == oldval) return;
		// abweichung zur planungssumme
		var cdiff:Number = DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact() - getSliderSum(null);
		// richtung, in die der caller bewegt wurde
		var direction:Number = (value - oldval) / Math.abs((value - oldval));
		// slider, die bewegt werden duerfen
		var movables:Array = getMovableSliders(caller, -direction);
		// anzahl slider, die bewegt werden duerfen
		var nummovables:Number = movables.length;
		// verbleibender betrag, um die die slider noch bewegt werden muessen
		var sumremains:Number = cdiff;
		// aktueller slider
		var slider:HSlider;
//		trace("direction: " + direction + ", nummovables: " + nummovables + ", sumremains: " + sumremains);
		// je nach anzahl
		switch (nummovables) {
			// keiner
			case 0 :
				// caller festsetzen
				caller.value = DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact() - getSliderSum(caller);
			
				break;

			// einer
			case 1 :
				// slider
				slider = movables[0];
				// je nach richtung
				if (-direction == 1) {
					// nach rechts
					slider.moveValueBy(sumremains);
					
				} else if (-direction == -1) {
					// nach links
					slider.moveValueBy(sumremains);
					
				}
			
				break;	
				
			// zwei
			case 2 :
				// sortieren, so dass slider mit niedrigerem wert zuerst behandelt wird
				var sortfn:Function = function(s1:HSlider, s2:HSlider ):Number {
					if (s1.value < s2.value) {
						return -1;
					} else if (s1.value > s2.value) {
						return 1;	
					} else {
						return 0;
					}
				};
				movables.sort(sortfn, Array.NUMERIC);
				// schleife ueber beide
				for (var i:Number = 0; i < movables.length; i++) {
					// slider
					slider = movables[i];
					// betrag, um den der slider bewegt werden soll
					var sdiff:Number;
					// erster
					if (i == 0) {
						// halbieren unter beruecksichtigung gerade / ungerade
						sdiff = (sumremains - (sumremains % 2)) / 2;
						// je nach richtung
						if (-direction == 1) {
							// nach rechts
							slider.moveValueBy(sdiff);
							
						} else if (-direction == -1) {
							// maximal bis 0 bewegen, restbetrag fuer zweiten beruecksichtigen
							if (Math.abs(sdiff) >= slider.value) sdiff = -slider.value;
							// nach links
							slider.moveValueBy(sdiff);
							
						}
						// betrag fuer zweiten
						sumremains -= sdiff;
					}
					// zweiter
					if (i == 1) {
						// verbleibender betrag
						sdiff = sumremains;
						// je nach richtung
						if (-direction == 1) {
							// nach rechts
							slider.moveValueBy(sdiff);
							
						} else if (-direction == -1) {
							// nach links
							slider.moveValueBy(sdiff);
							
						}
					}
				}
			
				break;
		}
		// caller festsetzen
		if (getSliderSum(null) - DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact() != 0) {
			caller.value = DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact() - getSliderSum(caller);
		}
//		trace(getSliderSum(null) - DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact());
		// schleife ueber produktkategorien
		for (var i:Number = 1; i <= DataProvider.getInstance().getNumProduktkategorien(); i++) {
			// aktuelle produktkategorie
			var produktkategorie:Produktkategorie = DataProvider.getInstance().getProduktkategorieByID(i);
			// entsprechender slider
			var slider:HSlider = getSlider(produktkategorie);
			// summe speichern
			getWeighting().setSummeByProduktkategorie(produktkategorie, slider.value);
		}
		// alles neu berechnen
		updateWeighting(false);
	}
	
	public function onValueChanged2(caller:HSlider, value:Number, oldval:Number ):Void
	{
		// abweichung zur planungssumme
		var cdiff:Number = getSliderSum(null) - DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact();
		// anzahl nicht gelockter slider (abzgl. des callers)
		var numunlocked:Number = getNumUnlockedSliders() - (value > 0 ? 1 : 0);
		if (numunlocked == 0) numunlocked = 1;
		// auf die nicht gelockten slider zu verteilende summe
		var sumremains:Number = -cdiff / numunlocked;
		// noch verfuegbare summen, um die die nicht bewegten slider vermindert werden koennen
		var slidervalues:Array = getSliderValues(caller);
		// noch verfuegbare gesamtsumme der nicht bewegten slider
		var slidersum:Number = 0;
		// schleife uber noch verfuegbare summen
		for (var j:String in slidervalues) {
			// summieren
			slidersum += slidervalues[j].sum;
		}
		// zu veraendernder slider
		var slider:HSlider;
		
		// DEBUG: welcher fall tritt ein
		var fall:Number = 0;
		// bewegter slider wurde erhoeht
		if (cdiff > 0){
			// ist die noch verfuegbare gesamtsumme der nicht bewegten slider gross genug
			if (slidersum > cdiff) {
				fall = 1;
				// nicht bewegte slider vermindern
				for (var k:String in slidervalues) {
					// aktueller slider
					slider = slidervalues[k].slider;
					// wenn nicht gelockt und nicht auf 0, bewegen
					if (!slider.isLocked() && slider.value > 0) {
						// bewegen und ggf. ueberschuss fuer naechsten addieren
						slider.moveValueBy(sumremains); // sumremains += 
					}
				}	
				
			} else {
				fall = 2;
				// maximalwert, den der caller haben darf
				var callermax:Number = caller.value;
				// nicht bewegte slider vermindern
				for (var l:String in slidervalues) {
					// aktueller slider
					slider = slidervalues[l].slider;
					// wenn nicht gelockt und nicht auf 0, bewegen
					if (!slider.isLocked() && slider.value > 0) {
						// slider bewegen
						slider.moveValueBy(sumremains);
					}
				}
				// bewegten slider auf fuer ihn maximalen wert (differenz zwischen planungssumme und summe der anderen slider
				caller.value = DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact() - getSliderSum(caller);
			}
				
		// bewegter slider wurde vermindert
		} else {
			fall = 3;
			// nicht bewegte slider erhoehen
			for (var m:String in slidervalues) {
				// aktueller slider
				slider = slidervalues[m].slider;
				// wenn nicht gelockt, bewegen
				if (!slider.isLocked()) slider.moveValueBy(sumremains);
			}
		}
		// abweichung zur planungssumme
		var sdiff:Number = getSliderSum(null) - DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact();
		// ggf. korrigieren
		if (Math.abs(sdiff) == 1) {
			// DEBUG
//			trace("fall: " + fall + ", sumremains: " + sumremains + ", sdiff: " + sdiff);
			// schleife ueber slider
			for (var o:String in this.sliders) {
				// aktueller slider
				slider = this.sliders[o];
				// nur nicht gelockte slider
				if (slider.isLocked()) continue;
				// caller ueberspringen
				if (slider == caller) continue;
				// korrigieren
				if (sdiff == -1) {
					if (slider.value < slider.maximum) {
						trace(slider);
						slider.value += 1;
						break;	
					}
				} else if (sdiff == 1) {
					if (slider.value > 0) {
						trace(slider);
						slider.value -= 1;
						break;	
					}
				}
			}
		}
		// DEBUG: planungssumme exakt erreicht
//		trace(getSliderSum(null) - DataProvider.getInstance().getUserinput().getPlanungssumme().getSummeact());

		// schleife ueber produktkategorien
		for (var i:Number = 1; i <= DataProvider.getInstance().getNumProduktkategorien(); i++) {
			// aktuelle produktkategorie
			var produktkategorie:Produktkategorie = DataProvider.getInstance().getProduktkategorieByID(i);
			// entsprechender slider
			var slider:HSlider = getSlider(produktkategorie);
			// summe speichern
			getWeighting().setSummeByProduktkategorie(produktkategorie, slider.value);
		}
		// alles neu berechnen
		updateWeighting(false);
	}
	
	public function onLock(caller:HSlider ):Void
	{
		// alle anderen slider unlocken
		for (var j : String in sliders) {
			if (sliders[j] != caller) sliders[j].unlock();
		}	
	}
	
	public function updateWeighting(movesliders:Boolean ):Void
	{
		// eingaben des users
		var userinput:UserInput = DataProvider.getInstance().getUserinput();
		// schleife ueber produktkategorien
		for (var i:Number = 1; i <= DataProvider.getInstance().getNumProduktkategorien(); i++) {
			// aktuelle produktkategorie
			var produktkategorie:Produktkategorie = DataProvider.getInstance().getProduktkategorieByID(i);
			// entsprechende summe
			var summe:Number = getWeighting().getSummeByProduktkategorie(produktkategorie);
			
			// slider neu positionieren
			if (movesliders) {
				// entsprechender slider
				var slider:HSlider = getSlider(produktkategorie);
				// nicht gelockt
				slider.unlock();
				// maximum auf aktuelle planungssumme setzen
				slider.maximum = userinput.getPlanungssumme().getSummeact();
				// wert anzeigen
				slider.value = summe;
			}
		}
		// headline aendern
		headline_txt.text = (movesliders ? "Unsere Empfehlung" : "Ihre Auswahl");
		
		// TODO: event handling
		var mc:ProductsUI = ProductsUI(_parent.products_mc);
		mc.onProductsChanged();
	}

	public function getWeighting():Weighting {
		return DataProvider.getInstance().getWeighting();
	}

	public function getSliders():Array {
		return sliders;
	}
	
	private function getSlider(produktkategorie:Produktkategorie ):HSlider
	{
		return (this.sliders[produktkategorie.getID() - 1]);
	}
	
	private function getMovableSliders(caller:HSlider, direction:Number ):Array
	{
		// slider, die in uebergebene richtung bewegt werden koennen
		var movables:Array = [];
		// schleife ueber slider
		for (var i:Number = 0; i < this.sliders.length; i++) {
			// aktueller slider
			var slider:HSlider = this.sliders[i];
			// caller ueberspringen
			if (slider == caller) continue;
			// gelockten slider ueberspringen
			if (slider.isLocked()) continue;
			// je nach richtung
			switch (direction) {
				// vermindern
				case -1 :
					// hinzufuegen, wenn nicht ganz links
					if (slider.value > 0) movables.push(slider);
				
					break;	
				// erhoehen
				case 1 :
					// hinzufuegen, wenn nicht ganz rechts
					if (slider.value < slider.maximum) movables.push(slider);
				
					break;
				// unbekannt
				default :
					trace("getMovableSliders, direction unbekannt");
					break;
			}
		}
		
		// zurueck geben
		return movables;
	}
	
	private function getUnlockedSliders():Array
	{
		// nicht gelockte slider
		var unlocked:Array = [];
		// slider hinzufuegen, wenn nicht gelockt
		for (var i:String in this.sliders) {
			if (!this.sliders[i].isLocked() && this.sliders[i].value > 0) unlocked.push(this.sliders[i]); //  
		}
		// zurueck geben
		return unlocked;
	}
	
	private function getNumUnlockedSliders():Number
	{
		// anzahl nicht gelockter slider
		return getUnlockedSliders().length;	
	}
	
	private function getSliderValues(caller:HSlider ):Array
	{
		// noch verfuegbare summen, um die die nicht bewegten slider vermindert werden koennen
		var slidervalues:Array = [];
		// schleife ueber alle slider
		for (var i:String in this.sliders) {
			// aktueller slider
			var slider:HSlider = this.sliders[i];
			// caller ueberspringen
			if (slider == caller) continue;
			// summe, um die aktueller slider vermindert werden kann
			var sum:Number;
			// gelockt / nicht gelockt
			if (slider.isLocked()) {
				sum = 0;
			} else {
				sum = slider.value;
			}
			// als anonymes object
			slidervalues.push({slider : slider, sum : sum});
		}
		// zurueck geben
		return slidervalues;
	}
	
	private function getSliderSum(caller:HSlider ):Number
	{
		// summe der aktuellen werte aller slider
		var slidersum:Number = 0;
		// schleife ueber alle slider
		for (var i:String in this.sliders) {
			// aktueller slider
			var slider:HSlider = this.sliders[i];
			// caller ueberspringen
			if (slider == caller) continue;
			// summieren
			slidersum += slider.value;
		}
		
		// zurueck geben
		return slidersum;
	}

}