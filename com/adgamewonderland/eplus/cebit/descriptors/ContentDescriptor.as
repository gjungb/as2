/* 
 * Generated by ASDT 
*/ 

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

class com.adgamewonderland.eplus.cebit.descriptors.ContentDescriptor {
	
	private var myPath:Array;
	
	private var myMenuName:String;
	
	private var myHasContent:Boolean;
	
	private var myIntroText:String;
	
	private var myWidth:Number;
	
	private var myHeight:Number;
	
	private var isLoaded:Boolean;
	
	public function ContentDescriptor(parr:Array, mstr:String, cbool:Boolean, istr:String, wnum:Number, hnum:Number )
	{
		// pfad mit 5 buchstaben code
		myPath = parr;
		// menu name, der angezeigt wird
		myMenuName = mstr;
		// wird bei klick entsprechender content angezeigt
		myHasContent = cbool;
		// intro text
		myIntroText = istr;
		// breite der content box
		myWidth = wnum;
		// hoehe der content box
		myHeight = hnum;
		// content swf vollstaendig geladen
		isLoaded = false;
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
}