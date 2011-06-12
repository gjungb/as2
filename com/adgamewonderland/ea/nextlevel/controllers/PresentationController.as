import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;
import com.adgamewonderland.ea.nextlevel.controllers.PresentationState;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IVideoControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistVideoItemImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.Playlist;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.controllers.ApplicationController;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.controllers.PresentationController implements IEventBroadcaster, IVideoControllerListener {

	private static var _instance:PresentationController;
	private var _event:EventBroadcaster;

	private var playlist:PlaylistImpl;

	private var presentation:PresentationImpl;		// in diesem Bean geht die Playlist datentechnisch auf

	private var branch:PresentationImpl;

	private var complete:Boolean;

	private var currentstate:PresentationState;

	private var branchindex:Number;

	private var itemindex:Number;

	private var fullscreen:Boolean;

	/**
	 * individuelle presentation aus xml laden
	 */
	public function loadPresentationIndividual(datei:String):Void {
		if (loadPresentation(datei)) {
			this.complete = false;
		}
	}

	/**
	 * gesamtpresentation aus xml laden
	 */
	public function loadPresentationComplete(datei:String):Void {
		if (loadPresentation(datei)) {
			this.complete = true;
		}
	}

	/**
	 * intialisiert und startet die geladene presentation
	 */
	public function startPresentation():Void
	{
		// aktueller status
		this.currentstate		= PresentationState.STATE_INITIALIZING;
		// index des aktuellen strangs
		this.branchindex		= -1;
		// index des ersten abzuspielenden items
		this.itemindex			= 0;
		// wurzel strang starten
		startBranch(PresentationState.STATE_WAITING);
	}

	/**
	 * schaltet die presentation nach klick auf ein menuitem weiter
	 * @param index index des geklickten menuitems
	 */
	public function switchPresentation(index:Number ):Void
	{
		// hauptmenu wurde geklickt
		if (getBranchindex() == -1) {
			// index des gewaehlten strangs
			setBranchindex(index);
			// neuen strang starten
			startBranch(PresentationState.STATE_WAITING);

		// submenu wurde geklickt
		} else {
			// index des ersten abzuspielenden items
			setItemindex(index);
			// naechster status (PLAYLIST)
			nextState();
		}
	}

	/**
	 * haelt den aktuell abgespielten zweig an
	 */
	public function stopBranch():Void
	{
		// bei trailer, trailer loop nicht erlauben
		switch (getCurrentstate()) {
			case PresentationState.STATE_TRAILER :
			case PresentationState.STATE_TRAILERLOOP :
				// abbrechen
				return;
		}
		// wurzel strang
		if (getBranchindex() == -1) {
			// testen, ob im menu
			if (PresentationState.STATE_MENUCREATE.equals(getCurrentstate())) {
				// menu abbauen
				changeState(PresentationState.STATE_MENUDESTROY, false);

			// alle anderen
			} else {
				// strang beenden
				resetBranch();
			}

		// verzweigter strang
		} else {
			// testen, ob in playlist
			if (PresentationState.STATE_PLAYLIST.equals(getCurrentstate())) {
				// zum letzten video in der playlist
				VideoController.getInstance().gotoItem(VideoController.getInstance().getItems().length - 1);

			// testen, ob im menu
			} else if (PresentationState.STATE_MENUCREATE.equals(getCurrentstate())) {
				// menu abbauen
				changeState(PresentationState.STATE_MENUDESTROY, false);

			// alle anderen
			} else {
				// strang beenden
				resetBranch();
			}
		}
	}

	/**
	 * setzt den aktuell abgespielten zweig zurueck und springt zum hauptmenue
	 */
	public function resetBranch():Void
	{
		// wurzel strang
		if (getBranchindex() == -1) {
			// zum warteloop
			startBranch(PresentationState.STATE_WAITING);

		// verzweigter strang
		} else {
			// zum wurzelstrang
			setBranchindex(-1);
			// zum hauptmenue
			startBranch(PresentationState.STATE_MENUCREATE);
		}
	}

	/**
	 * stoppt die aktuelle presentation und kehrt zum startmenu zurueck
	 */
	public function stopPresentation():Void
	{
		// zum startmenu
		ApplicationController.getInstance().changeState(ApplicationController.STATE_STARTMENU);
	}

	/**
	 * callback, wenn der videocontroller ein item zum abspielen uebergibt
	 */
	public function onItemSelected(item:PlaylistVideoItem ):Void
	{
		// fullscreen darf nicht immer automatisch wechseln!
		if (getCurrentstate().equals(PresentationState.STATE_PLAYLIST) == false) {
			// fullscreen ein- / ausschalten
			setFullscreen(item.isFullScreen());
		}
		// listener informieren
		_event.send("onPresentationItemChanged", item);
	}

	/**
	 * callback, nachdem der VideoController alle ihm uebergebenen items abgespielt hat
	 */
	public function onItemsPlayed(items:Array ):Void
	{
		// zum naechsten state
		if (items.length > 0) nextState();
	}

	/**
	 * wechselt zum naechst folgenden state in der liste der states
	 */
	public function nextState():Void
	{
		// naechster state
		var nextstate:PresentationState = PresentationState.getNextState(getCurrentstate());
		// abzuspielende items
		var items:Array = new Array();
		// index des ersten abzuspielenden items
		var startat:Number = 0;
		// soll der state uebersprungen werden
		var skipstate:Boolean = false;
		// je nach state entsprechende aktionen ausfuehren
		switch (nextstate) {
			// initialisierung
			case PresentationState.STATE_INITIALIZING :

				break;

			// warteloop
			case PresentationState.STATE_WAITING :
				// warteloop
				var loop:PlaylistVideoItem = getBranch().getWarteLoop();
				// ueberspringen, wenn nicht vorhanden
				if (loop == undefined) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
				// abzuspielende items
				items.push(loop);

				break;

			// trailer
			case PresentationState.STATE_TRAILER :
				// trailer
				var trailer:PlaylistVideoItem = getBranch().getTrailer();
				// ueberspringen, wenn nicht vorhanden
				if (trailer == undefined || trailer.getVideo().getID() <= 0) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
				// abzuspielende items
				items.push(trailer);

				break;

			// trailerloop
			case PresentationState.STATE_TRAILERLOOP :
				// trailer
				var trailerloop:PlaylistVideoItem = getBranch().getTrailerLoop();
				// ueberspringen, wenn nicht vorhanden
				if (trailerloop == undefined || trailerloop.getVideo().getID() <= 0) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
				// abzuspielende items
				items.push(trailerloop);

				break;

			// uebergang
			case PresentationState.STATE_TRANSITION :
				// uebergang
				var transition:PlaylistVideoItem = getBranch().getUebergang();
				// ueberspringen, wenn nicht vorhanden
				if (transition == undefined || transition.getVideo().getID() <= 0) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
				// abzuspielende items
				items.push(transition);

				break;

			// menu aufbau
			case PresentationState.STATE_MENUCREATE :
				// nicht fullscreen
				setFullscreen(false);
				// menu
				var menu:Array = getBranch().toMenueArray();
				// ueberspringen, wenn individuelle presentation oder wenn menu leer
				if (isComplete() == false || menu.length == 0) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
//				// warteloop der gesamtpraesentation als hintergrund fuer menue
//				var loop:PlaylistVideoItem = getPresentation().getWarteLoop();
//				// nicht fullscreen
//				loop.setFullScreen(false);
//				// abzuspielende items
//				items.push(loop);

				break;

			// menu abbau
			case PresentationState.STATE_MENUDESTROY :
				// ueberspringen
				skipstate = true;

				break;

			// playlist
			case PresentationState.STATE_PLAYLIST :
				// playlistitems
				var playlistitems:Array = getBranch().toVideoArray();
				// ueberspringen, wenn leer
				if (playlistitems.length == 0) {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}
				// abzuspielende items
				items = playlistitems;
				// index des ersten abzuspielenden items
				startat = getItemindex();
				// nicht fullscreen
				setFullscreen(false);

				break;

			// finished
			case PresentationState.STATE_FINISHED :
				// bei verzweigtem strang zum hauptmenu
				if (getBranchindex() != -1) {
//					// playliste beenden (01.08.2007: hier falsch, daher s.u.)
//					resetBranch();
				} else {
					// ueberspringen
					skipstate = true;
					// abbrechen
					break;
				}

				break;


			// nicht bekannt / nicht implementiert
			default :
				ssDebug.trace("nextState nicht bekannt / nicht implementiert: " + nextstate);
				// abbrechen
				return;
		}
		// neuen state setzen und ggf. listener informieren
		changeState(nextstate, skipstate);
		// pruefen, ob state uebersprungen werden soll
		if (skipstate == true) {
			// sofort zum naechsten state
			nextState();
		} else {
			ssDebug.trace("nextState: " + nextstate + " # " + items);

			// items an videocontroller zum abspielen uebergeben
			VideoController.getInstance().playItems(items, startat);
		}
		// am ende eines strangs angekommen
		if (nextstate.equals(PresentationState.STATE_FINISHED) && getBranchindex() != -1) {
			// playliste beenden
			resetBranch();
		}
	}

	/**
	 * initialisiert und startet den aktuellen strang der geladenen presentation
	 * @param startstate
	 */
	private function startBranch(startstate:PresentationState ):Void
	{
		// welcher strang der presentation soll abgespielt werden (je nach index des aktuellen strangs)
		if (getBranchindex() == -1) {
			// wurzel strang
			setBranch(this.presentation);

		} else {
			// verzweigter strang
			setBranch(getPresentation().getChapterFromIndex(getBranchindex()));
		}
		// auf ausgangsstatus
		changeState(PresentationState.getPrevState(startstate), true); // false
		// index des ersten abzuspielenden items
		setItemindex(0);
		// naechster status
		nextState();
	}

	/**
	 * aendert den status der abgespielten presentation
	 * @param newstate neuer state (s. PresentationState.STATE_)
	 */
	private function changeState(newstate:PresentationState, skipstate:Boolean ):Void
	{
		// aktueller status
		var oldstate:PresentationState = getCurrentstate();
		// abbrechen, wenn bereits in diesem status
		if (newstate.equals(oldstate)) return;
		// neuen status setzen
		setCurrentstate(newstate);
		// testen, ob state nicht uebersprungen werden soll
		if (skipstate == false) {

			ssDebug.trace("changeState: " + oldstate.toString() + ", " + newstate.toString());

			// listener informieren
			_event.send("onPresentationStateChanged", oldstate, newstate, getBranch());
		}
	}

	/**
	 * presentation aus datei laden und parsen
	 * @param datei zu ladende datei
	 */
	private function loadPresentation (datei:String):Boolean {
		var file_obj = ssCore.FileSys.readFile (
			{path:datei}
		);
		if (file_obj.success) {
			var content:String = file_obj.result;

			var xml:XML = new XML();
			xml.parseXML(content);

			var node:XMLNode 		= xml.firstChild;
			var temp:PlaylistImpl 	= new PlaylistImpl();
			temp.DeserializeXML(node);
			setPlaylist	(temp);

			return true;
		}
		return false;
	}

	public function setPlaylist(value:PlaylistImpl):Void
	{
		this.playlist = value;
		parsePresentation(this.playlist);
	}

	public function getPlaylist():PlaylistImpl
	{
		return this.playlist;
	}

	public function getPresentation():PresentationImpl
	{
		return this.presentation;
	}

	public function setBranch(value:PresentationImpl):Void {
		this.branch = value;
	}

	public function getBranch():PresentationImpl
	{
		return this.branch;
	}

	public function isComplete():Boolean {
		return this.complete;
	}

	public function setComplete(value:Boolean):Void {
		this.complete = value;
	}

	public function getCurrentstate():PresentationState
	{
		return this.currentstate;
	}

	public function setCurrentstate(currentstate:PresentationState ):Void
	{
		this.currentstate = currentstate;
	}

	public function setBranchindex(branchindex:Number ):Void
	{
		this.branchindex = branchindex;
	}

	public function getBranchindex():Number
	{
		return this.branchindex;
	}

	public function setItemindex(itemindex:Number ):Void
	{
		this.itemindex = itemindex;
	}

	public function getItemindex():Number
	{
		return this.itemindex;
	}

	public function setFullscreen(fullscreen:Boolean):Void
	{
		this.fullscreen = fullscreen;
		// listener informieren
		_event.send("onToggleFullscreen", fullscreen);
	}

	public function isFullscreen():Boolean
	{
		return this.fullscreen;
	}

	public static function getInstance():PresentationController
	{
		if (_instance == null)
			_instance = new PresentationController();
		return _instance;
	}

	public function addListener(l:Object):Void
	{
		this._event.addListener(l);
	}

	public function removeListener(l:Object):Void
	{
		this._event.removeListener(l);
	}

	private function PresentationController()
	{
		this._event = new EventBroadcaster();

		// playlist
		this.playlist			= new PlaylistImpl();
		// vollstaendige presentation
		this.presentation		= new PresentationImpl();
		// wird die gesamtpraesentation oder eine individuelle praesentation abgespielt
		this.complete			= false;
		// aktueller status
		this.currentstate		= PresentationState.STATE_INITIALIZING;
		// index des aktuellen strangs
		this.branchindex		= -1;
		// index des ersten abzuspielenden items
		this.itemindex			= 0;
		// wird das video fullscreen abgespielt
		this.fullscreen 		= false;
		// beim videocontroller als listener registrieren
		VideoController.getInstance().addListener(this);
	}

	/**
	 * wandelt eine playlist in eine vollstaendige presentation um
	 */
	private function parsePresentation(value:Playlist ):Void
	{
		// neue presentation
		this.presentation = new PresentationImpl();
		// aus playlist einlesen
		presentation.create(value);
	}

}