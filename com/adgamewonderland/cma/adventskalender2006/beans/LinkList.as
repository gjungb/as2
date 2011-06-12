import com.adgamewonderland.cma.adventskalender2006.beans.*;

/**
 * Liste mit Links zu weiterführenden Informationen
 */
class com.adgamewonderland.cma.adventskalender2006.beans.LinkList 
{
	private var links:Array;

	public function LinkList()
	{
		// array mit links
		this.links = new Array();
		// kalender
		var cal:Adventcalendar = Adventcalendar.getInstance();
		// je tag ein link
		addLinks(new Link(cal.getDayById(1), "http://www.cma.de/content/gefluegel-naehrwert-von-gefluegel.php"));
		addLinks(new Link(cal.getDayById(2), "http://www.cma.de/content/gefluegel/gefluegel-handelsklassen.php"));
		addLinks(new Link(cal.getDayById(3), "http://www.cma.de/content/gefluegel/gefluegel-gefluegeleinkauf-leicht-gemacht.php"));
		addLinks(new Link(cal.getDayById(4), "http://www.cma.de/content/gefluegel-zubereitung.php"));
		addLinks(new Link(cal.getDayById(5), "http://www.cma.de/content/gefluegel/gefluegel-gaumenschmaus.php"));
		addLinks(new Link(cal.getDayById(6), "http://www.cma.de/content/gefluegel/gefluegel-zubereitung.php"));
		addLinks(new Link(cal.getDayById(7), "http://www.cma.de/content/gefluegel/gefluegel-naehrwert-von-gefluegel.php"));
		addLinks(new Link(cal.getDayById(8), "http://www.cma.de/content/gefluegel/gefluegel-einkaufen-kennzeichnungen.php"));
		addLinks(new Link(cal.getDayById(9), "http://www.cma.de/content/gefluegel/gefluegel-haltungsformen.php"));
		addLinks(new Link(cal.getDayById(10), "http://www.cma.de/content/gefluegel/gefluegel-einkaufen-verkehrsbezeichnungen.php"));
		addLinks(new Link(cal.getDayById(11), "http://www.cma.de/content/gefluegel/gefluegel-handelsklassen.php"));
		addLinks(new Link(cal.getDayById(12), "http://www.cma.de/content/gefluegel/gefluegel-einkaufen-kennzeichnungen.php"));
		addLinks(new Link(cal.getDayById(13), "http://www.cma.de/content/gefluegel-aufbewahrung.php"));
		addLinks(new Link(cal.getDayById(14), "http://www.cma.de/content/gefluegel-zubereitung.php"));
		addLinks(new Link(cal.getDayById(15), "http://www.cma.de/content/gefluegel-naehrwert-von-gefluegel.php"));
		addLinks(new Link(cal.getDayById(16), "http://www.cma.de/content/gefluegel/kulinarische-feste-ente-gans.php"));
		addLinks(new Link(cal.getDayById(17), "http://www.cma.de/content/gefluegel/gefluegel-haltungsformen.php"));
		addLinks(new Link(cal.getDayById(18), "http://www.cma.de/content/gefluegel/kulinarische-feste-ente-gans.php"));
		addLinks(new Link(cal.getDayById(19), "http://www.cma.de/content/gefluegel/gefluegel-FAQ.php"));
		addLinks(new Link(cal.getDayById(20), "http://www.cma.de/content/gefluegel-zubereitung.php"));
		addLinks(new Link(cal.getDayById(21), "http://www.cma.de/content/gefluegel/gefluegel-naehrwert-von-gefluegel.php"));
		addLinks(new Link(cal.getDayById(22), "http://www.cma.de/content/gefluegel/kulinarische-feste-ente-gans.php"));
		addLinks(new Link(cal.getDayById(23), "http://www.cma.de/content/gefluegel/kulinarische-feste-ente-gans.php"));
		addLinks(new Link(cal.getDayById(24), "http://www.cma.de/content/gefluegel/gefluegel-haltungsformen.php"));
	}

	/**
	 * ermittelt den Link eines Tages und gibt ihn zurück
	 * @param day Tag, zu dem der Link zurück gebegeben werden soll
	 * @return Link eines Tages	 */
	public function getLinkByDay(day:com.adgamewonderland.cma.adventskalender2006.beans.Day):com.adgamewonderland.cma.adventskalender2006.beans.Link
	{
		// index in array mit links
		var index:Number = day.getId() - 1;
		// entsprechener link
		var link:Link = this.links[index];
		// zurueck geben
		return link;
	}

	public function addLinks(links:com.adgamewonderland.cma.adventskalender2006.beans.Link):Void
	{
		this.links.push(links);
	}

	public function removeLinks(links:com.adgamewonderland.cma.adventskalender2006.beans.Link):Void
	{
		for (var i:Number = 0; i < this.links.length; i++)
		{
			if (this.links[i] == links)
			{
				this.links.splice(i, 1);
			}
		}
	}

	public function toLinksArray():Array
	{
		return this.links;
	}
}