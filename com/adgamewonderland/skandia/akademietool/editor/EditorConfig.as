/*
klasse:			EditorConfig
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		15.02.2005
zuletzt bearbeitet:	06.04.2005
durch			gj
status:			final
*/

class com.adgamewonderland.skandia.akademietool.editor.EditorConfig {
	
	public var toid:Number;
	
	public var numtasks:Number;
	
	public var timequiz:Number;
	
	public var nickname:String;
	
	public var lastupdate:String;
	
	public var difficultynums:Array;
	
	public var sumtasks:Number;
	
	public var maxtasks:Object;
	
	public function EditorConfig(toid:Number )
	{
		// themengebiet
		this.toid = toid;
		// anzahl aufgaben
		this.numtasks = 0;
		// dauer des quiz
		this.timequiz = 0;
		// nickname des users, der zuletzt gespeichert hat
		this.nickname = "";
		// datum des letzten speicherns
		this.lastupdate = "";
		// verteilung der aufgaben auf schwierigkeitsgrade fuer gemischtes quiz (als EditorDifficulty)
		this.difficultynums = [];
		// summe der fragen zum themengebiet
		this.sumtasks = 0;
		// maximale anzahl an fragen, die im quiz gestellt werden darf (resultiert aus kleinster anzahl fragen zu einem schwierigkeitsgrad)
		this.maxtasks = {num : Number.MAX_VALUE, difficulty : 0};
	}
	
}  /* end class EditorConfig */