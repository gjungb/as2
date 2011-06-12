/**
 * @author gerd
 */
class com.adgamewonderland.ea.nextlevel.controllers.PresentationState {

	public static var STATE_INITIALIZING:PresentationState = new PresentationState("INITIALIZING");

	public static var STATE_WAITING:PresentationState = new PresentationState("WAITING");

	public static var STATE_TRAILER:PresentationState = new PresentationState("TRAILER");

	public static var STATE_TRAILERLOOP:PresentationState = new PresentationState("TRAILERLOOP");

	public static var STATE_TRANSITION:PresentationState = new PresentationState("TRANSITION");

	public static var STATE_MENUCREATE:PresentationState = new PresentationState("MENUCREATE");

	public static var STATE_MENUDESTROY:PresentationState = new PresentationState("MENUDESTROY");

	public static var STATE_PLAYLIST:PresentationState = new PresentationState("PLAYLIST");

	public static var STATE_FINISHED:PresentationState = new PresentationState("FINISHED");

	private var stateid:String;

	public function PresentationState(stateid:String ) {
		// aktueller status
		this.stateid = stateid;
	}

	/**
	 * gibt eine liste der states zurueck, die im laufe der presentation durchlebt werden
	 * @return sortierte liste der states
	 */
	public static function getStatelist():Array
	{
		// liste der states in der reihenfolge des vorgesehenen ablaufs
		var statelist:Array = new Array();
		statelist.push(STATE_INITIALIZING);
		statelist.push(STATE_WAITING);
		statelist.push(STATE_TRAILER);
		statelist.push(STATE_TRAILERLOOP);
		statelist.push(STATE_TRANSITION);
		statelist.push(STATE_MENUCREATE);
		statelist.push(STATE_MENUDESTROY);
		statelist.push(STATE_PLAYLIST);
		statelist.push(STATE_FINISHED);
		// zurueck geben
		return statelist;
	}

	/**
	 * ermittelt den auf den uebergebenen state folgenden state
	 * @param state state, zu dem der folgende gesucht werden soll
	 * @return state, der auf den uebergebenen folgt; null, falls kein state folgt oder der uebergebene nicht bekannt ist
	 */
	public static function getNextState(state:PresentationState ):PresentationState
	{
		// gesuchter state
		var nextstate:PresentationState = null;
		// liste der states
		var statelist:Array = getStatelist();
		// schleife ueber states
		for (var i : Number = 0; i < statelist.length; i++) {
			// testen, ob gefunden
			if (state.equals(getStateByIndex(i))) {
				// naechster state
				nextstate = statelist[i + 1];
				// beenden
				break;
			}
		}
		// zurueck geben
		return nextstate;
	}

	/**
	 * ermittelt den dem uebergebenen state vorhergehenden state
	 * @param state state, zu dem der vorhergehende gesucht werden soll
	 * @return state, der dem uebergebenen vorhergeht; null, falls kein state vorhergeht oder der uebergebene nicht bekannt ist
	 */
	public static function getPrevState(state:PresentationState ):PresentationState
	{
		// gesuchter state
		var prevstate:PresentationState = null;
		// liste der states
		var statelist:Array = getStatelist();
		// schleife ueber states
		for (var i : Number = 0; i < statelist.length; i++) {
			// testen, ob gefunden
			if (state.equals(getStateByIndex(i))) {
				// naechster state
				prevstate = statelist[i - 1];
				// beenden
				break;
			}
		}
		// zurueck geben
		return prevstate;
	}

	/**
	 * gibt den state zum uebergebenen index in der statelist zurueck
	 * @param index
	 * @return state
	 */
	public static function getStateByIndex(index:Number ):PresentationState
	{
		// grenzen ueberpruefen
		if (index < 0 || index >= getStatelist().length) {
			return null;
		}
		// zurueck geben
		return getStatelist()[index];
	}

	/**
	 * gibt den index zum uebergebenen state in der statelist zurueck
	 * @param state
	 * @return index
	 */
	public static function getIndexByState(state:PresentationState ):Number
	{
		// gesuchter index
		var index:Number;
		// liste der states
		var statelist:Array = getStatelist();
		// schleife ueber states
		for (var i:Number = 0; i < statelist.length; i++) {
			// testen, ob gefunden
			if (state.equals(getStateByIndex(i))) {
				// gesuchter index
				index = i;
				// beenden
				break;
			}
		}
		// zurueck geben
		return index;
	}

	public function getStateid():String
	{
		return this.stateid;
	}

	public function equals(state:PresentationState ):Boolean
	{
		// testen, ob die states uebereinstimmen
		return (state.getStateid() == this.getStateid());
	}

	public function toString() : String {
		return "PresentationState: " + getStateid();
	}

}