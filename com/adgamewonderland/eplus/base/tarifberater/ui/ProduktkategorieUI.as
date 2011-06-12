import flash.geom.Point;

import mx.utils.Collection;
import mx.utils.Iterator;

import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;
import com.adgamewonderland.eplus.base.tarifberater.ui.HintergrundUI;
import com.adgamewonderland.eplus.base.tarifberater.ui.ProduktUI;

class com.adgamewonderland.eplus.base.tarifberater.ui.ProduktkategorieUI extends MovieClip {
	
	private static var XDIFF : Number = 0;
	
	private static var YDIFF : Number = 20;

	private var _kategorie : String;

	private var _produkte : Collection;

	private var kategorie_txt : TextField;

	private var back_mc : HintergrundUI;

	public function ProduktkategorieUI() {
	}

	public function onLoad() : Void {
		// anzeigen
		zeigeProduktkategorie(_kategorie, _produkte);
	}

	public function onUnload() : Void {
	}

	/**
	 * Zeigt Details zu einer Produktkategorie sowie alle darin enthaltenen Produkte an
	 * 	@param aKategorie
	 * 	@param aProdukte
	 */
	public function zeigeProduktkategorie(aKategorie : String, aProdukte : Collection ) : Void {
		// kategorie
		kategorie_txt.autoSize = "left";
		kategorie_txt.text = aKategorie;
		
		// position, an der das produkt angezeigt werden soll
		var position : Point = new Point(back_mc._x, back_mc._y);
		// schleife ueber produkte
		var iterator : Iterator = aProdukte.getIterator();
		// durchschleifen
		while (iterator.hasNext()) {
			// aktuelles produkt
			var produkt : IProdukt = IProdukt(iterator.next());
			// anzeigen
			position = zeigeProdukt(produkt, position);
		}
		
		// hintergrund skalieren
//		back_mc.setYsize(back_mc._height * aProdukte.getLength() + YDIFF * (aProdukte.getLength() - 1));
//		back_mc.doTween(back_mc._height, back_mc._height * aProdukte.getLength() + YDIFF * (aProdukte.getLength() - 1), 0.1);
		back_mc._height = (back_mc._height * aProdukte.getLength() + YDIFF * (aProdukte.getLength() - 1));
	}

	/**
	 * Bringt ein Produkt auf die Bühne
	 * @param aProdukt
	 * @param aPosition
	 * @return die Position, an der das nächste Produkt angezeigt werden soll
	 */
	private function zeigeProdukt(aProdukt : IProdukt, aPosition : Point) : Point {
		// konstruktor
		var constructor : Object = new Object();
		// produkt
		constructor._produkt = aProdukt;
		// position
		constructor._x = aPosition.x;
		constructor._y = aPosition.y;
		// auf buehne
		var ui : ProduktUI = ProduktUI(this.attachMovie("ProduktUI", "produkt" + this.getNextHighestDepth() + "_mc", this.getNextHighestDepth(), constructor));
		// naechste position
		return new Point(ui._x + XDIFF, ui._y + ui._height + YDIFF);
	}
}