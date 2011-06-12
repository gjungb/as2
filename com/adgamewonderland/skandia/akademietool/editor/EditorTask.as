/*
klasse:			EditorTask
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		13.02.2005
zuletzt bearbeitet:	14.02.2005
durch			gj
status:			final
*/

class com.adgamewonderland.skandia.akademietool.editor.EditorTask {
	
	public var tid:Number;
	
	public var question:String;
	
	public var answers:Array;
	
	public var explanation:String;
	
	public var difficulty:Number;
	
	public var topic:Number;
	
	public var active:Number;
	
	public var supplier:Number;
	
	public function EditorTask(tid:Number )
	{
		// task id
		this.tid = tid;
		// frage
		this.question = "";
		// antworten (als EditorAnswer)
		this.answers = [];
		// erlaeuterung
		this.explanation = "";
		// schwierigkeitsgrad
		this.difficulty = 0;
		// themengebiet
		this.topic = 0;
		// aktivitaet
		this.active = 0;
		// autor
		this.supplier = 0;
	}
	
}  /* end class EditorTask */