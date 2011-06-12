import com.adgamewonderland.ea.nextlevel.model.beans.Chapter;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.MetainfoImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.VideoImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistVideoItemImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl extends Chapter {

	private var repositoryID:Number;
	private var videoID:Number;			// Trailer ID (wird zu einem Videobean)
	private var videoIDLoop:Number;
	private var videoIDUebergang:Number;

	private var metainfoID:Number;		// Metainfoid (s.o.)
	private var chapterBezugID:Number;	// Ich bin Sohn eines anderern

	public function ChapterImpl() {
		super();

		repositoryID 	= -1;

		videoID 			= -1;
		videoIDLoop			= -1;
		videoIDUebergang	= -1;

		metainfoID 		= -1;
		chapterBezugID 	= -1;
	}

	// ReadOnly (nur für Ersteller)
	public function get_pMetainfoID():Number
	{
		return this.metainfoID;
	}
	public function get_pRepositoryID():Number
	{
		return this.repositoryID;
	}
	public function get_pVideoID():Number
	{
		return this.videoID;
	}
	public function get_pVideoIDLoop():Number
	{
		return this.videoIDLoop;
	}
	public function get_pVideoIDUebergang():Number
	{
		return this.videoIDUebergang;
	}
	public function get_pChapterBezugID():Number
	{
		return this.chapterBezugID;
	}

	/**
	 * Serialisiert das gesamte Bean in einen
	 * XML Knoten
	 */
	public function SerializeXML (name:String) : XMLNode {

		var node:XMLNode = new XMLNode(1,name);
		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYID");
		nodeChild.appendChild(
			new XMLNode(3,this.getRepository().getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"ACTIVE");
		if (this.isActive())
			nodeChild.appendChild(
				new XMLNode(3,"1"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"AUTHOR");
		nodeChild.appendChild(
			new XMLNode(3,this.getAuthor()));
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"PFADWALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadWallpaper()));
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"WALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getWallpaper()));
		node.appendChild(nodeChild);


		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYINDEX");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERIDBEZUG");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOID");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDLOOP");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDUEBERGANG");
		node.appendChild(nodeChild);

		// Trailer
		var trailer = this.getTrailer();
		var nodeChild:XMLNode 	= trailer.SerializeXML("TRAILERCLIP");
		node.appendChild(nodeChild);

		var trailer = this.getTrailerLoop();
		var nodeChild:XMLNode 	= trailer.SerializeXML("TRAILERCLIPLOOP");
		node.appendChild(nodeChild);
		var trailer = this.getUebergang();
		var nodeChild:XMLNode 	= trailer.SerializeXML("UEBERGANGCLIP");
		node.appendChild(nodeChild);

		// metainfo
		var meta = this.getMetainfo();
		var nodeChild:XMLNode 	= meta.SerializeXML();
		node.appendChild(nodeChild);

		// Videoliste
		var viTemp:Array = this.toVideosArray();
		for (var i:Number = 0;i < viTemp.length;i++) {
			var viTempItem = viTemp[i];

			var nodeChild:XMLNode 	= viTempItem.SerializeXML("VIDEOCLIP");
			node.appendChild(nodeChild);
		}

		// Chapters
		var chTemp:Array = this.toChaptersArray();
		for (var i:Number = 0;i < chTemp.length;i++) {
			var chTempItem = chTemp[i];

			var nodeChild:XMLNode 	= chTempItem.SerializeXML("CHAPTER");
			node.appendChild(nodeChild);
		}

		return node;
	}

	/**
	 * Serialisiert das Chapter komplett für eine Playliste
	 */
	public function SerializeXML4Playlist (name:String) : XMLNode {

		var node:XMLNode = new XMLNode(1,name);

		// Erst alles für die Playlist
		var nodeChild:XMLNode 	= new XMLNode(1,"ITEMID");
		nodeChild.appendChild(
			new XMLNode(3,"1"));
		node.appendChild(nodeChild);

//		var nodeChild:XMLNode 	= new XMLNode(1,"PAUSE");
//		nodeChild.appendChild(
//			new XMLNode(3,"0"));
//		node.appendChild(nodeChild);
//
//		var nodeChild:XMLNode 	= new XMLNode(1,"LOOPS");
//		nodeChild.appendChild(
//			new XMLNode(3,"0"));
//		node.appendChild(nodeChild);
//
//		var nodeChild:XMLNode 	= new XMLNode(1,"STOPMARKS");
//		nodeChild.appendChild(
//			new XMLNode(3,"0"));
//		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INSTANCE");
		nodeChild.appendChild(
			new XMLNode(3,"CHAPTER"));
		node.appendChild(nodeChild);

		// Normales Chapter
		var nodeChapt:XMLNode 	= new XMLNode(1,"CHAPTER");
		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		nodeChapt.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYID");
		nodeChild.appendChild(
			new XMLNode(3,this.getRepository().getID().toString()));
		nodeChapt.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"ACTIVE");
		if (this.isActive())
			nodeChild.appendChild(
				new XMLNode(3,"1"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"0"));
		nodeChapt.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"AUTHOR");
		nodeChild.appendChild(
			new XMLNode(3,this.getAuthor()));
		nodeChapt.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADWALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadWallpaper()));
		nodeChapt.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"WALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getWallpaper()));
		nodeChapt.appendChild(nodeChild);

