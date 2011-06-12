/**
 * @author gerd
 */

import com.adgamewonderland.dhl.adventsgewinnspiel.beans.*; 

class com.adgamewonderland.dhl.adventsgewinnspiel.beans.Tellafriend {
	
	private var sender:User;
	
	private var receiver:User;
	
	private var message:String;
	
	public function Tellafriend() {
		sender = new User();
		receiver = new User();
		message = "";
	}
	
	public function getReceiver():User {
		return receiver;
	}

	public function setReceiver(receiver:User):Void {
		this.receiver = receiver;
	}

	public function getMessage():String {
		return message;
	}

	public function setMessage(message:String):Void {
		this.message = message;
	}

	public function getSender():User {
		return sender;
	}

	public function setSender(sender:User):Void {
		this.sender = sender;
	}

}