/** * @author gerd */class com.adgamewonderland.eplus.basecasting.util.Tracking {	private static var instance : Tracking;	private static var BASEURL:String = "javascript:dcsMultiTrack('WT.ti', '#', 'DCS.dcsuri', '#', 'WT.cg_n', '#', 'WT.cg_s', '#'); void(0);";	/**	 * @return singleton instance of Tracking	 */	public static function getInstance() : Tracking {		if (instance == null)			instance = new Tracking();		return instance;	}	public function doTrack(aTitle:String, aContentgroup:String, aSubcontentgroup:String ):Void	{		// aufzurufende url		var url:String = "";		// in einzelne teile zerlegen		var parts:Array = BASEURL.split("#");		// title		url += parts[0] + aTitle;		// alternative url		url += parts[1] + "/" + aTitle.toLowerCase().split(" ").join("_") + ".jsp";		// contentgroup		url += parts[2] + aContentgroup;		// subcontentgroup		url += parts[3] + aSubcontentgroup;		// schluss		url += parts[4];		// aufrufen		getURL(url);	}	private function Tracking() {	}}