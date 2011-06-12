import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IApplicationCtrlLsnr;

import flash.geom.Point;
import flash.geom.Rectangle;

import mx.utils.Iterator;

import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;
import com.adgamewonderland.eplus.base.tarifberater.beans.Frage;
import com.adgamewonderland.eplus.base.tarifberater.beans.Warenkorb;
import com.adgamewonderland.eplus.base.tarifberater.controllers.ApplicationController;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ISizable;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.ITarifberaterAutomatLsnr;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IZustand;
import com.adgamewonderland.eplus.base.tarifberater.ui.AntwortUI;
import com.adgamewonderland.eplus.base.tarifberater.ui.AntworticonUI;
import com.adgamewonderland.eplus.base.tarifberater.ui.FragetextUI;
import com.adgamewonderland.eplus.base.tarifberater.ui.HintergrundUI;


/**
 * @author gerd
 */
class com.adgamewonderland.eplus.base.tarifberater.ui.FrageUI extends MovieClip implements ITarifberaterAutomatLsnr, IApplicationCtrlLsnr, ISizable {

	private static var YPOS : Number = 70;
	
	// TODO: positionen bei 5 antworten ausmessen lassen
	private static var POSITIONEN5 : Array = new Array(new Point(20, YPOS), new Point(175, YPOS), new Point(330, YPOS), new Point(485, YPOS), new Point(640, YPOS));
	
	private static var POSITIONEN4 : Array = new Array(new Point(20, YPOS), new Point(210, YPOS), new Point(400, YPOS), new Point(590, YPOS));

	private static var POSITIONEN3 : Array = new Array(new Point(60, YPOS), new Point(303, YPOS), new Point(546, YPOS));

	private static var POSITIONEN2 : Array = new Array(new Point(143, YPOS), new Point(465, YPOS));
	
	private static var MINDESTHOEHE : Number = 330;

	private static var TWEENDELAY : Number = 200;

	private var fragetext_mc : FragetextUI;

	private var rahmen_mc : HintergrundUI;

	private var antworten_mc:MovieClip;
	
	public function FrageUI() {
	}

	public function onLoad() : Void {
		// als listener registrieren
		ApplicationController.getInstance().getAutomat().addListener(this);	
		// als listener registrieren
		ApplicationController.getInstance().addListener(this);	
	}
	
	public function onUnload() : Void {
		// als listener deregistrieren
		ApplicationController.getInstance().getAutomat().removeListener(this);	
		// als listener deregistrieren
		ApplicationController.getInstance().removeListener(this);	
	}
	
	public function onZustandGeaendert(aZustand : IZustand, aWarenkorb : Warenkorb) : Void {
		// antworten loeschen
		antworten_mc.removeMovieClip();
		// anzeigen
		zeigeFrage(aZustand.getFrage());
	}

	/**
	 * Zeigt die Inhalte der Frage auf der Bühne an
	 * @param aFrage
	 */
	public function zeigeFrage(aFrage : Frage) : Void {
		// fragetext
		fragetext_mc.zeigeText(aFrage.getText());
		// liste mit antworten auf buehne
		antworten_mc = this.createEmptyMovieClip("antworten_mc", getNextHighestDepth());
		// antwort auf buehne
		var ui : AntwortUI;
		// liste der antworten auf buehne zur steuerung der reihenfolge der zeitverzoegerung
		var uiliste : Array = new Array();
		// anzuzeigende antwort
		var antwort : Antwort;
		// position
		var position : Point;
		// positionszaehler
		var counter : Number = 0;
		// antworten der frage
		var antworten : Iterator = aFrage.getAntworten().getIterator();
		//nur die sichtbaren sollen herangezogen werden
		var anzahlSichtbare : Number = 0;
		while(antworten.hasNext()){
			antwort = Antwort(antworten.next());
			if(antwort.getVisible() == true){
				anzahlSichtbare ++;
			}
		}
		antworten = aFrage.getAntworten().getIterator();
		// durchschleifen
		while (antworten.hasNext()) {
			// antwort
			antwort = Antwort(antworten.next());
			// nur sichtbare
			if (antwort.getVisible() == false)
				continue;
			// position
			switch (anzahlSichtbare) {
				case 5 :
					position = POSITIONEN5[counter ++];
					break;
					
				case 4 :
					position = POSITIONEN4[counter ++];
					break;
				
				case 3 :
					position = POSITIONEN3[counter ++];
					break;
				
				case 2 :
					position = POSITIONEN2[counter ++];
					break;
			}
			// anzeigen
			ui = zeigeAntwort(antwort, position, counter);
			// merken
			if (ui instanceof AntworticonUI)
				uiliste.unshift(ui);
			else
				uiliste.push(ui);

		}
		// mit zeitverzoegerung einblenden
		for (var i : Number = 0; i < uiliste.length; i++) {
			// aktuelle antwort
			ui = uiliste[i];
			// zeitverzoegerung
			ui.tweenInAntwort(i * TWEENDELAY, ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION);
		}
		// controller informieren
		ApplicationController.getInstance().aendereGroesse(this);
		// rahmen skalieren
		rahmen_mc.doTween(rahmen_mc._height, getYmax(), ApplicationController.TWEENFUNCTION, ApplicationController.TWEENDURATION);
	}

	public function getPosition() : Point {
		// position als punkt
		return new Point(_x, _y);
	}
	
	public function getSize() : Rectangle {
		// groesse als rechteck
		var size : Rectangle = new Rectangle(0, 0, _width, getYmax());
		// zurueck geben
		return size;
	}
	
	public function getName() : String {
		return this._name;
	}

	/**
	 * Bringt eine Antwort auf die Buehne
	 * @param aAntwort
	 */
	private function zeigeAntwort(aAntwort : Antwort, aPosition : Point, aCounter : Number ) : AntwortUI {
		// konstruktor
		var constructor:Object = new Object();
		// antwort
		constructor._antwort = aAntwort;
		// position
		constructor._x = aPosition.x;
		constructor._y = aPosition.y;
		// depth so setzen, dass 2.te antwort ganz hinten
		var depth : Number = aCounter; // (aCounter == 2 ? 0 : aCounter);
		// auf buehne
		var ui : AntwortUI = AntwortUI(antworten_mc.attachMovie(aAntwort.getIdentifier(), "antwort" + aCounter + "_mc", depth, constructor)); // antworten_mc.getNextHighestDepth()
		// zurueck geben
		return ui;
	}
	
	/**
	 * Berechnet die maximale y-Position aller mcs, ausgenommen des Hintergrunds
	 */
	private function getYmax() : Number {
		// maximalwert
		var ymax : Number = 0;
		// hohe des rahmens
		var rheight : Number = rahmen_mc._height;
		// rahmen verkleinern, um bounds davon unabhaengig zu ermitteln
		rahmen_mc.setYsize(30);
		// bounds
		var bounds : Object = this.getBounds(this);
		// maximalwert
		ymax = Math.max(bounds["yMax"], MINDESTHOEHE);
		// rahmen auf vorherige groesse
		rahmen_mc.setYsize(rheight);
		// zurueck geben
		return ymax;
	}
	
	public function onZeigeProduktinfos(aProdukt : IProdukt) : Void {
	}
	
	public function onAendereGroesse(aSizable : ISizable) : Void {
	}

	public function onZeigeWarenkorb(aWarenkorb : Warenkorb, aSichtbar : Boolean, aZustand : IZustand) : Void {
	}
}