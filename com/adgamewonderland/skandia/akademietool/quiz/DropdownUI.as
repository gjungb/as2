/*klasse:			DropdownUIautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			skandiaerstellung: 		17.12.2004zuletzt bearbeitet:	12.02.2005durch			gjstatus:			final*/class com.adgamewonderland.skandia.akademietool.quiz.DropdownUI extends MovieClip {	// Attributes		private var _myName:String;		private var _myCaller:Object;		private var _myCallback:String;		private var _myYDiff:Number;		private var myItems:Array;		private var isDropped:Boolean;		private var myCurrent:Number;		private var item_mc:MovieClip;	 	private var name_txt:TextField;		// Operations		public function DropdownUI()	{		// name, der vor erster benutzung im dropdown angezeigt wird		_myName = "";		// caller, der bei klick auf ein item informiert wird 		_myCaller = null;		// callback bei klick auf ein item 		_myCallback = "";		// y-abstand zwischen den items 		_myYDiff = 0;		// anzuzeigende items ({name, value}-paare)		myItems = [];		// schalter, ob dropdown ausgeklappt ist		isDropped = false;		// aktuell angezeigtes item		myCurrent = 0;		// button aktivieren		item_mc.onRelease = function () {			this._parent.onPressBack();		}	}		public function set current(num:Number ):Void	{		// aktuell angezeigtes item		myCurrent = num;	}		public function get current():Number	{		// aktuell angezeigtes item		return myCurrent;	}		public function initDropdownUI(name:String, names:Array, values:Array, caller:Object, callback:String, ydiff:Number ):Void	{		// anzuzeigende items und die dazu gehoerigen werte		myItems.splice(0);		// name		_myName = name;		// anzeigen		name_txt.text = name;		// schleife ueber alle items		for (var i:Number = 0; i < names.length; i ++) {			// neues item			myItems.push({name : names[i], value : values[i]});		}		// caller		_myCaller = caller;		// callback bei klick auf ein item		_myCallback = callback;		// y-abstand zwischen den items		if (ydiff != null) _myYDiff = ydiff;	}		public function showItems(bool:Boolean ):Void 	{		// aktivitaet umschalten		isDropped = bool;		// zaehler		var i:Number = -1;		// schleife ueber alle werte		while (++i < myItems.length) {			// ein oder aus			switch (bool) {				// aufbauen				case true :					// position auf buehne					var pos:Object = {x : 0, y : (i + 1) * _myYDiff};					// text des items					var name:String = myItems[i].name;					// item duplizieren					var item:MovieClip = item_mc.duplicateMovieClip("item" + i + "_mc", i, {_x : pos.x, _y : pos.y, myNum : i, myName : name});					// callback bei druecken					item.onRelease = function () {						// dieses item auswaehlen						this._parent.onSelectItem(this.myNum);					}					break;								// abbauen				case false :					// loeschen					this["item" + i + "_mc"].removeMovieClip();						break;			}		}	}		// 	public function onPressBack():Void	{		// items ein- / ausblenden		showItems(!isDropped);	}		public function onSelectItem(num:Number ):Void	{		// entsprechendes item		var item:Object = myItems[num];		// text des items		name_txt.text = item.name;		// aktuell angezeigtes item		current = item.value;		// callback ausfuehren		_myCaller[_myCallback](item.value);		// items ausblenden		showItems(false);	}} /* end class DropdownUI */