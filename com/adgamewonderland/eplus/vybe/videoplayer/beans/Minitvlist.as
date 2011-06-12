import mx.utils.Collection;
import mx.utils.CollectionImpl;
import mx.utils.Iterator;
class com.adgamewonderland.eplus.vybe.videoplayer.beans.Minitvlist
{
	private var id:Number;

	private var name:String;

	private var assets:Collection;

	public function Minitvlist()
	{
		// id
		this.id = 0;
		// name
		this.name = "";
		// assets
		this.assets = new CollectionImpl();
	}

	public function setId(aId:Number):Void
	{
		this.id = aId;
	}

	public function getId():Number
	{
		return this.id;
	}

	public function setName(aName:String):Void
	{
		this.name = aName;
	}

	public function getName():String
	{
		return this.name;
	}

	public function getAssets():Collection
	{
		return this.assets;
	}

	public function toString() : String {
		var ret:String = "Minitvlist" + String.fromCharCode(13);
		var it:Iterator = getAssets().getIterator();
		while (it.hasNext()) {
			ret += it.next() + String.fromCharCode(13);
		}
		return ret;
	}
}
