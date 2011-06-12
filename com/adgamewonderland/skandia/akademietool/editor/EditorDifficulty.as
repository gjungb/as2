/*
klasse:			EditorDifficulty
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		15.02.2005
zuletzt bearbeitet:	15.02.2005
durch			gj
status:			final
*/

class com.adgamewonderland.skandia.akademietool.editor.EditorDifficulty {
	
	public var did:Number;
	
	public var numtasks:Number;
	
	public var maxtasks:Number;
	
	public function EditorDifficulty(did:Number, numtasks:Number, maxtasks:Number )
	{
		// schwierigkeitsgrad
		this.did = did;
		// konfigurierte anzahl aufgaben
		this.numtasks = numtasks;
		// maximale anzahl aufgaben
		this.maxtasks = maxtasks;
	}
	
}  /* end class EditorDifficulty */