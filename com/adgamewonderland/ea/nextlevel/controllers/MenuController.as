import com.adgamewonderland.agw.interfaces.IEventBroadcaster;import com.adgamewonderland.agw.util.EventBroadcaster;import com.adgamewonderland.ea.nextlevel.controllers.PresentationController;import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;import com.adgamewonderland.ea.nextlevel.swfstudio.FilesystemHandler;import com.adgamewonderland.ea.nextlevel.swfstudio.IFilesystemHandler;import com.adgamewonderland.ea.nextlevel.controllers.ApplicationController;import com.adgamewonderland.ea.nextlevel.controllers.RepositoryController;/** * @author gerd */class com.adgamewonderland.ea.nextlevel.controllers.MenuController implements IEventBroadcaster,IFilesystemHandler{	private static var _instance:MenuController;	private var _event:EventBroadcaster;	private static var MODUS_CREATE:Number 	= 0; // createPlaylist	private static var MODUS_LOAD:Number 	= 1; // laden	private static var MODUS_LOAD_PRESENTATION_COMPLETE:Number = 2;	private static var MODUS_LOAD_PRESENTATION_INDIVIDUAL:Number = 3;	// interesant wenn 2 asynchrone Aktionen hintereinander ablaufen sollen	private var modus:Number;	public static function getInstance():MenuController {		if (_instance == null)			_instance = new MenuController();		return _instance;	}	/**	 * legt eine neue playlist an	 */	public function createPlaylist():Void	{		_event.send("onFireMenue");		// Frage ob aktuelle Playlist gespeichert werden soll		if (PlaylistController.getInstance().getPlaylist().toItemsArray().length > 0) {			if (PlaylistController.getInstance().getDirty()) {				var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save1");				var ret = ssCore.App.showMsgBox(					{						title			: "Frage",						icon			: "question",						buttons			: "YesNo",						defaultButton	: "button1",						prompt			: prompt					}				);				if (ret.result == "YES") {					modus = MODUS_CREATE;					savePlaylist();					return;				}			}		}		// aktuelle playlist resetten		PlaylistController.getInstance().resetPlaylist();		// editor zum oeffnen der metainfos		openMetainfoEditor(true);		// listener informieren		_event.send("onPlaylistCreated");	}	/**	 * Öffnet Editor zum Eingeben der Metainfos	 * @param allowcancel darf der benutzer den editor schliessen ohne zu speichern	 */	public function openMetainfoEditor(allowcancel:Boolean ):Void	{		_event.send("onFireMenue");		// metainfo anzeigen / editieren		_event.send("onMetainfoEdit", PlaylistController.getInstance().getPlaylist().getMetainfo(), allowcancel);	}	/**	 * schließt editor zum eingeben der metainfos	 */	public function closeMetainfoEditor():Void	{		// listener informieren		_event.send("onMetainfoClosed");	}	/**	 * oeffnet eine vorhandene playlist	 */	public function openPlaylist():Void	{		_event.send("onFireMenue");		// Vor dem Öffnen prüfen ob Playlist gespeichert werden muss		if (PlaylistController.getInstance().getPlaylist().toItemsArray().length > 0) {			if (PlaylistController.getInstance().getDirty()) {				var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save1");				var ret = ssCore.App.showMsgBox(					{						title			: "Frage",						icon			: "question",						buttons			: "YesNo",						defaultButton	: "button1",						prompt			: prompt					}				);				if (ret.result == "YES") {					modus = MODUS_LOAD;					savePlaylist();					return;				}			}		}		modus = MODUS_LOAD;		var fsHnd:FilesystemHandler = new FilesystemHandler();		var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "load1");		fsHnd.setDlgCaption(prompt);		fsHnd.getFileOpenDlg(this);	}	/**	 * oeffnet eine individuelle playlist	 */	public function openPresentationIndividual():Void	{		modus = MODUS_LOAD_PRESENTATION_INDIVIDUAL;		var fsHnd:FilesystemHandler = new FilesystemHandler();		var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "load1");		fsHnd.setDlgCaption(prompt);		fsHnd.getFileOpenDlg(this);	}	/**	 * oeffnet die playlist der gesamtpraesentation	 */	public function openPresentationComplete():Void	{		modus = MODUS_LOAD_PRESENTATION_COMPLETE;//		var fsHnd:FilesystemHandler = new FilesystemHandler();//		var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "load2");//		fsHnd.setDlgCaption(prompt);//		fsHnd.getFileOpenDlg(this);		// pfad zum xml der gesamtpraesentation		var path:String = "startdir://Playlist/";		// title des repository		var title:String = RepositoryController.getInstance().getRepository().getMetainfo().getTitle();		// title an pfad anhaengen		path += title + ".xml";		// als object zur weiterverarbeitung uebergeben		onCompleteFileOpen({result:path});	}	/**	 * speichert die aktuelle playlist	 */	public function savePlaylist():Void	{		_event.send("onFireMenue");		// testen, ob playlist nicht leer		if (PlaylistController.getInstance().getPlaylist().toItemsArray().length > 0) {			if (PlaylistController.getInstance().getPfadPlaylist() == "") {				savePlaylistAs();			}			else {				// speichern				PlaylistController.getInstance().savePlaylist();				// anschliessend neue playlist erzeugen				if (modus == MODUS_CREATE) {					// aktuelle playlist resetten					PlaylistController.getInstance().resetPlaylist();					PlaylistController.getInstance().setPfadPlaylist("");					// listener informieren					_event.send("onPlaylistCreated");					modus = -1;					return;				}				// anschliessend vorhandene playlist laden				if (modus == MODUS_LOAD) {					// Neue Playlist von der Platte laden					openPlaylist();					return;				}				_event.send("onPlaylistSaved");			}		}		else {			// hinweis auf leere playlist			var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save2");			showMsgBox(prompt, "Information");		}	}	/**	 * speichert die aktuelle playlist unter einem neuen namen	 */	public function savePlaylistAs():Void	{		_event.send("onFireMenue");		// testen, ob playlist nicht leer		if (PlaylistController.getInstance().getPlaylist().toItemsArray().length > 0) {			// speichern			var fsHnd:FilesystemHandler = new FilesystemHandler();			var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save3");			fsHnd.setDlgCaption(prompt);			fsHnd.getSaveAsDlg(this);		}		else {			// hinweis auf leere playlist			var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save2");			showMsgBox(prompt, "Information");		}	}	/**	 * schliesst den editor	 */	public function closeEditor():Void	{		_event.send("onFireMenue");		// pruefen, ob playlist gespeichert werden soll		if (PlaylistController.getInstance().getPlaylist().toItemsArray().length > 0) {			if (PlaylistController.getInstance().getDirty()) {				var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "save1");				var ret = ssCore.App.showMsgBox(					{						title			: "Frage",						icon			: "question",						buttons			: "YesNo",						defaultButton	: "button1",						prompt			: prompt					}				);				if (ret.result == "YES") {					savePlaylist();				}			}		}		// playlist leeren		PlaylistController.getInstance().resetPlaylist();		ApplicationController.getInstance().changeState(			ApplicationController.STATE_STARTMENU);	}	public function addListener(l:Object):Void	{		this._event.addListener(l);	}	public function removeListener(l:Object):Void	{		this._event.removeListener(l);	}	private function MenuController()	{		this._event = new EventBroadcaster();		// interesant wenn 2 asynchrone Aktionen hintereinander ablaufen sollen		this.modus = -1;	}	/**	 * Anzeige einer belibigen MsgBox mit SWF Studio Mitteln	 * @param info info-text in der box	 * @param caption ueberschrift der box	 */	private function showMsgBox(info:String, caption:String): Void {		ssCore.App.showMsgBox(			{				title			: caption,				icon			: "information",				buttons			: "OkOnly",				defaultButton	: "button1",				prompt			: info			}		);	}	/**	 * Callback für FilesystemHandler	 * FileOpen	 */	public function onCompleteFileOpen(return_obj) : Void {		// dateiname der zu ladenden playlist		var strPlaylist:String = return_obj.result;		// laden		if (strPlaylist != "") {			// playlist der gesamtpraesentation			if (modus == MODUS_LOAD_PRESENTATION_COMPLETE) {				PresentationController.getInstance().loadPresentationComplete(strPlaylist);				modus = -1;				// listener informieren				_event.send("onPresentationCompleteOpened");				return;			}			// individuelle playlist fuer praesentation			if (modus == MODUS_LOAD_PRESENTATION_INDIVIDUAL) {				PresentationController.getInstance().loadPresentationIndividual(strPlaylist);				modus = -1;				// listener informieren				_event.send("onPresentationIndividualOpened");				return;			}			// individuelle playlist fuer editor			if (modus == MODUS_LOAD) {				PlaylistController.getInstance().loadPlaylist(strPlaylist);				modus = -1;				// listener informieren				_event.send("onPlaylistOpened");				return;			}		}	}	/**	 * Callback für FilesystemHandler	 */	public function onError(return_obj) : Void {		ssCore.App.showMsgBox(			{				icon			: "question",				buttons			: "Yes",				defaultButton	: "button1",				prompt			: return_obj.result			}		);	}	/**	 * Speichern unter	 */	public function onCompleteSaveAs(returnObj:Object, callbackObj:Object, errorObj:Object) : Void {		// dateiname der zu speichernden playlist		var strPlaylist:String = returnObj.result;		if (strPlaylist != "") {			// Speichern über den PlaylistController			PlaylistController.getInstance().setPfadPlaylist(strPlaylist);			PlaylistController.getInstance().savePlaylist	();			// listener informieren			_event.send("onPlaylistSavedAs");			// anschliessend neue playlist erzeugen			if (modus == MODUS_CREATE) {				// aktuelle playlist resetten				PlaylistController.getInstance().resetPlaylist();				PlaylistController.getInstance().setPfadPlaylist("");				// listener informieren				_event.send("onPlaylistCreated");				modus = -1;			}			// anschliessend vorhandene playlist laden			if (modus == MODUS_LOAD) {				// Neue Playlist von der Platte laden				var fsHnd:FilesystemHandler = new FilesystemHandler();				var prompt:String = ApplicationController.getInstance().getIniVal("Messages", "load1");				fsHnd.setDlgCaption(prompt);				fsHnd.getFileOpenDlg(this);				modus = -1;			}		}	}}