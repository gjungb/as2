/*klasse:			Answerautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			skandiaerstellung: 		03.12.2004zuletzt bearbeitet:	06.12.2004durch			gjstatus:			final*/class com.adgamewonderland.skandia.akademietool.quiz.Answer {	// Attributes		private var myText:String;		private var isCorrect:Boolean = false;		private var isChecked:Boolean = false;		// Operations		// konstruktor	public function Answer(astr:String, correct:Boolean )	{		// text der antwort		myText = astr;		//  ist die antwort korrekt		isCorrect = correct;		// ist die antwort angekreuzt		isChecked = false;	}		public function get text():String	{		//  text der antwort		return (myText);	}		public function get correct():Boolean	{		//  ist die antwort korrekt		return (isCorrect);	}		public function set checked(bool:Boolean ):Void	{		// ist die antwort angekreuzt		isChecked = bool;	}		public function get checked():Boolean	{		// ist die antwort angekreuzt		return (isChecked);	}		public function getScore():Number	{		// punktzahl fuer korrekte / nicht korrekte beantwortung		var score:Number = Number(isCorrect == checked);		// zurueck geben		return (score);	}	} /* end class Answer */