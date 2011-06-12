/*
klasse:			DropdownContent
autor: 			gerd jungbluth, adgamewonderland
email:			gerd.jungbluth@adgamewonderland.de
kunde:			skandia
erstellung: 		03.02.2005
zuletzt bearbeitet:	08.02.2005
durch			gj
status:			final
*/  

class com.adgamewonderland.skandia.akademietool.editor.DropdownContent {
	
	private var myDifficulties:Array;
	
	private var myTopics:Array;
	
	private var mySuppliers:Array;
	
	private var myActivities:Array;
	
	public function DropdownContent()
	{
		// schwierigkeitsgrade
		myDifficulties = [];
		// themengebiete
		myTopics = [];
		// autoren
		mySuppliers = [];
		// aktivitaeten
		myActivities = [0, 1];	
	}
	
	public function set difficulties(darr:Array ):Void
	{
		// schwierigkeitsgrade
		myDifficulties = darr;
	}
	
	public function get difficulties():Array
	{
		// schwierigkeitsgrade
		return myDifficulties;
	}
	
	public function set topics(tarr:Array ):Void
	{
		// themengebiete
		myTopics = tarr;
	}
	
	public function get topics():Array
	{
		// themengebiete
		return myTopics;
	}
	
	public function set suppliers(sarr:Array ):Void
	{
		// autoren
		mySuppliers = sarr;	
	}
	
	public function get suppliers():Array
	{
		// autoren
		return mySuppliers;
	}
	
	public function get activities():Array
	{
		// aktivitaeten
		return myActivities;
	}
	
} /* end class DropdownContent */