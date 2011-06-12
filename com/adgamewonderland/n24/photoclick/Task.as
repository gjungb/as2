/* Task
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Task
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			n24
erstellung: 		16.09.2004
zuletzt bearbeitet:	24.11.2004
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.n24.photoclick.Task extends MovieClip {

	// Attributes
	
	private var _myColors:Object; // farben
	
	private var myCorrect:Number; // korrekte antwort
	
	private var myAnswers:Array; // movieclips der antworten
	
	private var question_txt:TextField;
	
	private var answer1_mc:MovieClip, answer2_mc:MovieClip, answer3_mc:MovieClip;
	
	// Operations
	
	// rechteck mit linker oberer ecke, breite und hoehe
	public  function Task()
	{
		// korrekte antwort
		myCorrect = 0;
		// movieclips der antworten
		myAnswers = [answer1_mc, answer2_mc, answer3_mc];
	}
	
	// eins der segemente zufaellig loeschen
	public function showTask(task:XMLNode ):Void
	{
		// korrekte antwort
		myCorrect = Number(task.attributes.correct);
		// frage
		var question:String = task.firstChild.firstChild.nodeValue;
		// frage anzeigen
		question_txt.autoSize = "left";
		question_txt.text = question;
		// frage aus xml loeschen
		task.firstChild.removeNode();
		// zufaelliges array zum mischen der antworten
		var rand:Array = _parent.getRandomNumArray(task.childNodes.length, 1, task.childNodes.length, 1);
		// text neben der antwort
		var labels:Array = ["A", "B", "C"];
		// antworten verteilen
		for (var i:String in rand) {
			// aktuelle antwort
			var answer:XMLNode = task.firstChild;
			// antwort nummer
			var anum:Number = Number(answer.attributes.num);
			// antwort text
			var atext:String = answer.firstChild.nodeValue;
			// antwort aus xml loeschen
			answer.removeNode();
			
			// antwort anzeigen
			var mc:MovieClip = this["answer" + rand[i] + "_mc"];
			// nummer
			mc.myNum = anum;
			// label
			mc.label_txt.autoSize = "left";
			mc.label_txt.text = labels[rand[i] - 1];
			// text
			mc.answer_txt.autoSize = "left";
			mc.answer_txt.html = true;
			mc.answer_txt.htmlText = "<FONT COLOR=\"#" + _myColors.up+ "\">" + atext + "</FONT>";
			// kein over
			mc.gotoAndStop("_up");
			// als button behandeln
			mc.onRelease = function () {
				// kein over
				this.gotoAndStop("_up");
				// text einfaerben
				this.answer_txt.textColor = this.label_txt.textColor = parseInt("0x" + this._parent._myColors.up);
				// frage beantworten
				this._parent.answerQuestion(this, this.myNum);
			}
			// bei mouse over farbe aendern
			mc.onRollOver = function () {
				// text einfaerben
				this.answer_txt.textColor = this.label_txt.textColor = parseInt("0x" + this._parent._myColors.over);
			}
			// bei mouse out farbe aendern
			mc.onRollOut = mc.onReleaseOutside = mc.onDragOut = function () {
				// text einfaerben
				this.answer_txt.textColor = this.label_txt.textColor = parseInt("0x" + this._parent._myColors.up);
			}
		}
		// buttons einschalten
		setActive(true);
	}
	
	// frage wird beantwortet
	public function answerQuestion(mc:MovieClip, num:String ):Void
	{
		// korrekt geantwortet?
		var correct:Boolean = (num == myCorrect);
		// meldung anzeigen
		mc.answer_txt.htmlText = (correct ? "<FONT COLOR=\"#" + _myColors.correct+ "\">RICHTIG!</FONT>" : "<FONT COLOR=\"#" + _myColors.incorrect + "\">LEIDER FALSCH!</FONT>");
		// an spiel uebergeben, ob korrekt geantwortet
		_parent.solveTask(correct);
	}
	
	// buttons ein-/ ausschalten
	public function setActive(bool:Boolean ):Void
	{
		// buttons umschalten
		for (var i:String in myAnswers) myAnswers[i].enabled = bool;
	}
	
} /* end class Task */
