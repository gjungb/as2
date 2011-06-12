/**
 * @author harry
 */
import com.adgamewonderland.agw.util.XMLConnector;
import com.adgamewonderland.eplus.base.tarifberater.beans.TarifOption;
import com.adgamewonderland.eplus.base.tarifberater.interfaces.IProdukt;

class com.adgamewonderland.eplus.base.tarifberater.beans.BeratungsErgebniss {
	
	/**
	 * Trennzeichen für Tarifoptionen
	 */
	public static var TRENNER : String = ",";

	private var sessionId : String;

	private var beratungsWeg : String;
	
	private var tarif : IProdukt;

	private var tarifoptionen : String;

	public function BeratungsErgebniss(aSessionid : String, aWeg : String ) {
		this.sessionId = aSessionid;
		this.beratungsWeg = aWeg;
		this.tarif = null;
		this.tarifoptionen = "";
	}
	
	/**
	 * Fügt eine Tarifoption hinzu
	 * @param aTarifOption
	 */
	public function addTarifOption(aTarifOption : TarifOption) : Void {
		// hinzufuegen
		if (aTarifOption.getCheck())
			this.tarifoptionen += aTarifOption.getOption() + TRENNER;
	}

	/**
	 * Formt das Ergebnis in XML um
	 * @param aName
	 */
	public function toXML(aName : String ) : XMLNode {
		// ergebnis als xml
		var result : XMLNode;
		// connector
		var conn : XMLConnector = new XMLConnector(this, "");
		// head
		var head : XML = conn.getXMLHead("beratungsergebnis", {});
		// hauptnode
		result = conn.getXMLNode(aName, {});
		// sessionid
		var sessionid : XMLNode = conn.getXMLNode("sessionid", {});
		sessionid.appendChild(head.createTextNode(getSessionId()));
		result.appendChild(sessionid);
		// tarif
		var tarif : XMLNode = conn.getXMLNode("tarif", {});
		tarif.appendChild(head.createTextNode(getTarif().getId()));
		result.appendChild(tarif);
		// simkarte
		var simkarte : XMLNode = conn.getXMLNode("simkarte", {});
		simkarte.appendChild(head.createTextNode(getTarif().getSapnummer()));
		result.appendChild(simkarte);
		// tarifoptionen
		var tarifoptionen : XMLNode = conn.getXMLNode("tarifoptionen", {});
		tarifoptionen.appendChild(head.createTextNode(getTarifoptionen()));
		result.appendChild(tarifoptionen);
		// beratungsweg
		var beratungsweg : XMLNode = conn.getXMLNode("beratungsweg", {});
		beratungsweg.appendChild(head.createTextNode(getBeratungsWeg()));
		result.appendChild(beratungsweg);
		// zurueck geben
		return result;
	}
	
	/**
	 * Gibt das Ergebnis als JSON-String zurück
	 * @param id fortlaufende Nummer des Ergebnis
	 */
	public function toJSON(id : Number ) : String {
		// ergebnis als json
		var json : String = "beratungsergebnis" + id + ":";
		// anfang
		json += "{";
		// tarif
		json += "'tarif':" + getTarif().getId() + ",";
		// simkarte
		json += "'simkarte':'" + getTarif().getSapnummer() + "',";
		// tarifoptionen
		json += "'tarifoptionen':'" + getTarifoptionen().split(TRENNER).join("|").substr(0, getTarifoptionen().length - 1) + "'";
		// ende
		json += "}";
		// zurueck geben
		return json;
	}

	/**
	 * @return the sessionId
	 */
	public function getSessionId() : String {
		return this.sessionId;
	}

	/**
	 * @param sessionId the sessionId to set
	 */
	public function setSessionId(aSessionId : String) : Void {
		this.sessionId = aSessionId;
	}

	/**
	 * @return the tarif
	 */
	public function getTarif() : IProdukt {
		return this.tarif;
	}

	/**
	 * @param tarif the tarif to set
	 */
	public function setTarif(aTarif : IProdukt) : Void {
		this.tarif = aTarif;
	}

	/**
	 * @return the beratungsWeg
	 */
	public function getBeratungsWeg() : String {
		return this.beratungsWeg;
	}

	/**
	 * @param beratungsWeg the beratungsWeg to set
	 */
	public function setBeratungsWeg(aBeratungsWeg : String) : Void {
		this.beratungsWeg = aBeratungsWeg;
	}

	/**
	 * @return the tarifoptionen
	 */
	public function getTarifoptionen() : String {
		return this.tarifoptionen;
	}

	/**
	 * @param tarifoptionen the tarifoptionen to set
	 */
	public function setTarifoptionen(aTarifoptionen : String) : Void {
		this.tarifoptionen = aTarifoptionen;
	}

	/**
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public function toString() : String {
		var ret : String = "";
		for (var i : String in this) {
			ret += i + ": " + this[i] + "\n";
		}
		return ret;
	}
}
