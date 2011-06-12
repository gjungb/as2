/*
klasse:			ContentDescriptor
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		26.02.2005
zuletzt bearbeitet:	09.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.descriptors.ContentDescriptor {

	private var myPath:Array;

	private var myMenuName:String;

	private var myHasContent:Boolean;

	private var myHasMenu:Boolean;

	private var myIntroText:String;

	private var myWidth:Number;

	private var myHeight:Number;

	private var isLoaded:Boolean;

	private var myFile:String;

	public function ContentDescriptor(parr:Array, mstr:String, cbool:Boolean, mbool:Boolean, istr:String, wnum:Number, hnum:Number, fstr:String )
	{
		// pfad mit 5 buchstaben code
		myPath = parr;
		// menu name, der angezeigt wird
		myMenuName = mstr;
		// wird bei klick entsprechender content angezeigt
		myHasContent = cbool;
		// wird ein entsprechendes menuitem angezeigt
		myHasMenu = mbool;
		// intro text
		myIntroText = istr;
		// breite der content box
		myWidth = wnum;
		// hoehe der content box
		myHeight = hnum;
		// content swf vollstaendig geladen
		isLoaded = false;
		// virtueller dateiname
		myFile = fstr;
	}

	public function get path():Array
	{
		// pfad mit 5 buchstaben code
		return myPath;
	}

	public function get menuname():String
	{
		// menu name, der angezeigt wird
		return myMenuName;
	}

	public function get hascontent():Boolean
	{
		// wird bei klick entsprechender content angezeigt
		return myHasContent;
	}

	public function get hasmenu():Boolean
	{
		// wird ein entsprechendes menuitem angezeigt
		return myHasMenu;
	}

	public function get introtext():String
	{
		// intro text
		return myIntroText;
	}

	public function get width():Number
	{
		// breite der content box
		return myWidth;
	}

	public function get height():Number
	{
		// hoehe der content box
		return myHeight;
	}

	public function set loaded(bool:Boolean ):Void
	{
		// content swf vollstaendig geladen
		isLoaded = bool;
	}

	public function get loaded():Boolean
	{
		// content swf vollstaendig geladen
		return isLoaded;
	}

	public function get file():String
	{
		// virtueller dateiname
		return myFile;
	}

	/**
	 * @Override
	 */
	public function toString() : String {
		var str:String = "com.adgamewonderland.eplus.baseclip.descriptors.ContentDescriptor";
		for (var i : String in this) {
			str += "\r" + i + ": " + this[i];
		}
		return str;
	}
}