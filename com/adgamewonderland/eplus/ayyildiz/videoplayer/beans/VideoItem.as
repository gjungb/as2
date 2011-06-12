/**
 * @author gerd
 */
class com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.VideoItem {
	
	private var id:Number;
	
	private var date:Date;
	
	private var file:String;
	
	private var thumb:String;
	
	private var movie:String;
	
	private var descriptions:Array;
	
	private var duration:Number;
	
	public function VideoItem() {
		this.id = 0;
		this.date = new Date();
		this.file = "";
		this.thumb = "";
		this.movie = "";
		this.descriptions = new Array();
		this.duration = 0;
	}
	
	public function parseDescriptions(descriptionsXML:Array ):Void
	{
		// aktuelle description
		var descriptionXML:XMLNode;
		// sprache
		var language:Number;
		// description
		var description:String;
		// schleife ueber descriptions
		for (var i:Number = 0; i < descriptionsXML.length; i++) {
			// aktuelle description
			descriptionXML = descriptionsXML[i];
			// sprache
			language = descriptionXML.attributes["language"];
			// description
			description = descriptionXML.firstChild.nodeValue;
			// speichern
			if (description != undefined) {
				this.descriptions[language] = description;	
			} else {
				this.descriptions[language] = "";
			}
		}
	}
	
	public function getDescriptionByLanguage(language:Number ):String
	{
		// zurueck geben
		if (this.descriptions[language] != undefined) {
			return(this.descriptions[language]);	
		} else {
			return("");	
		}
	}
	
	public function getDate():Date {
		return date;
	}

	public function setDate(date:Date):Void {
		this.date = date;
	}

	public function getId():Number {
		return id;
	}

	public function setId(id:Number):Void {
		this.id = id;
	}

	public function getDescriptions():Array {
		return descriptions;
	}

	public function setDescriptions(descriptions:Array):Void {
		this.descriptions = descriptions;
	}

	public function getFile():String {
		return file;
	}

	public function setFile(file:String):Void {
		this.file = file;
	}

	public function getThumb():String {
		return thumb;
	}

	public function setThumb(thumb:String):Void {
		this.thumb = thumb;
	}
	
	public function toString():String {
		return "VideoItem: id=" + getId() + ", date=" + getDate().toString() + ", file=" + getFile() + ", thumb=" + getThumb();
	}

	public function getDuration():Number {
		return duration;
	}

	public function setDuration(duration:Number):Void {
		this.duration = duration;
	}

	public function getMovie():String {
		return movie;
	}

	public function setMovie(movie:String):Void {
		this.movie = movie;
	}

}