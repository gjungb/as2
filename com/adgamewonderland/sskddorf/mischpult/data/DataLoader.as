/**
 * @author gerd
 */
 
import mx.rpc.ResultEvent;

import mx.remoting.RecordSet;

import de.kruesch.event.*;
 
import com.adgamewonderland.sskddorf.mischpult.connectors.*;
 
import com.adgamewonderland.sskddorf.mischpult.data.*;
 
class com.adgamewonderland.sskddorf.mischpult.data.DataLoader {
	
	private var state:Number;
	
	private var _event:EventBroadcaster;
	
	public function DataLoader() {
		// aktueller status
		this.state = 0;
		// event
		_event = new EventBroadcaster();
	}
	
	public function loadData():Void
	{
		// welche daten sollen geladen werden
		var name:String = DataProvider.getInstance().getName(getState());
		// funktionsname zum laden der daten
		var fn:Function = MischpultConnector["load" + name];
		// aufrufen
		fn.apply(MischpultConnector, [this, "onDataLoaded"]);
	}
	
	public function onDataLoaded(re:ResultEvent ):Void
	{
		// welche daten wurden geladen
		var name:String = DataProvider.getInstance().getName(getState());
		// funktionsname zum speichern der daten
		var fn:Function = DataProvider.getInstance()["set" + name];
		// aufrufen
		fn.apply(DataProvider.getInstance(), [RecordSet(re.result)]);
		// status hochzaehlen
		if (incrementState() == false) {
			// callback aufrufen
			_event.send("onDataPartlyLoaded", getState() / DataProvider.getInstance().getNumNames() * 100);
			// naechste daten laden
			loadData();	
		} else {
			// callback aufrufen
			_event.send("onDataLoaded", null);
		}
	}
	
	public function addListener(l ):Void
	{
		_event.addListener(l);
	}
	
	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}

	public function getState():Number {
		return state;
	}

	public function setState(state:Number):Void {
		this.state = state;
	}
	
	private function incrementState():Boolean
	{
		// fertig?
		var finished:Boolean = false;
		// status hochzaehlen
		setState(getState() + 1);
		// testen, ob fertig
		if (getState() == DataProvider.getInstance().getNumNames()) {
			// fertig
			finished = true;
		}
		// zurueck geben, ob fertig
		return finished;
	}

}