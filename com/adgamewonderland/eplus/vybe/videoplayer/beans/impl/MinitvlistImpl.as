import mx.xpath.XPathAPI;

import com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl;
import com.adgamewonderland.eplus.vybe.videoplayer.beans.Minitvlist;

class com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.MinitvlistImpl extends Minitvlist
{

	public function parseXML(aNode:XMLNode ):Void
	{
		// id
		this.id = Number(aNode.attributes["id"]);
		// name
		this.name = aNode.attributes["name"];
		// string "vybemobile" rausparsen
		if (this.name.indexOf("vybemobile") >= 0)
			this.name = this.name.substring(this.name.indexOf(" "), this.name.length);
		// alle knoten asset
		var assetNodes:Array = XPathAPI.selectNodeList(aNode, "/minitvlist/asset");
		// neues asset
		var asset:AssetImpl;
		// schleife ueber alle knoten
		for (var i : Number = 0; i < assetNodes.length; i++) {
			// neue asset
			asset = new AssetImpl();
			// einzeln parsen
			asset.parseXML(assetNodes[i]);
			// referenz auf minitvlist setzen
			asset.setMinitvlist(this);
			// zur liste der assets hinzufuegen
			this.assets.addItem(asset);
		}
	}

	public function getAssetsCount():Number
	{
		return getAssets().getLength();
	}
}
