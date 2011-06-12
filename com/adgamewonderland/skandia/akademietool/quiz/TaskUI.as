/*klasse:			TaskUIautor: 			gerd jungbluth, adgamewonderlandemail:			gerd.jungbluth@adgamewonderland.dekunde:			skandiaerstellung: 		06.12.2004zuletzt bearbeitet:	26.01.2005durch			gjstatus:			final*/import com.adgamewonderland.skandia.akademietool.quiz.*;class com.adgamewonderland.skandia.akademietool.quiz.TaskUI extends MovieClip {	// Attributes		private var myQuizUI:QuizUI;		private var myTask:Task;		private var myAnswermcs:Array;		private var answer1_mc:AnswerUI;		private var answer2_mc:AnswerUI;		private var answer3_mc:AnswerUI;		private var answer4_mc:AnswerUI;		private var index_txt:TextField;		private var max_txt:TextField;		private var question_txt:TextField;		private var hint_mc:HintUI;		private var explanation_mc:ExplanationUI;		private var image_mc:ImageUI;		private var shutter_mc:ShutterUI;		private var shutterbubble_mc:ShutterUI;		private var close_mc:MovieClip;		// Operations		// konstruktor	public function TaskUI( )	{		// quiz		myQuizUI = QuizUI(_parent);		// aktuelle aufgabe		myTask = null;		// antworten movieclips		myAnswermcs = [answer1_mc, answer2_mc, answer3_mc, answer4_mc];		// headline zentriert		index_txt.autoSize = "center";		max_txt.autoSize = "center";		// frage linksbuendig		question_txt.autoSize = "left";		// schliessen button		close_mc.onRelease = function () {			// blende einblenden, dann aufgabe schliessen			this._parent.shutter_mc.showShutter("show", this._parent, "closeTask", null);		}				// ausblenden		this._visible = false;	}		public function showTask(task:Task, max:Number ):Void	{		// aktuelle aufgabe		myTask = task;		// headline anzeigen		index_txt.text = (myTask.index + 1);		max_txt.text = String(max);		// frage anzeigen		question_txt.text = myTask.question.text;		// antworten		var answers:Array = myTask.answers;		// shufflen		answers.sort(function (e1, e2) { return (Math.floor(Math.random() * 3) - 1); });		// counter fuer antworten		var count:Number = -1;		// antworten anzeigen		while (answers[++count] instanceof Answer) {			// anzeigen			myAnswermcs[count].showAnswer(answers[count], count);			// einblenden			myAnswermcs[count]._visible = true;			// editierbar			// myAnswermcs[count].setEditable(true);		}		// hinweis auf anzahl korrekter antworten anzeigen		hint_mc.showHint(myTask.hint);		// hinweis einblenden		hint_mc._visible = true;		// abbildung einblenden		setImage(myTask.image);		// schliessen button ausblenden		close_mc._visible = false;				// blende ausblenden		shutterbubble_mc.showShutter("hide", null, null, null);		// aufgabe einblenden		this._visible = true;	}		public function solveTask():Boolean	{		// punktzahl fuer das korrekte beantworten		var score:Number = myTask.getScore();		// korrekt geloest		var correct:Boolean = (score != 0);		// testen, ob korrekt		if (correct) {			// korrekt, naechste aufgabe anzeigen			myQuizUI.changeTaskByDir(1);		} else {			// nicht korrekt, blende einblenden, dann erklaerung einblenden			shutterbubble_mc.showShutter("show", this, "showExplanation", null);		}		// zurueck geben, ob korrekt		return(correct);	}		public function showExplanation():Void	{		// blende ausblenden		shutterbubble_mc.showShutter("hide", null, null, null);		// aufgabe ausblenden		hideTask();		// erklaerung anzeigen lassen		explanation_mc.showExplanation(myTask);		// schliessen button einblenden		close_mc._visible = true;		// schliessen button animieren		close_mc.gotoAndPlay(1);	}		public function setImage(img:Image ):Void	{		// ggf. abbildung		if (img.src != undefined) {			// informationen ueber abbildung			image_mc.image = img;			// einblenden			image_mc._visible = true;					} else {			// ausblenden			image_mc._visible = false;		}	}		public function closeTask():Void	{		// blende ausblenden		shutter_mc.showShutter("hide", null, null, null);		// aufgabe ausblenden		hideTask();		// naechste aufgabe		myQuizUI.changeTaskByDir(1);	}		public function hideTask():Void	{		// antworten ausblenden		for (var i:String in myAnswermcs) myAnswermcs[i]._visible = false;		// antworten nicht mehr editierbar		// for (var i:String in myAnswermcs) myAnswermcs[i].setEditable(false);		// hinweis ausblenden		hint_mc._visible = false;		// abbildung ausblenden		image_mc.showImage(false);		// erklaerung ausblenden		explanation_mc.hideExplanation();		// schliessen button ausblenden		close_mc._visible = false;	}	} /* end class TaskUI */