/* 
 * Generated by ASDT 
*/ 

import mx.rpc.ResultEvent;

import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.aldi.ecard.beans.Ecard;
import com.adgamewonderland.aldi.ecard.beans.Layout;
import com.adgamewonderland.aldi.ecard.beans.User;
import com.adgamewonderland.aldi.ecard.connectors.EcardConnector;
import com.adgamewonderland.aldi.ecard.ui.BackgroundUI;
import com.adgamewonderland.aldi.ecard.ui.StageUI;
import com.adgamewonderland.aldi.ecard.ui.ToolbarUI;

class com.adgamewonderland.aldi.ecard.ui.EcardUI extends MovieClip {
	
	private var toolbar_mc:ToolbarUI;
	
	private var stage_mc:StageUI;
	
	private var background_mc:BackgroundUI;
	
	public function EcardUI() {
		_global.EcardUI = this;
	}
	
	public function initEcard(id:Number, cryptid:String ):Void
	{
		// testen, ob beide korrekt uebergeben
		if (!isNaN(id) && cryptid.length == 32) {
			// ecard anzeigen
			toolbar_mc.setMode(ToolbarUI.MODE_RECEIVE);
			// ecard laden
			loadEcard(id, cryptid);
		} else {
			// ecard verfassen
			toolbar_mc.setMode(ToolbarUI.MODE_COMPOSE);
			// stage resetten
			stage_mc.resetItems();
			// background resetten
			background_mc.setBackground(1);
			// stage editierbar
			stage_mc.setEditable(true);
		}
	}
	
	public function loadEcard(id:Number, cryptid:String ):Void
	{
		// laden lassen
		EcardConnector.getEcard(id, cryptid, this, "onEcardLoaded");
	}
	
	public function onEcardLoaded(re:ResultEvent ):Void
	{
		// abbrechen, wenn keine gueltige ecard geladen
		if (re.result["layout"] == "") {
			// neue ecard
			initEcard(null, null);
			// abbrechen
			return;	
		}
		
		// sender
		var sender:User = User(RemotingBeanCaster.getCastedInstance(new User(), re.result["sender"]));
		// receiver
		var receiver:User = User(RemotingBeanCaster.getCastedInstance(new User(), re.result["receiver"]));
		// layout
		var layout:Layout = new Layout();
		// einlesen
		layout.parseFromXml(new XML(String(re.result["layout"])));
		
		// user anzeigen
		toolbar_mc.getReceive().showUsers(sender, receiver);
		// items anzeigen
		stage_mc.showItems(layout.getItems());
		// background anzeigen
		background_mc.setBackground(layout.getBackground());
	}
	
	public function sendEcard(sender:User, receiver:User, message:String ):Void
	{
		// stage nicht editierbar
		stage_mc.setEditable(false);
		// neue ecard
		var ecard:Ecard = new Ecard();
		// sender
		ecard.setSender(sender);
		// receiver
		ecard.setReceiver(receiver);
		// message
		ecard.setMessage(message);
		// neues layout
		var layout:Layout = new Layout();
		// background
		layout.setBackground(getBackground().getBackground());
		// items
		layout.setItems(getStage().getItemsAsBeans());
		// layout
		ecard.setLayout(layout.getAsXml());
		// senden lassen
		EcardConnector.saveEcard(ecard, this, "onEcardSent");
	}
	
	public function onEcardSent(re:ResultEvent ):Void
	{
		// toolbar umschalten
		toolbar_mc.setMode(ToolbarUI.MODE_SENT);
		// dritter trackpoint
		_root.getReportingProcessor().setTrackpoint(3, "sent");
	}
	
	public function getToolbar():ToolbarUI {
		return toolbar_mc;
	}

	public function getStage():StageUI {
		return stage_mc;
	}

	public function getBackground():BackgroundUI {
		return background_mc;
	}

}