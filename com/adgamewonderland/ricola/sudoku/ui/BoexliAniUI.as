﻿import com.adgamewonderland.ricola.sudoku.ui.BoexliUI;import com.adgamewonderland.ricola.sudoku.interfaces.IBoexliLoader;import com.adgamewonderland.ricola.sudoku.ui.SupplyUI;import com.adgamewonderland.aldi.sudoku.beans.Grid;import com.adgamewonderland.aldi.sudoku.interfaces.IGridListener;import com.adgamewonderland.aldi.sudoku.beans.Field;/** * @author gerd */class com.adgamewonderland.ricola.sudoku.ui.BoexliAniUI extends MovieClip implements IBoexliLoader, IGridListener {		private var _content:Number;		private var boexli_mc:BoexliUI;			public function BoexliAniUI() {		// registrieren		SupplyUI(_parent).registerBoexli(this);	}		public function init():Void	{		// als listener registrieren		Grid.getInstance().addListener(this);		// kein mauszeiger		useHandCursor = false;		// deaktivieren		enabled = false;		// sichtbar		_alpha = 100;	}		public function onRollOver():Void	{		// animation		showAni();	}		public function onRollOut():Void	{		// ausblenden		hideAni();	}		public function onDragOut():Void	{		onRollOut();		} 		function showAni():Void	{		// animation abspielen		if (_currentframe == 1) {			gotoAndPlay("frIn");			}		// callback		SupplyUI(_parent).onShowBoexliAni(this);	}		function hideAni():Void	{		// zurueck springen		if (_currentframe != 1) {			gotoAndStop(1);			}	}		/**	 * @deprecated	 */	public function isOpen():Boolean	{		// true, wenn ganz ausgefahren			return (_currentframe == _totalframes);	}		public function getBoexliContent() : Number {		// content zurueck geben		return _content;	}	public function onGridChanged(field : Field) : Void {		// alle boexli dieser sorte fertig		var finished:Boolean = Grid.getInstance().getContentcounter().getCount(_content) == 9;		// entsprechend anzeigen		if (finished) {			// TODO: animation oder was auch immer			_alpha=50;		}	}	public function onGridFinished() : Void {		// als listener deregistrieren		Grid.getInstance().removeListener(this);	}}