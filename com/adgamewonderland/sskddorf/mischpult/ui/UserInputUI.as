/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.controls.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

import com.adgamewonderland.sskddorf.mischpult.ui.*;

class com.adgamewonderland.sskddorf.mischpult.ui.UserInputUI extends MovieClip {
	
	private var familienstand_mc:Dial;
	
	private var lebensphase_mc:Dial;
	
	private var einkommen_mc:RoundKnob;
	
	private var wohnkosten_mc:RoundKnob;
	
	private var wohnsituation_mc:RadioChoice;
	
	private var sonstigekosten_mc:RoundKnob;
	
	private var verfuegung_mc:RoundKnobAvailable;
	
	public function UserInputUI() {
	}
	
	public function init():Void
	{
		// als listener bei allen controls registrieren
		familienstand_mc.addListener(this);
		lebensphase_mc.addListener(this);
		einkommen_mc.addListener(this);
		wohnkosten_mc.addListener(this);
		wohnsituation_mc.addListener(this);
		sonstigekosten_mc.addListener(this);
		verfuegung_mc.addListener(this);
		// TODO: wer bestimmt den ausgangszustand? 1: komponenten, 2: UserInput
		familienstand_mc.onValueChanged();
		lebensphase_mc.onValueChanged();
		einkommen_mc.onValueChanged();
		wohnkosten_mc.onValueChanged();
		wohnsituation_mc.onSelectionChanged();
		sonstigekosten_mc.onValueChanged();
		verfuegung_mc.onValueChanged();
	}
	
	public function onValueChanged(caller:Object, value:Number ):Void
	{
//		trace(caller + ": " + value);
		// je nach control
		switch (caller) {
			case familienstand_mc :
				// bisherige lebenshaltungskosten abhaengig von anzahl personen im haushalt
				var lebenshaltungskosten:Number = getUserinput().getLebenshaltungskosten();
			
				// familienstand abhaengig von anzahl personen in haushalt
				getUserinput().setFamilienstand(DataCalculator.getInstance().getFamilienstand(value));
				// anzahl personen in haushalt
				getUserinput().setPersonen(value);
				// neue lebenshaltungskosten
				getUserinput().setLebenshaltungskosten(DataCalculator.getInstance().getLebenshaltungskosten(value));
				// sonstige kosten um neue lebenshaltungskosten anpassen
				getUserinput().setSonstigekosten(getUserinput().getSonstigekosten() - lebenshaltungskosten + getUserinput().getLebenshaltungskosten());
				// und anzeigen
				sonstigekosten_mc.value = getUserinput().getSonstigekosten();
				
				break;	
			case lebensphase_mc :
				// lebensphase abhaengig vom alter
				getUserinput().setLebensphase(DataCalculator.getInstance().getLebensphase(value));
				// alter
				getUserinput().setAlter(value);
			
				break;
			case einkommen_mc :
				// nettoeinkommen
				getUserinput().setEinkommen(value);
			
				break;
			case wohnkosten_mc :
				// wohnkosten
				getUserinput().setWohnkosten(value);
			
				break;
			case sonstigekosten_mc :
				// sonstige kosten
				getUserinput().setSonstigekosten(value);
			
				break;
			case verfuegung_mc :
			
				break;
			default :
				trace(caller + " unbekannt");
		}
		// alles neu berechnen
		updateUserInput();
	}
	
	public function onSelectionChanged(caller:Object, value:Number ):Void
	{
		// je nach control
		switch (caller) {
			case wohnsituation_mc :
				// wohnsituation per checkbox ausgewaehlt
				getUserinput().setWohnsituation(DataCalculator.getInstance().getWohnsituation(value));
				
				break;
			default :
				trace(caller + " unbekannt");
		}
		// alles neu berechnen
		updateUserInput();
	}
	
	private function updateUserInput():Void
	{
		// bisheriger wert zur verfuegung stehendes einkommen
		var vold:Number = getUserinput().getVerfuegung();
		// zur verfuegung stehendes einkommen neu berechnen
		var vnew:Number = DataCalculator.getInstance().getVerfuegung(getUserinput());
		// neuer wert zur verfuegung stehendes einkommen
		getUserinput().setVerfuegung(vnew);
		// als maximum der planungssumme anzeigen
		verfuegung_mc.maximum = vnew;
		
		// planungssumme anpassen, wenn zur verfuegung stehendes einkommen geaendert
		if (vnew - vold != 0) {
			// bisheriger wert planungssumme
			var pold:Number = getUserinput().getPlanungssumme().getSummeact();
			// neuer wert planungssumme entsprechend aenderung zur verfuegung stehendes einkommen
			var pnew:Number = pold + (vnew - vold);
			// als wert der planungssumme anzeigen
			verfuegung_mc.value = pnew;
		}
		// planunssumme anzeige updaten
		verfuegung_mc.updateView();
		
		// entsprechendes planungssummenbean aus datenbank
		getUserinput().setPlanungssumme(DataCalculator.getInstance().getPlanungssumme(verfuegung_mc.value));
		// neuen wert planungssumme speichern
		getUserinput().getPlanungssumme().setSummeact(verfuegung_mc.value);
		
		// TODO: event handling
		var mc:WeightingUI = WeightingUI(_parent.weighting_mc);
		mc.onUserInputChanged();
	}
	
	public function getUserinput():UserInput {
		return DataProvider.getInstance().getUserinput();
	}

}