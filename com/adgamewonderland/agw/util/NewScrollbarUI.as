import com.adgamewonderland.agw.interfaces.IEventBroadcaster;
import com.adgamewonderland.agw.util.EventBroadcaster;

/**
 * Nachbildung einer brauchbaren Scrollbar UI
 * @author Harry
 */
class com.adgamewonderland.agw.util.NewScrollbarUI extends MovieClip implements IEventBroadcaster {

	// events auslösen an alle dies interessiert
	private var _event:EventBroadcaster;
	private var eventTargets:Array;

	private var _mode		:Number;		// 0 Vertikal 1 Vertikal

	private var _currPos	:Number;		// Wo steht der Scrollbalken
	private var _minPos		:Number;		// Minimal
	private var _maxPos		:Number;		// Maximal
	private var _stepWidth	:Number;		// Wieviele Punkte bei Up / Down oder Left / Right
	private var _stepMulti	:Number;		// Wieviele _stepWidth bei PageUp / Down

	private var thumb_mc	:MovieClip;		// Balken (draggs Ding)
	private var button1_mc	:MovieClip;		// links / Hoch
	private var button2_mc	:MovieClip;		// rechts / runter

	private var	_scrollStepHori	:Number;
	private var	_scrollStepVert	:Number;
	private var _scrollBasis	:Number;
	private var timerNumber	:Number;


	/**
	 * Konstruktor
	 */
	function NewScrollbarUI() {
		super();

		_event = new EventBroadcaster();
		eventTargets = new Array();

		_scrollStepHori = 0;
		_scrollStepVert = 0;
		_scrollBasis	= 0;
		_mode			= 0;		// vertikal
		timerNumber		= -1;
	}

	public function onLoad () : Void {
		init();
	}

	public function onUnload () : Void {
	}

	private function init() : Void {
		enableActions();
	}

	public function enableActions () : Void {
		button1_mc.onPress = function () {
			this._parent.startAutomaticScroll(1);
		};
		button1_mc.onRelease = button1_mc.onReleaseOutside = function () {
			// scrollen stoppen
			this._parent.stopAutomaticScroll();
		};
		button2_mc.onPress = function () {
			this._parent.startAutomaticScroll(0);
		};
		button2_mc.onRelease = button2_mc.onReleaseOutside = function () {
			// scrollen stoppen
			this._parent.stopAutomaticScroll();
		};
	}

	public function disableActions () : Void {
		button1_mc.onPress = function () {
			super();
		};
		button1_mc.onRelease = button1_mc.onReleaseOutside = function () {
			super();
		};
		button2_mc.onPress = function () {
			super();
		};
		button2_mc.onRelease = button2_mc.onReleaseOutside = function () {
			super();
		};
	}

	/**
	 * dir = 0 -> rechts,runter
	 * dir = 1 -> links,rauf
	 */
	private function startAutomaticScroll (dir:Number) : Void {
		// schleife fuer scrollen starten
		timerNumber = setInterval(
			this, "scrollTarget", 50, dir);
	}
	private function stopAutomaticScroll () : Void {
		clearInterval (timerNumber);
	}
	private function scrollTarget(dir:Number ):Void {
		if (dir == 0) {
			scrollRight();
		}
		if (dir == 1) {
			scrollLeft();
		}
		_event.send("afterScrollPosChanged",this,getCurrPos());
	}

	/**
	 * Funktionen um Kommandos zu behandeln
	 *
	 */
	public function setMode (value:Number) : Void {
		this._mode = value;
	}
	public function getMode () : Number {
		return this._mode;
	}

	public function getCurrPos () : Number {
		return _currPos;
	}
	public function setCurrPos (value:Number) : Void {
		if (value > _maxPos)
			value = _maxPos;
		if (value < _minPos)
			value = _minPos;
		_currPos = value;
	}
	public function getMinPos () : Number {
		return _minPos;
	}
	public function setMinPos (value:Number) : Void {
		_minPos = value;
	}
	public function getMaxPos () : Number {
		return _maxPos;
	}
	public function setMaxPos (value:Number) : Void {
		_maxPos = value;
	}
	public function getStepWidth () : Number {
		return _stepWidth;
	}
	public function setStepWidth (value:Number) : Void {
		_stepWidth = value;
	}
	public function getStepMulti () : Number {
		return _stepMulti;
	}
	public function setStepMulti (value:Number) : Void {
		_stepMulti = value;
	}
	public function setParameter (minPos:Number,maxPos:Number,stepWidth:Number) : Void {
		setMinPos	(minPos);
		setMaxPos	(maxPos);
		setStepWidth(stepWidth);
		setStepMulti(stepWidth);
	}

	public function calculateScrollPara () : Void {
		// berrechne neue Eckwerte
		var clcBr : Number = 0;

		if (_mode == 0) {	// vertikal
			clcBr = this._height - (button1_mc._height + button2_mc._height + thumb_mc._height);
			_scrollStepVert = clcBr / (_maxPos - _minPos);
			_scrollStepHori = 0;
			_scrollBasis	= button1_mc._height + thumb_mc._height / 2;
		}
		if (_mode == 1) {	// horizontal
			clcBr = this._width - (button1_mc._width + button2_mc._width + thumb_mc._width);
			_scrollStepHori = clcBr / (_maxPos - _minPos);
			_scrollStepVert = 0;
			_scrollBasis	= button1_mc._width + thumb_mc._width / 2;
		}
		trace ("Calc -- " + thumb_mc._x + " -- " + thumb_mc._y + " -- " + _currPos + " -- " + _stepWidth + " -- " + _scrollStepVert);
	}

	// Alle Aktionen werden über Events augelöst ???
	public function scrollUp ()	: Void {
		scrollTo (_stepWidth * -1);
	}
	public function scrollLeft () : Void {
		scrollTo (_stepWidth * -1);
	}
	public function scrollDown () : Void {
		scrollTo (_stepWidth);
	}
	public function scrollRight () : Void {
		scrollTo (_stepWidth);
	}
	public function scrollPageUp () : Void {
		scrollTo (_stepWidth * _stepMulti * -1);
	}
	public function scrollPageDown () : Void {
		scrollTo (_stepWidth * _stepMulti);
	}
	public function scrollPos1 () : Void {
		setCurrPos (_minPos);
	}
	public function scrollEnd () : Void {
		setCurrPos (_maxPos);
	}

	private function scrollTo (scrollVal:Number) : Void {
		setCurrPos (_currPos + scrollVal);
	}

	public function updateThumb () : Void {
		if (_mode == 0) {
			thumb_mc._x = thumb_mc._x;
			thumb_mc._y = _scrollBasis + _currPos * _stepWidth * _scrollStepVert;

			trace ("Thumb -- " + thumb_mc._x + " -- " + thumb_mc._y + " -- " + _currPos + " -- " + _stepWidth + " -- " + _scrollStepVert);
			return;
		}
		if (_mode == 1) {
			thumb_mc._y = thumb_mc._y;
			thumb_mc._x = _scrollBasis + _currPos * _stepWidth * _scrollStepHori;

			trace ("Thumb -- " + thumb_mc._x + " -- " + thumb_mc._y + " -- " + _currPos + " -- " + _stepWidth + " -- " + _scrollStepVert);
			return;
		}
	}

	/**
	 * Funktionen für Broadcaster
	 */
	public function addListener(l : Object) : Void {
		this._event.addListener(l);
	}

	public function removeListener(l : Object) : Void {
		this._event.removeListener(l);
	}

}