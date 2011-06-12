
class com.adgamewonderland.gerd.HelloBean {

	var name : String;
	
	var geburtstag : Date;
	
	public function HelloBean() {
	}

	/**
	 * @return the name
	 */
	function getName() : String {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	function setName(name : String) : Void {
		this.name = name;
	}

	/**
	 * @return the geburtstag
	 */
	function getGeburtstag() : Date {
		return geburtstag;
	}

	/**
	 * @param geburtstag the geburtstag to set
	 */
	function setGeburtstag(geburtstag : Date) : Void {
		this.geburtstag = geburtstag;
	}
	
	public function toString() : String {
		return "com.adgamewonderland.gerd.HelloBean: " + getName() + ", " + getGeburtstag();
	}
	
}