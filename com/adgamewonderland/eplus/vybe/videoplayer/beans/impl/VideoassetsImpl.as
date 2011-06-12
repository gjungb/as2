import com.adgamewonderland.eplus.vybe.videoplayer.beans.Minitvlist;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.Videoassets;
import mx.utils.Collection;
import mx.xpath.XPathAPI;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl;
import mx.utils.Iterator;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;

class com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.VideoassetsImpl extends Videoassets
{

	public function parseXML(aNode:XMLNode):Void
	{
		// alle knoten minitvlist
		var minitvlistNodes:Array = XPathAPI.selectNodeList(aNode, "/videoassets/minitvlist");
		// neue minitvlist
		var minitvlist:MinitvlistImpl;
		// schleife ueber alle knoten
		for (var i : Number = 0; i < minitvlistNodes.length; i++) {
			// neue minitvlist
			minitvlist = new MinitvlistImpl();
			// einzeln parsen
			minitvlist.parseXML(minitvlistNodes[i]);
			// zur liste der minitvlists hinzufuegen
			this.minitvlists.addItem(minitvlist);
			// category aus minitvlist speichern
			this.categories[minitvlist.getName()] = i;
		}
		// TODO: assets in recordset speichern
		var it1:Iterator = getMinitvlists().getIterator();

		while (it1.hasNext()) {
			minitvlist = MinitvlistImpl(it1.next());
			var it2:Iterator = minitvlist.getAssets().getIterator();
			while (it2.hasNext()) {
				var asset:AssetImpl = AssetImpl(it2.next());
				this.assetset.addItem(asset.toRecordSetItem());
			}
		}
	}

	public function getCategoryNames():Array
	{
		// bezeichnungen der categories
		var names:Array = new Array();
		// schleife ueber categories
		for (var i : String in this.categories) {
			// bezeichnung hinzu fuegen
			names.push(i);
		}
		// umdrehen
		names.reverse();
		// zurueck geben
		return names;
	}

	public function getMinitvlistByCategory(category:String ):MinitvlistImpl
	{
		// index der category
		var index:Number = this.categories[category];
		// minitvlist aus collection
		var minitvlist:MinitvlistImpl = MinitvlistImpl(getMinitvlists().getItemAt(index));
		// zurueck geben
		return minitvlist;
	}

	public function getAssetsByCritera(aCriteria:Object):Collection
	{
		// Not yet implemented
		return null;
	}
}
