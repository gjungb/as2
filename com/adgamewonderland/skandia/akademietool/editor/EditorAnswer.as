/*
klasse:			EditorAnswer
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		13.02.2005
zuletzt bearbeitet:	13.02.2005
durch			gj
status:			final
*/

class com.adgamewonderland.skandia.akademietool.editor.EditorAnswer {
	
	public var text:String;
	
	public var correct:Number;
	
	public function EditorAnswer(text:String, correct:Number )
	{
		// text
		this.text = text;
		// korrektheit
		this.correct = correct;
	}
	
}  /* end class EditorAnswer */