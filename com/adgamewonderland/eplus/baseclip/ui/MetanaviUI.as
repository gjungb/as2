import mx.utils.Delegate;
import com.adgamewonderland.eplus.baseclip.ui.NavigationUI;
import com.adgamewonderland.eplus.baseclip.ui.SoundCollectionUI;
import com.adgamewonderland.eplus.baseclip.descriptors.ContentDescriptor;
import com.adgamewonderland.eplus.baseclip.descriptors.NavigationDescriptor;
import com.adgamewonderland.eplus.baseclip.ui.ContentUI;
/**
 * @author gerd
 */
class com.adgamewonderland.eplus.baseclip.ui.MetanaviUI extends MovieClip {

	private var contact_btn:Button;

	private var participation_btn:Button;

	private var imprint_btn:Button;

	private var protection_btn:Button;

	private var sitemap_btn:Button;

	private var sound_btn:Button;

	public function MetanaviUI() {

	}

	private function onLoad():Void
	{
		// buttons initialisieren
		contact_btn.onRelease = Delegate.create(this, doContact);
		participation_btn.onRelease = Delegate.create(this, doParticipation);
		imprint_btn.onRelease = Delegate.create(this, doImprint);
		protection_btn.onRelease = Delegate.create(this, doProtection);
		sitemap_btn.onRelease = Delegate.create(this, doSitemap);
		sound_btn.onRelease = Delegate.create(this, doSound);
	}

	private function doContact():Void {
		// TODO: kontaktformular
		var desc:ContentDescriptor = NavigationDescriptor.getInstance().getContentDescriptor(["konta"]);
		// anzeigen
		ContentUI.getMovieClip().showContent(desc);
	}

	private function doParticipation():Void {
		// teilnahmebedingungen
		getURL("javascript:puTeilnahmebedingungen();");
	}

	private function doImprint():Void {
		// impressum oeffnen
		getURL("http://www.base.de/503_impressum.jsp", "_blank");
	}

	private function doProtection():Void {
		// verbraucher und jugendschutz
		getURL("javascript:puVerbraucherschutz('http://www.base.de/');");
	}

	private function doSitemap():Void {
		// sitemap
		NavigationUI.getMovieClip().showSitemap();
	}

	private function doSound():Void {
		// sound
		SoundCollectionUI.getMovieClip().togglePlaying();
	}

}