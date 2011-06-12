import mx.remoting.RecordSet;
import mx.utils.Collection;

import com.adgamewonderland.eplus.vybe.videoplayer.beans.Minitvlist;
import mx.utils.CollectionImpl;
import mx.utils.Iterator;

class com.adgamewonderland.eplus.vybe.videoplayer.beans.Videoassets
{
	private var minitvlists:Collection;

	private var categories:Object;

	private var assetset:RecordSet;

	public function Videoassets()
	{
		// minitivlists
		this.minitvlists = new CollectionImpl();
		// categories
		this.categories = new Object();
		// assetset
		this.assetset = new RecordSet(["minitvlist", "id", "recordpartner", "created", "modified", "title", "artistname", "clipfileurl", "thumbnailurl"]);
	}

	public function getMinitvlists():Collection
	{
		return this.minitvlists;
	}

	public function getAssetset():RecordSet
	{
		return this.assetset;
	}

	public function toString() : String {
		var ret:String = "Videoassets" + String.fromCharCode(13);
		var it:Iterator = getMinitvlists().getIterator();
		while (it.hasNext()) {
			ret += it.next() + String.fromCharCode(13);
		}
		return ret;
	}
}
