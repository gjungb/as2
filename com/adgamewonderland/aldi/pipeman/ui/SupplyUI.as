/**
 * @author gerd
 */

import com.adgamewonderland.aldi.pipeman.beans.Pipe;
import com.adgamewonderland.aldi.pipeman.beans.Supply;
import com.adgamewonderland.aldi.pipeman.ui.PipeUI;

class com.adgamewonderland.aldi.pipeman.ui.SupplyUI extends MovieClip {
	
	private static var PIPESX:Number = 706; // 724;
	
	private static var PIPESY:Number = 192;
	
	private static var PIPESYDIFF:Number = 30;
	
	private static var MASKX:Number = 706;
	
	private static var MASKY:Number = 189;
	
	private static var MASKWIDTH:Number = 62;
	
	private static var MASKHEIGHT:Number = 150;
	
	private var pipes:Array;
	
	private var pipes_mc:MovieClip;
	
	public function SupplyUI() {
		// registrieren
		Supply.getInstance().addListener(this);
		
	}
	
	public function onLoad():Void
	{
		// pipes
		this.pipes = new Array();
	}
	
	public function onUpdateSupply():Void
	{
		// anzuzeigende pipes
		var current:Array = Supply.getInstance().getCurrent();
		// aktuelle pipe
		var pipe:Pipe;
		// angezeigte pipe
		var pipeui:PipeUI;
		// constructor
		var constructor:Object;
		// schleife ueber anzuzeigende pipes
		for (var i:Number = 0; i < current.length; i++) {
			// aktuelle pipe
			pipe = current[i];
			// constructor
			constructor = {_x : PIPESX, _y : PIPESY + (current.length - 1 - i) * PIPESYDIFF, _pipe : pipe};
			// pipeui
			pipeui = PipeUI(pipes_mc.attachMovie("PipeUI", "pipeui" + i + "_mc", i + 1, constructor));
			// speichern
			this.pipes[i] = pipeui;
		}
		// maske setzen
		showMask();
	}
	
	private function showMask():Void
	{
		// neues mc
		var mc:MovieClip = this.createEmptyMovieClip("mask_mc", 1);
		// als maske setzen
		this.pipes_mc.setMask(mc);
		// an startpunkt
		mc.moveTo(MASKX, MASKY);
		// fuellung
		mc.beginFill(0xCCCCCC, 50);
		// nach rechts
		mc.lineTo(MASKX + MASKWIDTH, MASKY);
		// nach unten
		mc.lineTo(MASKX + MASKWIDTH, MASKY + MASKHEIGHT);
		// nach links
		mc.lineTo(MASKX, MASKY + MASKHEIGHT);
		// nach oben
		mc.lineTo(MASKX, MASKY);
	}
	
	
}