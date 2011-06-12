import com.adgamewonderland.cma.adventskalender2006.beans.*;
import mx.utils.Delegate;

/**
 * Darstellung eines Links zu weiterführenden Informationen auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.LinkUI extends MovieClip
{
	private var link:com.adgamewonderland.cma.adventskalender2006.beans.Link;
	private var link_btn:Button;

	public function LinkUI()
	{
	}

	/**
	 * Link aufrufen
	 */
	public function showLink():Void
	{
		// link zum thema setzen
		setLink(Adventcalendar.getInstance().getLinklist().getLinkByDay(_parent.getQuiz().getDay()));
		// link zu thema aufrufen
		getURL(getLink().getUrl(), "_blank");
	}

	public function onLoad():Void
	{
		// button aktivieren
		link_btn.onRelease = Delegate.create(this, showLink);
	}

	public function setLink(link:com.adgamewonderland.cma.adventskalender2006.beans.Link):Void
	{
		this.link = link;
	}

	public function getLink():com.adgamewonderland.cma.adventskalender2006.beans.Link
	{
		return this.link;
	}
}