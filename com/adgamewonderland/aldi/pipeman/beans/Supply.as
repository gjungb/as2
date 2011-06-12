/**
 * @author gerd
 */

import com.adgamewonderland.aldi.pipeman.beans.Exit;
import com.adgamewonderland.aldi.pipeman.beans.Pipe;

import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.aldi.pipeman.beans.Supply {
	
	private static var MAXCOUNT:Number = 5;
	
	private static var _instance:Supply;
	
	private var pipes:Array;
	
	private var current:Array;
	
	private var _event:EventBroadcaster;
	
	public static function getInstance():Supply {
		if (_instance == null)
			_instance = new Supply();
		return _instance;
	}
	
	public function addListener(l ):Void
	{
		_event.addListener(l);
	}
	
	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}
	
	private function Supply() {
		this.pipes = new Array();
		this.current = new Array();
		_event = new EventBroadcaster();
		
		initPipes();
	}
	
	private function initPipes():Void
	{
		var desc:String = "";
		desc += "<pipes>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_RIGHT + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_LEFT + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_UP + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_DOWN + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_UP + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_RIGHT + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_DOWN + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_LEFT + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_UP + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_RIGHT + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_RIGHT + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_DOWN + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_DOWN + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_LEFT + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_PIPE + "\" >";
		desc += "<exits>";
		desc += "<exit type=\"" + Exit.TYPE_UP + "\" />";
		desc += "<exit type=\"" + Exit.TYPE_LEFT + "\" />";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "<pipe type=\"" + Pipe.TYPE_BOMB + "\" >";
		desc += "<exits>";
		desc += "</exits>";
		desc += "</pipe>";
		desc += "</pipes>";
		var descXML:XML = new XML();
		descXML.parseXML(desc);
		
		// initilaisierung
		var pipeXML:XMLNode;
		var exitXML:XMLNode;
		var type:Number;
		var pipe:Pipe;
		var exit:Exit;
		// schleife ueber pipes
		for (var i:Number = 0; i < descXML.firstChild.childNodes.length; i++) {
			// aktuelles xml
			pipeXML = descXML.firstChild.childNodes[i];
			// type
			type = Number(pipeXML.attributes["type"]);
			// neue pipe
			pipe = new Pipe(i + 1, type);
			// schleife ueber exits
			for (var j:Number = 0; j < pipeXML.firstChild.childNodes.length; j++) {
				// aktuelles xml
				exitXML = pipeXML.firstChild.childNodes[j];
				// exit
				exit = Exit.getExit(Number(exitXML.attributes["type"]));
				// speichern
				pipe.getExits().push(exit);
			}
			// speichern
			this.pipes.push(pipe);
		}
	}
	
	public function initCurrent():Void
	{
		// bestand leeren
		this.current.splice(0);
		// anfangsbestand auffuellen
		addPipes(MAXCOUNT);
	}
	
	public function getFirst():Pipe
	{
		// erste pipe im vorrat
		return (this.current[0]);
	}
	
	public function removeFirst():Void
	{
		// erste pipe im vorrat loeschen
		this.current.shift();
		// eine pipe anfuegen
		addPipes(1);
	}
	
	public function getPipe(id:Number ):Pipe
	{
		// zurueck geben
		return this.pipes[id - 1];
	}
	
	public function getCurrent():Array {
		return current;
	}

	public function setCurrent(current:Array):Void {
		this.current = current;
	}

	public function getPipes():Array {
		return pipes;
	}

	public function setPipes(pipes:Array):Void {
		this.pipes = pipes;
	}
	
	private function addPipes(count:Number ):Void
	{
		// zufaellige pipe
		var pipe:Pipe;
		// anzahl pipes zu vorrat hinzufuegen
		for (var i:Number = 0; i < count; i++) {
			// zufaellige pipe
			this.current.push(getRandomPipe());
		}
		// event
		_event.send("onUpdateSupply");
	}
	
	private function getRandomPipe():Pipe
	{
		// per zufall eine der moeglichen
		return (this.pipes[Math.floor(this.pipes.length * Math.random())]);	
	}

}