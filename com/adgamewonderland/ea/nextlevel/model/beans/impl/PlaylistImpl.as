import com.adgamewonderland.ea.nextlevel.model.beans.impl.MetainfoImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistChapterItemImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistVideoItemImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.RepositoryImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.Playlist;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl extends Playlist {

	public function PlaylistImpl() {
		super();
		// dummy id
		this.setID(1);
		// leere metainfo
		var mei:MetainfoImpl = new MetainfoImpl();
		mei.setID(1);
		mei.setCreationdate	(new Date());
		mei.setLastmodified	(new Date());
		this.setMetainfo(mei);
		// warteloop
		var lV:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
		lV.setLoops(PlaylistVideoItem.LOOPS_INFINITE);
		lV.setFullScreen (true);
		lV.getVideo().setID(1);
		lV.getVideo().setFilename("Repository\\Filme\\waiting.flv");
		this.setWarteLoop(lV);
		// uebergang
		var uV:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
		uV.setLoops(0);
		uV.setFullScreen (true);
		uV.getVideo().setID(1);
		uV.getVideo().setFilename("Repository\\Filme\\transition.flv");
		this.setUebergang(uV);
	}

	/**
	 * Es wird aus dem Repository eine komplette Playlist
	 * erstellt.
	 */
	public function convertRepository2Playlist (repos:RepositoryImpl) : XMLNode {
		var node:XMLNode = new XMLNode(1,"PLAYLIST");

		var nodeChild:XMLNode 	= new XMLNode(1,"PLAYLISTID");
		nodeChild.appendChild(
			new XMLNode(3,"2"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
		nodeChild.appendChild(
			new XMLNode(3,repos.getMetainfo.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INFOTEXT");
		nodeChild.appendChild(
			new XMLNode(3,repos.getInfoText()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADWALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,repos.getPfadWallpaper()));
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"WALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,repos.getWallpaper()));
		node.appendChild(nodeChild);

		// metainfo
		repos.getMetainfo().setLastmodified(new Date());
		var meta:Metainfo = repos.getMetainfo();
		var nodeChild:XMLNode 	= MetainfoImpl(meta).SerializeXML();
		node.appendChild(nodeChild);
		// warteloop
		var warteloop:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, PlaylistVideoItem.LOOPS_INFINITE, "", true, repos.getWarteLoop());
		var nodeChild:XMLNode 	= warteloop.SerializeXML("WARTECLIPLOOP");
		node.appendChild(nodeChild);
		// trailer
		var trailer:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, 0, "", true, repos.getTrailer());
		var nodeChild:XMLNode 	= trailer.SerializeXML("TRAILERCLIP");
		node.appendChild(nodeChild);
		// trailerloop
		var trailerloop:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, PlaylistVideoItem.LOOPS_INFINITE, "", true, repos.getTrailerLoop());
		var nodeChild:XMLNode 	= trailerloop.SerializeXML("TRAILERCLIPLOOP");
		node.appendChild(nodeChild);
		// uebergang
		var uebergang:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, 0, "", true, repos.getUebergang());
		var nodeChild:XMLNode 	= uebergang.SerializeXML("UEBERGANGCLIP");
		node.appendChild(nodeChild);

		// Chapters (aber als PlaylistChapterItem)
		var chTemp:Array = repos.toChaptersArray();
		for (var i:Number = 0;i < chTemp.length;i++) {
			var chTempItem:ChapterImpl = chTemp[i];

			var nodeChild:XMLNode 	= chTempItem.SerializeXML4Playlist("PLAYLISTITEMCHAPTER");
			node.appendChild(nodeChild);
		}
		return node;
	}

	/**
	 * fuegt ein item an der uebergebenen position zur playlist hinzu
	 * @param item hinzuzufuegendes item
	 * @param index index, den das video innerhalb der playlist haben soll
	 */
	public function addItem(item:PlaylistItem, index:Number):Void
	{
		var left:Array 		= toItemsArray().slice(0, index);
		var right:Array 	= toItemsArray().slice(index);
		var complete:Array 	= left.concat(item).concat(right);
		this.items 			= complete;

		setIds();
	}

	/**
	 * loescht ein item aus der playlist
	 * @param item item, das aus der playlist geloescht werden soll
	 */
	public function removeItem(item:PlaylistItem):Void
	{
		// item liegt per definition an position (id - 1) im array der items
		this.items.splice(item.getID() - 1, 1);
		setIds();
	}

	/**
	 * gibt die gesamtdauer der playlist zurueck
	 * @return gesamtdauer aller videos in der playlist [s]
	 */
	public function getTotalduration():Number
	{
		// gesamtdauer
		var totalduration:Number = 0;
		// aktuelles item
		var item:PlaylistItem;
		// schleife ueber alle items
		for (var i : String in this.items) {
			item = this.items[i];
			if (item instanceof PlaylistVideoItem) {
				totalduration += PlaylistVideoItem(item).getVideo().getDuration();
			}
		}
		// zurueck geben
		return totalduration;
	}

	/**
	 * gibt alle items ab dem uebergebenen item zurueck
	 * @param startat item, mit dem die liste beginnen soll
	 * @return gibt die items als array zurueck
	 */
	public function getItemsFrom(startat:PlaylistItem ):Array
	{
		// item liegt per definition an position (id - 1) im array der items
		var index:Number = startat.getID() - 1;
		// liste der items
		var items:Array = toItemsArray().slice(index);
		// zurueck geben
		return (items);
	}

	/**
	 * gibt die anzahl der items zurueck, die mit dem uebergebenen item uebereinstimme
	 * @param item das zu untersuchende item
	 * @return gibt die anzahl der uebereinstimmenden items zu rueck
	 */
	public function getItemcount(item:PlaylistItem ):Number
	{
		// gesuchte anzahl
		var itemcount:Number = 0;
		// schleife ueber alle items
		for (var i : String in this.items) {
			// nur items mit video
			if (item instanceof PlaylistVideoItem) {
				// anzahl addieren, wenn uebereinstimmend
				itemcount += PlaylistVideoItem(item).getVideo().getID() == PlaylistVideoItem(this.items[i]).getVideo().getID() ? 1 : 0;
			}
		}
		// zurueck geben
		return itemcount;
	}

	public function toString() : String {
		return "com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl";
	}

	private function setIds():Void
	{
		// schleife ueber alle items
		for (var i:Number = 0; i < items.length; i++) {
			PlaylistItem(this.items[i]).setID(i + 1);
		}
	}

	/**
	 * Das Bean serialisiert seinen kompletten Inhalt in einen
	 * XML Knoten der entsprechend gespeichert werden sollte damit
	 * das ding wiedergeladen werden kann.
	 */
	public function SerializeXML () : XMLNode {
		var node:XMLNode = new XMLNode(1,"PLAYLIST");

		var nodeChild:XMLNode 	= new XMLNode(1,"PLAYLISTID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
		nodeChild.appendChild(
			new XMLNode(3,this.getMetainfo.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INFOTEXT");
		nodeChild.appendChild(
			new XMLNode(3,this.getInfoText()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADWALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadWallpaper()));
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"WALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getWallpaper()));
		node.appendChild(nodeChild);


		// metainfo
		this.getMetainfo().setLastmodified(new Date());
		var metainfo:MetainfoImpl = MetainfoImpl(this.getMetainfo());
		var nodeChild:XMLNode 	= metainfo.SerializeXML();
		node.appendChild(nodeChild);
		// warteloop
		var lV:PlaylistVideoItemImpl = PlaylistVideoItemImpl(this.getWarteLoop());
		var nodeChild:XMLNode 	= lV.SerializeXML("WARTECLIPLOOP");
		node.appendChild(nodeChild);
		// uebergang
		var uV:PlaylistVideoItemImpl = PlaylistVideoItemImpl(this.getUebergang());
		var nodeChild:XMLNode 	= uV.SerializeXML("UEBERGANGCLIP");
		node.appendChild(nodeChild);
		// trailer
		var tV:PlaylistVideoItemImpl = PlaylistVideoItemImpl(this.getTrailer());
		if (tV != null) {
			var nodeChild:XMLNode 	= tV.SerializeXML("TRAILERCLIP");
			node.appendChild(nodeChild);
		}
		// trailerloop
		var tV:PlaylistVideoItemImpl = PlaylistVideoItemImpl(this.getTrailerLoop());
		if (tV != null) {
			var nodeChild:XMLNode 	= tV.SerializeXML("TRAILERCLIPLOOP");
			node.appendChild(nodeChild);
		}

		// -----------------------------------------------------------------------------------------
		// Einzelne Items
		// -----------------------------------------------------------------------------------------
		// PlaylistItemImpl				PlaylistItem
		// PlaylistVideoItemImpl		PlaylistVideoItem 	- PlaylistItem
		// PlaylistChapterItemImpl		PlaylistChapterItem - PlaylistItem

		var itTemp:Array = this.toItemsArray();
		for (var i:Number = 0;i < itTemp.length;i++) {
			var itTempItem = itTemp[i];

			if (itTempItem instanceof PlaylistVideoItemImpl) {
				var nodeChild:XMLNode 	= itTempItem.SerializeXML("PLAYLISTITEMVIDEO");
				node.appendChild(nodeChild);
				continue;
			}
			if (itTempItem instanceof PlaylistChapterItemImpl) {
				var nodeChild:XMLNode 	= itTempItem.SerializeXML("PLAYLISTITEMCHAPTER");
				node.appendChild(nodeChild);
				continue;
			}
		}

		return node;

	}

	/**
	 * Die Klasse wird aus einer XML datei bedient
	 * Diese besteht aus Eckdaten sowie entsprechednen
	 * Chapterähnlichen Gebilden inklusive Videos
	 */
	public function DeserializeXML (node:XMLNode) : Void {
		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "PLAYLISTID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "METAINFOID") {
					continue;
				}
				if (strName == "METAINFO") {
					var mei:MetainfoImpl = new MetainfoImpl();
					mei.DeserializeXML(aNode);

					this.setMetainfo(mei);
					continue;
				}
				if (strName == "INFOTEXT") {
					this.setInfoText(strValue);
					continue;
				}

				if (strName == "PFADWALLPAPER") {
					this.setPfadWallpaper(strValue);
					continue;
				}
				if (strName == "WALLPAPER") {
					this.setWallpaper(strValue);
					continue;
				}


				if (strName == "WARTECLIPLOOP") {
					var lV:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					lV.DeserializeXML(aNode);

					this.setWarteLoop(lV);
					continue;
				}

				if (strName == "UEBERGANGCLIP") {
					var lV:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					lV.DeserializeXML(aNode);

					this.setUebergang(lV);
					continue;
				}

				// Auch eine Playlist hat den Ranz
				//
				if (strName == "TRAILERCLIP") {
					var trai:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					trai.DeserializeXML(aNode);

					this.setTrailer(trai);
					continue;
				}
				if (strName == "TRAILERCLIPLOOP") {
					var trai:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					trai.DeserializeXML(aNode);

					this.setTrailerLoop(trai);
					continue;
				}

				if (strName == "PLAYLISTITEMVIDEO") {
					var pii:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					pii.DeserializeXML(aNode);
					addItem(pii,pii.getID());

					continue;
				}
				if (strName == "PLAYLISTITEMCHAPTER") {
					var pii:PlaylistChapterItemImpl = new PlaylistChapterItemImpl();
					pii.DeserializeXML(aNode);
					this.addItems(pii);

					continue;
				}
			}
		}
	}
}