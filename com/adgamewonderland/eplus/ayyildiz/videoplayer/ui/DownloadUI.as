/**
 * @author gerd
 */
 
import mx.utils.Delegate;

import com.adgamewonderland.agw.util.CheckboxUI;

import com.adgamewonderland.agw.Formprocessor;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.DownloadUI extends MovieClip {
	
	private static var URL:String = "VideoDownload"; // http://plasticbox:8080/ayyildiz_development/videoplayer/
	
	private static var ERROR0:String = "Lütfen doldurunuz";

	private static var ERROR1:String = "Bitte ausfüllen";
	
	private var moviename_txt:TextField;
	
	private var firstname_txt:TextField;
	
	private var lastname_txt:TextField;
	
	private var email_txt:TextField;
	
	private var optin_mc:CheckboxUI;
	
	private var close_btn:Button;
	
	private var download_btn:Button;
	
	private var i18n_mc:MovieClip;
	
	private var errormcs:Array;
	
	private var error_firstname_txt:TextField;
	
	private var error_lastname_txt:TextField;
	
	private var error_email_txt:TextField;
	
	public function DownloadUI() {
		// registrieren
		VideoPlayer.getInstance().addListener(this);
	}
	
	public function onLoad():Void
	{
		// close
		close_btn.onPress = Delegate.create(this, onPressClose);
		// download
		download_btn.onPress = Delegate.create(this, onPressDownload);
		// name des aktuellen videos
		moviename_txt.autoSize = "left";
		// tabsetter
		var index:Number = 0;
		firstname_txt.tabIndex = ++index;
		lastname_txt.tabIndex = ++index;
		email_txt.tabIndex = ++index;
		// i18n
		i18n_mc.gotoAndStop(VideoPlayer.getInstance().getLanguage() + 1);
		// checkbox aktiv
		optin_mc.status = true;
		// fehlertexte
		error_firstname_txt.autoSize = "left";
		error_lastname_txt.autoSize = "left";
		error_email_txt.autoSize = "left";
	}
	
	public function onDownloadVideo():Void
	{
		// einblenden
		_parent.gotoAndPlay("frIn");
		// name des aktuellen videos
		moviename_txt.text = VideoPlayer.getInstance().getItem().getDescriptionByLanguage(VideoPlayer.getInstance().getLanguage());
	}
	
	public function onPressClose():Void
	{
		// ausblenden
		_parent.gotoAndStop(1);
		// callback
		VideoPlayer.getInstance().onCloseDownload();
	}
	
	public function onPressDownload():Void
	{
		// fehler ausblenden
		showErrors([]);
		// eingaben parsen
		// firstname
		var firstname:String = firstname_txt.text;
		// lastname
		var lastname:String = lastname_txt.text;
		// email
		var email:String = email_txt.text.toLowerCase();
		// optin
		var optin:Boolean = optin_mc.status;
		
		// eingaben validieren
		// formprocessor zum validieren
		var fp:Formprocessor = new Formprocessor();
		// zu validierende angaben
		var validation:Array = [Formprocessor.TYPE_EMPTY, "firstname", firstname, Formprocessor.TYPE_EMPTY, "lastname", lastname, Formprocessor.TYPE_EMAIL, "email", email];
		// validieren
		var errors:Array = fp.checkForm(validation);
		// testen, ob fehler gefunden
		if (errors.length != 0) {
			// fehler anzeigen
			showErrors(errors);
			// abbrechen
			return;
		}
		
		// sender
		var sender:LoadVars = new LoadVars();
		// moviename
		sender.moviename = VideoPlayer.getInstance().getItem().getMovie();
		// firstname
		sender.firstname = firstname;
		// lastname
		sender.lastname = lastname;
		// email
		sender.email = email;
		// optin
		sender.optin = optin;
		// absenden
		sender.send(URL, "_blank");
		
		// schliessen
		onPressClose();
	}
	
	private function showErrors(errors:Array ):Void
	{
		// fehler loeschen
		if (errors.length == 0) {
			// schleife ueber fehlerboxen
			for (var j : String in errormcs) {
				// aktueller fehlerpfeil
				errormcs[j].removeMovieClip();
			}
			// array leeren
			this.errormcs.splice(0);
			// textfelder leeren
			error_firstname_txt.text = "";
			error_lastname_txt.text = "";
			error_email_txt.text = "";
		
		// fehler anzeigen	
		} else {
			// schleife ueber fehler
			for (var i:String in errors) {
				// fehler (name der variable)
				var error:String = errors[i];
				// textfeld oder movieclip
				var target:Object;
				if (this[error + "_txt"] instanceof TextField) {
					target = this[error + "_txt"];
				} else if (this[error + "_mc"] instanceof MovieClip) {
					target = this[error + "_mc"];
				}
				// testen, ob gefunden
				if (target == undefined) continue;
				// mitte
				var xpos:Number = target._x + target._width / 2;
				var ypos:Number = target._y + target._height / 2;
				// groesse
				var width:Number = target._width;
				var height:Number = target._height;
				// constructor
				var constructor:Object = {_x : xpos, _y : ypos, _width : width, _height : height};
				// neue fehlerbox
				var mc:MovieClip = this.attachMovie("ErrorUI", "error" + error + "_mc", getNextHighestDepth(), constructor);
				// speichern
				this.errormcs.push(mc);
				
				// textfeld
				var error_txt:TextField = this["error_" + error + "_txt"];
				// fehler anzeigen
				error_txt.text = (VideoPlayer.getInstance().getLanguage() == 0 ? ERROR0 : ERROR1);
			}
		}
	}
	
}