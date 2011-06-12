/*
klasse:			UserAddress
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.06.2005
zuletzt bearbeitet:	25.06.2005
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.blaupunkt.dtmracing.challenge.UserAddress {

	// Attributes
	
	private var aid:Number;
    
    private var firstname:String;
    
    private var lastname:String;
    
    private var street:String;
    
    private var postcode:String;
    
    private var city:String;
    
    private var country:String;
    
    private var phone:String;
    
    private var birthday:Date;

    private var optin:Number;
	
	// Operations
	
	public function UserAddress(aid:Number, firstname:String, lastname:String, street:String, postcode:String, city:String, country:String, phone:String, birthday:Date, optin:Number )
	{
		// aid
		this.aid = aid;
		// firstname
		this.firstname = firstname;
		// lastname
		this.lastname = lastname;
		// street
		this.street = street;
		// postcode
		this.postcode = postcode;
		// city
		this.city = city;
		// country
		this.country = country;
		// phone
		this.phone = phone;
		// birthday
		this.birthday = birthday;
		// optin
		this.optin = optin;
	}

    public function getAid():Number 
    {
        return aid;
    }

    public function setAid(num:Number) 
    {
        aid = num;
    }

    public function getFirstname():String 
    {
        return firstname;
    }

    public function setFirstname(str:String ):Void 
    {
        firstname = str;
    }

    public function getLastname():String 
    {
        return lastname;
    }

    public function setLastname(str:String ):Void 
    {
        lastname = str;
    }

    public function getStreet():String 
    {
        return street;
    }

    public function setStreet(str:String ):Void 
    {
        street = str;
    }

    public function getPostcode():String 
    {
        return postcode;
    }

    public function setPostcode(str:String ):Void 
    {
        postcode = str;
    }

    public function getCity():String 
    {
        return city;
    }

    public function setCity(str:String ):Void 
    {
        city = str;
    }

    public function getCountry():String 
    {
        return country;
    }

    public function setCountry(str:String ):Void 
    {
        country = str;
    }

    public function getPhone():String 
    {
        return phone;
    }

    public function setPhone(str:String ):Void 
    {
        phone = str;
    }

    public function getBirthday():Date 
    {
        return birthday;
    }

    public function setBirthday(obj:Date ):Void 
    {
        birthday = obj;
    }

    public function getOptin():Number 
    {
        return optin;
    }

    public function setOptin(num:Number) 
    {
        optin = num;
    }

} /* end class UserAddress */
