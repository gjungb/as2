import com.adgamewonderland.eplus.basecasting.beans.Clip;

class com.adgamewonderland.eplus.basecasting.beans.VotableClip extends Clip
{
	private var totalscore:Number = 0;

	private var stars:Number = 0;

	public function VotableClip() {

	}

	public function setTotalscore(aTotalscore:Number ):Void
	{
		this.totalscore = aTotalscore;
	}

	public function getTotalscore():Number
	{
		return this.totalscore;
	}

	public function setStars(aStars:Number ):Void
	{
		this.stars = aStars;
	}

	public function getStars():Number
	{
		return this.stars;
	}

	public function toString() : String {
		return "VotableClip: " + getTotalscore() + " # " + super.toString();
	}
}
