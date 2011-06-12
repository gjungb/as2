class com.adgamewonderland.eplus.basecasting.view.beans.User
{
	private var firstname:String;
	private var lastname:String;
	private var email:String;

	public function User() {

	}

	public function setFirstname(aFirstname:String):Void
	{
		this.firstname = aFirstname;
	}

	public function getFirstname():String
	{
		return this.firstname;
	}

	public function setLastname(aLastname:String):Void
	{
		this.lastname = aLastname;
	}

	public function getLastname():String
	{
		return this.lastname;
	}

	public function setEmail(aEmail:String):Void
	{
		this.email = aEmail;
	}

	public function getEmail():String
	{
		return this.email;
	}
}
