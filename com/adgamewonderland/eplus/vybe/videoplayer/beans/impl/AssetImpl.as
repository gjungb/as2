import mx.xpath.XPathAPI;

import com.adgamewonderland.eplus.vybe.videoplayer.beans.Asset;

class com.adgamewonderland.eplus.vybe.videoplayer.beans.impl.AssetImpl extends Asset
{

	public function parseXML(aNode:XMLNode ):Void
	{
		// id
		this.id = Number(aNode.attributes["id"]);
		// recordpartner
		this.recordpartner = Number(aNode.attributes["recordpartner"]);
		// created
		var date:Array = String(aNode.attributes["created"]).split("-");
		this.created = new Date(Number(date[0]), Number(date[1]) - 1, Number(date[2]));
		// modified
		var date:Array = String(aNode.attributes["modified"]).split("-");
		this.modified = new Date(Number(date[0]), Number(date[1]) - 1, Number(date[2]));
		// title node
		var titleNode:XMLNode = XPathAPI.selectSingleNode(aNode, "/asset/title");
		// title
		this.title = titleNode.firstChild.toString();
		// artistname node
		var artistnameNode:XMLNode = XPathAPI.selectSingleNode(aNode, "/asset/artist/name");
		// artist name
		getArtist().setName(artistnameNode.firstChild.toString());
		// clipfileapplication node
		var clipfileapplicationNode:XMLNode = XPathAPI.selectSingleNode(aNode, "/asset/application");
		// clipfile application
		getClipfile().setApplication(clipfileapplicationNode.firstChild.toString());
		// clipfilefile node
		var clipfilefileNode:XMLNode = XPathAPI.selectSingleNode(aNode, "/asset/file");
		// clipfile application
		getClipfile().setFile(clipfilefileNode.firstChild.toString());
		// clipfile url
		getClipfile().setUrl(getClipfileAplication() + "/" + getClipfileFile());
		// thumbnailurl node
		var thumbnailurlNode:XMLNode = XPathAPI.selectSingleNode(aNode, "/asset/thumbnail");
		// thumbnail url
		getThumbnail().setUrl(thumbnailurlNode.firstChild.toString());
	}

	public function toRecordSetItem():Object
	{
		// asset als object fuer recordset
		var item:Object = new Object();
		// alle attribute durchgehen
		item["minitvlist"] = getMinitvlist().getName();
		item["id"] = getId();
		item["recordpartner"] = getRecordpartner();
		item["created"] = getCreated();
		item["modified"] = getModified();
		item["title"] = getTitle();
		item["artistname"] = getArtistName();
		item["clipfileurl"] = getClipfileUrl();
		item["thumbnailurl"] = getThumbnailUrl();
		// zurueck geben
		return item;
	}

	public function equals(aAsset:AssetImpl ):Boolean
	{
		// ist das uebergebene asset mit diesem identisch
		var equal:Boolean = false;
		// identisch, wenn urls der videos idetisch
		equal = getClipfileUrl() == aAsset.getClipfileUrl();
		// zurueck geben
		return equal;
	}

	public static function parseRecordSetItem(aItem:Object):Asset
	{
		// TODO: recordset item in asset umwandeln
		return null;
	}

	public function getArtistName():String
	{
		// artist name
		return getArtist().getName();
	}

	public function getClipfileUrl():String
	{
		// clipfile url
		return getClipfile().getUrl();
	}

	public function getClipfileAplication():String
	{
		// clipfile application
		return getClipfile().getApplication();
	}

	public function getClipfileFile():String
	{
		// clipfile file
		return getClipfile().getFile();
	}

	public function getThumbnailUrl():String
	{
		// thumbnail url
		return getThumbnail().getUrl();
	}

	public function toString() : String {
		return "AssetImpl: " + getId() + ", " + getTitle() + ", " + getArtistName() + ", " + getClipfileUrl() + ", " + getThumbnailUrl();
	}
}
