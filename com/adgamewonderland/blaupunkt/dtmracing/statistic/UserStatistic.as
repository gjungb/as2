/* 
 * Generated by ASDT 
*/ 

/*
klasse:			UserStatistic
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		15.06.2005
zuletzt bearbeitet:	15.06.2005
durch			gj
status:			in bearbeitung
*/

class com.adgamewonderland.blaupunkt.dtmracing.statistic.UserStatistic {
	
    private var numraces:Number;

    private var numwins:Number;

    private var numlosses:Number;

    private var ratewins:Number;

    private var scoreallstars:Number;
    
    private var nickname:String;
    
    private var trackstats:Array;
    
    public function UserStatistic(numraces:Number, numwins:Number, numlosses:Number, ratewins:Number, scoreallstars:Number, nickname:String, trackstats:Array )
    {
		// vererbung
		super.constructor.apply(super, arguments);
    	// numraces
        this.numraces = numraces;
        // numwins
        this.numwins = numwins;
        // numlosses
        this.numlosses = numlosses;
        // ratewins
        this.ratewins = ratewins;
        // scoreallstars
        this.scoreallstars = scoreallstars;
        // trackstats
        this.trackstats = trackstats;
		// registrieren fuer remoting
		Object.registerClass("UserStatistic", UserStatistic);
    }
    
    public function getNumraces():Number
    {
        return numraces;
    }

    public function setNumraces(num:Number )
    {
        numraces = num;
    }

    public function getNumwins():Number
    {
        return numwins;
    }

    public function setNumwins(num:Number )
    {
        numwins = num;
    }

    public function getNumlosses():Number
    {
        return numlosses;
    }

    public function setNumlosses(num:Number )
    {
        numlosses = num;
    }

    public function getRatewins():Number
    {
        return ratewins;
    }

    public function setRatewins(num:Number )
    {
        ratewins = Math.round(num);
    }

    public function getScoreallstars():Number
    {
        return scoreallstars;
    }

    public function setScoreallstars(num:Number )
    {
        scoreallstars = num;
    }

    public function getNickname():String
    {
        return nickname;
    }
    
    public function setNickname(str:String )
    {
        nickname = str;
    }
    
    public function getTrackstats():Array
    {
        return trackstats;
    }
    
    public function setTrackstats(arr:Array )
    {
        trackstats = arr;
    }
}