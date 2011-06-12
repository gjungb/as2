import com.adgamewonderland.eplus.base.tarifberater.beans.Antwort;

import mx.utils.CollectionImpl;
import mx.utils.Collection;

class com.adgamewonderland.eplus.base.tarifberater.beans.Frage {
	
	private var text : String;

	private var antworten : Collection;
	public function Frage(aText : String ) {
		// text
		this.text = aText;
		// antworten
		this.antworten = new CollectionImpl();
	}

	/**
	 * Fügt eine Antwort zur Liste der Anworten hinzu
	 * @param aAntwort
	 */
	public function addAntwort(aAntwort : Antwort ) : Void {
		// hinzufuegen
		this.antworten.addItem(aAntwort);
	}
	
	public function getText() : String {
		return this.text;
	}

	public function getAntworten() : Collection {
		return this.antworten;
	}
}
