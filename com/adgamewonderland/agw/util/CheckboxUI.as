/*klasse:			CheckboxUIautor: 			gerd jungbluth, adgamewonderlandemail:			gerd.jungbluth@adgamewonderland.dekunde:			agwerstellung: 		06.12.2004zuletzt bearbeitet:	15.06.2005durch			gjstatus:			final*/class com.adgamewonderland.agw.util.CheckboxUI extends MovieClip {	// Attributes		private var myStatus:Boolean;		private var cross_mc:MovieClip;		private var check_mc:MovieClip;		// Operations		// konstruktor	public function CheckboxUI()	{		// status der checkbox		status = false;		// status wechseln		check_mc.onRelease = function () {			this._parent.switchStatus();		};	}		public function set status(bool:Boolean ):Void	{		// status der checkbox		myStatus = bool;		// kreuz ein- / ausblenden		cross_mc._visible = bool;	}		public function get status():Boolean	{		// status der checkbox		return (myStatus);	}		public function switchStatus():Void	{		// status wechseln		status = !status;	}		public function setEnabled(bool:Boolean ):Void	{		// an- / ausschalten		check_mc.enabled = bool;	}		public function getStatus():Boolean {
		return myStatus;
	}

	public function setStatus(status:Boolean ):Void {
		this.myStatus = status;
	}

}