//		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYINDEX");
//		nodeChapt.appendChild(nodeChild);
//		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERIDBEZUG");
//		nodeChapt.appendChild(nodeChild);
//		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
//		nodeChapt.appendChild(nodeChild);
//		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOID");
//		nodeChapt.appendChild(nodeChild);
//		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDLOOP");
//		nodeChapt.appendChild(nodeChild);
//		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDUEBERGANG");
//		nodeChapt.appendChild(nodeChild);

		// metainfo
		var meta:Metainfo = this.getMetainfo();
		var nodeChild:XMLNode 	= MetainfoImpl(meta).SerializeXML();
		nodeChapt.appendChild(nodeChild);
		// trailer
		var trailer:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, 0, "", false, this.getTrailer().getVideo());
		var nodeChild:XMLNode 	= trailer.SerializeXML("TRAILERCLIP");
		nodeChapt.appendChild(nodeChild);
		// trailerloop
		var trailerloop:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, PlaylistVideoItem.LOOPS_INFINITE, "", false, this.getTrailerLoop().getVideo());
		var nodeChild:XMLNode 	= trailerloop.SerializeXML("TRAILERCLIPLOOP");
		nodeChapt.appendChild(nodeChild);
		// uebergang
		var uebergang:PlaylistVideoItemImpl =
			PlaylistVideoItemImpl.wrapVideo(0, 0, "", false, this.getUebergang().getVideo());
		var nodeChild:XMLNode 	= uebergang.SerializeXML("UEBERGANGCLIP");
		nodeChapt.appendChild(nodeChild);

		// Videoliste
		var viTemp:Array = this.toVideosArray();
		for (var i:Number = 0;i < viTemp.length;i++) {
			var viTempItem:VideoImpl = viTemp[i];

			var nodeChild:XMLNode 	= viTempItem.SerializeXML4Playlist("PLAYLISTITEMVIDEO");
			nodeChapt.appendChild(nodeChild);
		}

		node.appendChild(nodeChapt);
		return node;
	}



	/**
	 * Erzeugt aus dem übergebenen XML Knoten die inneren Werte
	 * des Beans
	 */
	public function DeserializeXML (node:XMLNode) : Void {
		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				// Das Value ist als Textnode hinetrlegt im eigentlichen Node
				// ChapterID;RepositoryID;active;author;ChapterIDBezug;RepositoryIndex;MetaInfoID

				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "REPOSITORYID") {
					this.repositoryID = strValue;
					continue;
				}
				if (strName == "CHAPTERIDBEZUG") {
					this.chapterBezugID = strValue;
					continue;
				}

				if (strName == "CHAPTERID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "ACTIVE") {
					if (strValue == "0")
						this.setActive(false);
					else
						this.setActive(true);
					continue;
				}
				if (strName == "AUTHOR") {
					this.setAuthor(strValue);
					continue;
				}
				if (strName == "REPOSITORYINDEX") {
					continue;
				}

				if (strName == "WALLPAPER") {
					this.setWallpaper(strValue);
					continue;
				}
				if (strName == "PFADWALLPAPER") {
					this.setPfadWallpaper(strValue);
					continue;
				}

				// Die ID der Metainfo falls vorhanden
				if (strName == "METAINFOID") {
					this.metainfoID = strValue;
					continue;
				}
				// Es kann auch sein das das Metainfo direkt im XML hockt
				if (strName == "METAINFO") {
					var mei:MetainfoImpl = new MetainfoImpl();
					mei.DeserializeXML(aNode);

					this.setMetainfo(mei);

					// Wenn das so ist dann wird die ID auf alle
					// Fälle ungültig gemacht dami das Bean geschützt
					// ist
					this.metainfoID = -1;
				}

				// Die ID des Trailers falls vorhanden
				if (strName == "VIDEOID") {
					this.videoID = strValue;
					continue;
				}
				if (strName == "VIDEOIDLOOP") {
					this.videoIDLoop = strValue;
					continue;
				}
				if (strName == "VIDEOIDUEBERGANG") {
					this.videoIDUebergang = strValue;
					continue;
				}

				// Es kann sein das der Trailer als Bean im Knoten hockt
				if (strName == "TRAILERCLIP") {
					var trai:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					trai.DeserializeXML(aNode);

//					trai.setPfadFilme(this.getRepository().getPfadFilme());
//					trai.setPfadThumbnails(this.getRepository().getPfadThumbnails());

					this.setTrailer(trai);

					// Wenn das so ist dann wird die ID auf alle
					// Fälle ungültig gemacht dami das Bean geschützt
					// ist
					this.videoID = -1;
					continue;
				}
				if (strName == "TRAILERCLIPLOOP") {
					var trai:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					trai.DeserializeXML(aNode);

//					trai.setPfadFilme(this.getRepository().getPfadFilme());
//					trai.setPfadThumbnails(this.getRepository().getPfadThumbnails());

					this.setTrailerLoop(trai);
					this.videoIDLoop = -1;
					continue;
				}
				if (strName == "UEBERGANGCLIP") {
					var trai:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					trai.DeserializeXML(aNode);

//					trai.setPfadFilme(this.getRepository().getPfadFilme());
//					trai.setPfadThumbnails(this.getRepository().getPfadThumbnails());

					this.setUebergang(trai);
					this.videoIDUebergang = -1;
					continue;
				}

				// Es ist auch denkbar das die Videoliste im XML hockt
				// Dann wird alledings interesant
				if (strName == "VIDEOCLIP") {
					// Nehme den Knoten und arbeite den Knoten in das
					// Array ein
					var clip:VideoImpl = new VideoImpl();
					clip.DeserializeXML(aNode);

//					clip.setPfadFilme(this.getRepository().getPfadFilme());
//					clip.setPfadThumbnails(this.getRepository().getPfadThumbnails());

					clip.setChapter(this);
					this.addVideos(clip);

					continue;
				}

				// Es können weitere Chapter im Chapter eingebettet sein
				// Diese werden hier erzeugt und entsprechend in die Liste
				// eingearbeitet
				if (strName == "CHAPTER") {
					var chapt:ChapterImpl = new ChapterImpl();
					chapt.setRepository(this.getRepository());

					chapt.DeserializeXML(aNode);
					this.addChapters(chapt);

					continue;
				}

				/**
				 * Es können auch Playlistitemvideos in der
				 * Datei stehen. (Für die Gesamtpresentation)
				 */
				if (strName == "PLAYLISTITEMVIDEO") {
					var clip:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
					clip.DeserializeXML(aNode);

					clip.setChapter(this);
					this.addVideos(clip);

					continue;
				}
			}
		}
	}
}