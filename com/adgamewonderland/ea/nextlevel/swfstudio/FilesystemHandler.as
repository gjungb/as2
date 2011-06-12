import com.adgamewonderland.ea.nextlevel.swfstudio.IFilesystemHandler;
/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.swfstudio.FilesystemHandler implements IFilesystemHandler {

	private var DlgCaption 	: String = "Open File";
	private var DlgReturn 	: String = "";
	private var DlgError	: String = "";

	function FilesystemHandler() {

	}

	public function setDlgCaption(val:String):Void
	{
		this.DlgCaption = val;
	}

	public function getDlgCaption():String
	{
		return this.DlgCaption;
	}

	public function getDlgReturn():String
	{
		return this.DlgReturn;
	}
	public function getDlgError():String
	{
		return this.DlgError;
	}

	public function getFileOpenDlg (hndler:IFilesystemHandler) : Void {

		DlgError = "";
		DlgReturn = "";

		if (hndler == null) {
			hndler = this;
		}
		ssCore.App.showFileOpen(
			{
				caption:DlgCaption,
				path:"startdir://Playlist",
				filter:"Playlist|*.xml||"
			},{
				callback:hndler.onCompleteFileOpen,
				scope:hndler
			},{
				callback:hndler.onError,
				scope:hndler
			}
		);
	}

	public function getSaveAsDlg (hndler:IFilesystemHandler) : Void {

		DlgError = "";
		DlgReturn = "";

		if (hndler == null) {
			hndler = this;
		}
		ssCore.App.showFileSave(
			{
				caption:DlgCaption,
				path:"startdir://Playlist",
				filter:"Playlist|*.xml||"
			},{
				callback:hndler.onCompleteSaveAs,
				scope:hndler
			}
		);
	}


	public function getFolderOpenDlg (path:String ) : Void {

		DlgError = "";
		DlgReturn = "";

		ssCore.App.showFolderBrowser(
			{
				caption:"Pfadauswahl",
				path:"startdir://"
			},{
				callback:onCompleteFileOpen,
				scope:this
			},{
				callback:onError,
				scope:this
			}
		);
	}

	function onCompleteFileOpen(return_obj) : Void	{
		DlgError 	= "ok";
		DlgReturn 	= return_obj.result;
	}

	function onCompleteSaveAs(return_obj:Object, callback_obj:Object, error_obj:Object) : Void	{
		DlgError 	= "ok";
		DlgReturn 	= return_obj.result;
	}

	function onError(return_obj) : Void	{
		DlgError 	= "n_ok";
		DlgReturn 	= "";

		ssCore.App.showMsgBox(
			{
				icon:"question",
				buttons:"Yes",
				defaultButton:"button1",
				prompt:return_obj.result
			}
		);
	}
}