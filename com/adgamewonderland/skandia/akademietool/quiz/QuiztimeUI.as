/*klasse:			QuiztimeUIautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			skandiaerstellung: 		09.12.2004zuletzt bearbeitet:	20.01.2005durch			gjstatus:			final*/import com.adgamewonderland.skandia.akademietool.interfaces.*;import com.adgamewonderland.skandia.akademietool.quiz.*;class com.adgamewonderland.skandia.akademietool.quiz.QuiztimeUI extends MovieClip implements ITimeUI {	// Attributes		private var bar_mc:MovieClip;		private var time_txt:TextField;		// Operations		// konstruktor	public function QuiztimeUI( )	{		// zeitanzeige linksbuendig		time_txt.autoSize = "left";		// initialisieren		init();	}		public function init():Void	{		// zeitbalken ausblenden		bar_mc._visible = false;		// zeitanzeige ausblenden		time_txt._visible = false;	}		public function showTime(tobj:Quiztime ):Void	{		// zeitbalken einblenden		bar_mc._visible = true;		// zeitbalken skalieren		bar_mc._xscale = tobj.getPercent();		// zeitanzeige einblenden		time_txt._visible = true;		// sekunden (total, gone, left)		var seconds:Object = tobj.getSeconds();		// formatieren (hours, minutes, seconds)		var time:Object = getFormattedTime(seconds.left);		// zeitanzeige		time_txt.text = "Zeit: " + time.hours + ":" + time.minutes + ":" + time.seconds;	}		private function leadingZero(num:Number ):String	{		// in string umwandeln		var str:String = num.toString();		// falls kuerzer als zwei zeichen		if (str.length < 2) {			// nullen vorne dran			str = "0" + str;		}		// zurueck geben		return (str);	}		private function getFormattedTime(snum:Number ):Object	{		// sekunden in stunden		var hours:Number = snum / 3600;		// dezimale minuten in minuten		var minutes:Number = Math.floor((hours - Math.floor(hours)) * 60);		// bei 60 minuten korrigieren		if (minutes == 60) {			// minuten auf 0			minutes = 0;			// stunden eine mehr			hours += 1;		}		// stunden abrunden		hours = Math.floor(hours);		// verbleibende sekunden		var seconds:Number = snum - (hours * 3600 + minutes * 60);		// als object zurueck geben		return ({hours : leadingZero(hours), minutes : leadingZero(minutes), seconds : leadingZero(seconds)});	}	} /* end class QuiztimeUI */