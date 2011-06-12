/*
klasse:			EditorConnector
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			skandia
erstellung: 		05.02.2005
zuletzt bearbeitet:	22.09.2005
durch			gj
status:			final
*/

import mx.remoting.debug.NetDebug;
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;

import com.adgamewonderland.skandia.akademietool.editor.*;

class com.adgamewonderland.skandia.akademietool.editor.EditorConnector {
	
	static private var myGatewayURL:String = "http://localhost:8101/flashservices/gateway";
	
	static private var myRemoteObject:String = "com.adgamewonderland.skandia.akademietool.editor.EditorConnectorBean";
	
	static private var myService:Service;
	
	static public function loadUser(nickname:String, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// daten fuer user laden
		var pc:PendingCall = service.getUser(nickname);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadDropdownContent(caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// content fuer dropdowns laden
		var pc:PendingCall = service.getDropdownContent();
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadTaskList(caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// liste mit aufgaben laden
		var pc:PendingCall = service.getTaskList();
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadTaskListPrint(tids:Array, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// liste mit aufgaben zum drucken laden
		var pc:PendingCall = service.getTaskListPrint(tids);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadTask(tid:Number, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// aufgabe laden
		var pc:PendingCall = service.getTask(tid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function sendTask(userid:Number, task:EditorTask, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// aufgabe speichern
		var pc:PendingCall = service.saveTask(userid, task);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function deleteTask(tid:Number, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// aufgabe loeschen
		var pc:PendingCall = service.deleteTask(tid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadAnswers(tid:Number, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// antworten laden
		var pc:PendingCall = service.getAnswers(tid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadConfig(toid:Number, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// konfiguration laden
		var pc:PendingCall = service.getConfig(toid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function sendConfig(userid:Number, config:EditorConfig, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// konfiguration speichern
		var pc:PendingCall = service.saveConfig(userid, config);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadDifficultyNums(toid:Number, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// verteilung der schwierigkeitsgrade laden
		var pc:PendingCall = service.getDifficultyNums(toid);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadTaskStatistics(caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// statistik der aufgaben laden
		var pc:PendingCall = service.getTaskStatistics();
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function loadSuppliers(caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// autoren laden
		var pc:PendingCall = service.getSuppliers();
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function sendTopic(userid:Number, topic:String, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// aufgabe speichern
		var pc:PendingCall = service.saveTopic(userid, topic);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static public function sendSupplier(name:String, email:String, phone:String, caller:Object, callback:String ):Void
	{
		// service
		var service:Service = getService();
		// autor speichern
		var pc:PendingCall = service.saveSupplier(name, email, phone);
		// rueckgabe von rmi auswerten
		pc.responder = new RelayResponder(caller, callback, "onConnectorFault");
	}
	
	static private function getService():Service
	{
		// testen, ob service schon instantiiert
		if (myService instanceof Service == false) {
			// debugger
			NetDebug.initialize();
			// offline / online
			if (_url.indexOf("http://") == -1) {
				// remoting service mit url
				myService = new Service(myGatewayURL, null, myRemoteObject, null, null);
			} else {
				// remoting service ohne url
				myService = new Service("", null, myRemoteObject, null, null);
			}
		}
		// zurueck geben
		return myService;
	}
	
} /* end class EditorConnector */