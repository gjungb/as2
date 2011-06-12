/**
 * @author gerd
 */
class com.adgamewonderland.digitalbanal.elfmeterduell.beans.Preference {
	
	private var preferenceID:Number;
	
	private var optin:Boolean;
	
	private var newsletter:Boolean;
	
	private var language:String;
	
	public function Preference() {
		this.preferenceID = null;
		this.optin = false;
		this.newsletter = false;
		this.language = "";
		
//		Object.registerClass("Preference", com.adgamewonderland.digitalbanal.elfmeterduell.beans.Preference);
	}
	
	public function getNewsletter():Boolean {
		return newsletter;
	}

	public function setNewsletter(newsletter:Boolean):Void {
		this.newsletter = newsletter;
	}

	public function getLanguage():String {
		return language;
	}

	public function setLanguage(language:String):Void {
		this.language = language;
	}

	public function getPreferenceID():Number {
		return preferenceID;
	}

	public function setPreferenceID(preferenceID:Number):Void {
		this.preferenceID = preferenceID;
	}

	public function getOptin():Boolean {
		return optin;
	}

	public function setOptin(optin:Boolean):Void {
		this.optin = optin;
	}

}