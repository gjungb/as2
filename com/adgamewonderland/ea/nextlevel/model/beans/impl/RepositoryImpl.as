import com.adgamewonderland.ea.nextlevel.model.beans.Repository;
import com.adgamewonderland.ea.nextlevel.swfstudio.CSVReader;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.*;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.RepositoryImpl extends Repository {
	private var archivName:String;		// wo liegt das archive (pfad)
	private var videoID:Number;			// Trailer ID (wird zu einem Videobean)
	private var metainfoID:Number;		// Metainfoid (s.o.)

	private var videoIDLoop:Number;
	private var videoIDUebergang:Number;
	private var videoIDWarteLoop:Number;

	// in diesem verzeichniss liegen 4 Dateien
	private var reposiCSV:CSVReader;
	private var chapterCSV:CSVReader;
	private var videoCSV:CSVReader;
	private var metainfoCSV:CSVReader;

	// repository.csv
	// video.csv
	// chapter.csv
	// metainfo.csv

	// In dieser Impl werden die Datein ausgelesen und entsprechend in Beans
	// verwandelt.

	public function RepositoryImpl() {
		// Eigene aktionen (kein Dynamischer Kram)
		super();

		archivName 	= "startdir://";
		videoID 			= -1;
		videoIDLoop			= -1;
		videoIDUebergang	= -1;
		videoIDWarteLoop	= -1;

		metainfoID 	= -1;

		reposiCSV	 	= new CSVReader();
		chapterCSV	 	= new CSVReader();
		videoCSV 		= new CSVReader();
		metainfoCSV 	= new CSVReader();

	}

	/**
	 *
	 */
	public function setArchivPfad(value:String):Void	{
		this.archivName = value;

		reposiCSV.setDateiname	(archivName + "/repository.csv");
		chapterCSV.setDateiname	(archivName + "/chapter.csv");
		videoCSV.setDateiname	(archivName + "/video.csv");
		metainfoCSV.setDateiname(archivName + "/metainfo.csv");
	}

	/**
	 * Speichert das Repository als XML Datei weg
	 * Es werden hier Funktionen vom SWF Studio verwendet.
	 */
	public function writeRepositoryAsXML (datName:String) : Void {
		var header:String = '<?xml version="1.0"?>' + String.fromCharCode(13) + String.fromCharCode(10);
		var repo:XMLNode = SerializeXML();

		var content = header + repo.toString();
		ssCore.FileSys.writeToFile(
			{
				path:datName,
				data:content
			}
		);
	}

	/**
	 * Konvertiert das komplette Repository in ein XML
	 * Format was eine Playlist verarbeiten kann.
	 *
	 */
	public function writeRepositoryAsXML4Playlist (datName:String) : Void {
		// var header:String = '<?xml version="1.0"?>' + String.fromCharCode(13) + String.fromCharCode(10);

		var header:String = "";
		var playlist:PlaylistImpl = new PlaylistImpl();

		playlist.setID(100);
//		getMetainfo().setTitle			("Komplettes Repository");
//		getMetainfo().setDescription	("Komplett");
//		getMetainfo().setCreationdate	(new Date());
//		getMetainfo().setLastmodified	(new Date());
		var repo:XMLNode = playlist.convertRepository2Playlist(this);

		var content = header + repo.toString();

		ssCore.FileSys.writeToFile(
			{
				path:datName,
				data:content
			}
		);
	}

	/**
	 * Liest das Repository aus einer XML Datei
	 */
	public function readRepositoryFromXML (datName:String) : Boolean {
		var file_obj = ssCore.FileSys.readFile (
			{path:datName}
		);
		if (file_obj.success) {
			var content:String = file_obj.result;
			var xml:XML = new XML(content);

			DeserializeXML(xml.firstChild);
		}
		else
			return false;
		return true;
	}

	public function readRepositorySynchronized () : Boolean {
		// Alle datein lesen und in XML wandeln
		// Danach die Knoten in Beans wandeln und entsprechend
		// in die Listen des Reps einhängen

		// Öffnen und lesen
		var ret1:Boolean = reposiCSV.readFile();
		var ret2:Boolean = chapterCSV.readFile();
		var ret3:Boolean = videoCSV.readFile();
		var ret4:Boolean = metainfoCSV.readFile();

		// Wenn ok dann Nodes laden
		var nodeReposi:XMLNode 		= null;
		var nodeChapter:XMLNode 	= null;
		var nodeVideos:XMLNode 		= null;
		var nodeMetainfo:XMLNode 	= null;

		if (ret1 == true) {
			nodeReposi = reposiCSV.getXMLAll("root","REPOSITORY");

			// In dieser Version wird nur ein Repository pro Catalog unterstützt
			for (var aReposi:XMLNode = nodeReposi.firstChild; aReposi != null; aReposi = aReposi.nextSibling) {
				DeserializeXML(aReposi);
			}

			if (ret2 == true)
				nodeChapter = chapterCSV.getXMLAll("root","CHAPTER");
			if (ret3 == true)
				nodeVideos = videoCSV.getXMLAll("root","VIDEO");
			if (ret4 == true)
				nodeMetainfo = metainfoCSV.getXMLAll("root","METAINFO");

			var ChapterArr 	: Array = DeserializeChapters 	(nodeChapter);
			var VideoArr 	: Array = DeserializeVideos 	(nodeVideos);
			var MetaArr 	: Array = DeserializeMetainfos 	(nodeMetainfo);

			// Alle Videos haben ein Metainfo
			// Außerdem wird der Pfad für Film und Thumbnail gesetzt
			if (VideoArr.length > 0) {
				for (var i:Number = 0;i < VideoArr.length;i++) {
					var vTemp:VideoImpl = VideoArr[i];

					// Pfade gesetzt
					vTemp.setPfadFilme(this.getPfadFilme());
					vTemp.setPfadThumbnails(this.getPfadThumbnails());

					for (var ii:Number = 0;ii < MetaArr.length;ii++) {
						var temp:MetainfoImpl = MetaArr[ii];
						if (temp.getID() == vTemp.get_pMetainfoID()) {
							vTemp.setMetainfo(temp);
							break;
						}
					}
				}
			}

			// Alle Chapter haben Metainfo
			// In den Chaptern befinden sich Videos
			// jedes Chapter kann zu einem anderen Chapter gehören
			if (ChapterArr.length > 0) {
				for (var i:Number = 0;i < ChapterArr.length;i++) {
					var cTemp:ChapterImpl = ChapterArr[i];

					// Pfad für Wallpaper
					cTemp.setPfadWallpaper(this.getPfadWallpaper());

					// Lege die Metainfo dazu
					for (var ii:Number = 0;ii < MetaArr.length;ii++) {
						var temp:MetainfoImpl = MetaArr[ii];
						if (temp.getID() == cTemp.get_pMetainfoID()) {
							cTemp.setMetainfo(temp);
							break;
						}
					}

					// Lege alle Videos die man zu diesem Chapter findet
					// in das Chapter
					for (var ii:Number = 0;ii < VideoArr.length;ii++) {
						var tempV:VideoImpl = VideoArr[ii];
						if (tempV.get_pChapterID() == cTemp.getID() && tempV.get_pRepositoryID() == this.getID()) {
							// verheiraten
							tempV.setChapter(cTemp);		// Gestatten Chapter
							cTemp.addVideos	(tempV);		// Gestatten Video
						}
					}

					// Hat der Chapter einen Trailer
					if (cTemp.get_pVideoID() > 0) {
						for (var ii:Number = 0;ii < VideoArr.length;ii++) {
							var tempV:VideoImpl = VideoArr[ii];
							if (tempV.getID() == cTemp.get_pVideoID()) {
								if (tempV.isActive() && tempV.isTrailer()) {
									// aus dem Trailer etc wird ein PlaylistVideoItem
									var pli:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
									pli.setVideo(tempV);
									cTemp.setTrailer(pli);
								}
								break;
							}
						}
					}

					// Hat der Chapter einen TrailerLoop
					if (cTemp.get_pVideoIDLoop() > 0) {
						for (var ii:Number = 0;ii < VideoArr.length;ii++) {
							var tempV:VideoImpl = VideoArr[ii];
							if (tempV.getID() == cTemp.get_pVideoIDLoop()) {
								if (tempV.isActive()) {
									// aus dem Trailer etc wird ein PlaylistVideoItem
									var pli:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
									pli.setVideo(tempV);
									cTemp.setTrailerLoop(pli);
								}
								break;
							}
						}
					}
					// Hat der Chapter ein Uebergangsvideo
					if (cTemp.get_pVideoIDUebergang() > 0) {
						for (var ii:Number = 0;ii < VideoArr.length;ii++) {
							var tempV:VideoImpl = VideoArr[ii];
							if (tempV.getID() == cTemp.get_pVideoIDUebergang()) {
								if (tempV.isActive()) {
									// aus dem Trailer etc wird ein PlaylistVideoItem
									var pli:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
									pli.setVideo(tempV);
									cTemp.setUebergang(pli);
								}
								break;
							}
						}
					}
				}

				// Jetzt kommt der Part das Chapter gehört zu einem anderen Chapter
				for (var i:Number = 0;i < ChapterArr.length;i++) {
					var cTemp:ChapterImpl = ChapterArr[i];
					if (cTemp.get_pChapterBezugID() > 0) {
						for (var ii:Number = 0;ii < ChapterArr.length;ii++) {
							var ccTemp:ChapterImpl = ChapterArr[ii];

							if (ccTemp.getID() == cTemp.get_pChapterBezugID()) {
								ccTemp.addChapters(cTemp);
								break;
							}
						}
					}
				}
			}

			// Lade für das Repository den Trailer (als Video)
			// und die Metainfo
			if (videoID > 0) {
				for (var i:Number = 0;i < VideoArr.length;i++) {
					var tempV:VideoImpl = VideoArr[i];
					if (tempV.getID() == videoID) {
						if (tempV.isActive() && tempV.isTrailer())
							this.setTrailer(tempV);
						break;
					}
				}
			}
			if (videoIDLoop > 0) {
				for (var i:Number = 0;i < VideoArr.length;i++) {
					var tempV:VideoImpl = VideoArr[i];
					if (tempV.getID() == videoIDLoop) {
						if (tempV.isActive())
							this.setTrailerLoop(tempV);
						break;
					}
				}
			}
			if (videoIDWarteLoop > 0) {
				for (var i:Number = 0;i < VideoArr.length;i++) {
					var tempV:VideoImpl = VideoArr[i];
					if (tempV.getID() == videoIDWarteLoop) {
						if (tempV.isActive())
							this.setWarteLoop(tempV);
						break;
					}
				}
			}
			if (videoIDUebergang > 0) {
				for (var i:Number = 0;i < VideoArr.length;i++) {
					var tempV:VideoImpl = VideoArr[i];
					if (tempV.getID() == videoIDUebergang) {
						if (tempV.isActive())
							this.setUebergang(tempV);
						break;
					}
				}
			}

			if (metainfoID > 0) {
				for (var i:Number = 0;i < MetaArr.length;i++) {
					var temp:MetainfoImpl = MetaArr[i];
					if (temp.getID() == metainfoID) {
						this.setMetainfo(temp);
						break;
					}
				}
			}

			// Lege die Chapter in das Repository
			if (ChapterArr.length > 0) {
				for (var i:Number = 0;i < ChapterArr.length;i++) {
					var cTemp:ChapterImpl = ChapterArr[i];
					if (cTemp.get_pRepositoryID() == this.getID()) {
						if (cTemp.get_pChapterBezugID() <= 0) {
							// Nur Root Knoten kommen ins Feld
							this.addChapters(cTemp);
							cTemp.setRepository(this);
						}
					}
				}
			}
//			writeRepositoryAsXML4Playlist("Repository\\RepoAsPlaylist.xml");
			writeRepositoryAsXML4Playlist("Playlist\\" + getMetainfo().getTitle() +  ".xml"); //
			// traceXML();
			return true;
		}

		return false;
	}

	private function DeserializeChapters (node:XMLNode) : Array {
		var retArr:Array = new Array();

		if (node != null) {

			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var chaptTemp : ChapterImpl = new ChapterImpl();
				chaptTemp.DeserializeXML(aNode);
				retArr.push(chaptTemp);
			}
		}
		return retArr;
	}

	private function DeserializeVideos (node:XMLNode) : Array {
		var retArr:Array = new Array();

		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var videoTemp : VideoImpl = new VideoImpl();
				videoTemp.DeserializeXML(aNode);
				retArr.push(videoTemp);
			}
		}
		return retArr;
	}

	private function DeserializeMetainfos (node:XMLNode) : Array {
		var retArr:Array = new Array();

		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var metaTemp : MetainfoImpl = new MetainfoImpl();
				metaTemp.DeserializeXML(aNode);

				retArr.push(metaTemp);
			}
		}
		return retArr;
	}

	/**
	 * Das gesamte Repository wir im XMLNode abgelegt
	 */
	public function SerializeXML() : XMLNode {

		var node:XMLNode = new XMLNode(1,"REPOSITORY");

		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADFILME");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadFilme()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADTHUMBNAILS");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadThumbnails()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADWALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadWallpaper()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"WALLPAPER");
		nodeChild.appendChild(
			new XMLNode(3,this.getWallpaper()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INFOTEXT");
		nodeChild.appendChild(
			new XMLNode(3,this.getInfoText()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PUBLISHER");
		nodeChild.appendChild(
			new XMLNode(3,this.getPublisher()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOID");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDLOOP");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDUEBERGANG");
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOIDWARTELOOP");
		node.appendChild(nodeChild);

		// Trailer
		var trailer = this.getWarteLoop();
		var nodeChild:XMLNode 	= trailer.SerializeXML("WARTECLIPLOOP");
		node.appendChild(nodeChild);

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
	 * Diese Funktion ist in der Lage ein komplettes
	 * Repository aus einem XML Knoten zu lesen.
	 */
	public function DeserializeXML (node:XMLNode) : Void {
		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				// Das Value ist als Textnode hinterlegt im eigentlichen Node
				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "REPOSITORYID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "PUBLISHER") {
					this.setPublisher(strValue);
					continue;
				}

				// Außerdem können auch noch die Listen als Knoten
				// im Repository hocken
				// Die ID der Metainfo falls vorhanden
				if (strName == "PFADFILME") {
					this.setPfadFilme(strValue);
					continue;
				}
				if (strName == "PFADTHUMBNAILS") {
					this.setPfadThumbnails(strValue);
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

				if (strName == "INFOTEXT") {
					this.setInfoText(strValue);
					continue;
				}
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
				if (strName == "VIDEOIDWARTELOOP") {
					this.videoIDWarteLoop = strValue;
					continue;
				}

				// Es kann sein das der Trailer als Bean im Knoten hockt
				if (strName == "TRAILERCLIP") {
					var trai:VideoImpl = new VideoImpl();
					trai.DeserializeXML(aNode);

					trai.setPfadFilme(this.getPfadFilme());
					trai.setPfadThumbnails(this.getPfadThumbnails());

					this.setTrailer(trai);

					// Wenn das so ist dann wird die ID auf alle
					// Fälle ungültig gemacht dami das Bean geschützt
					// ist
					this.videoID = -1;
					continue;
				}
				if (strName == "TRAILERCLIPLOOP") {
					var trai:VideoImpl = new VideoImpl();
					trai.DeserializeXML(aNode);

					trai.setPfadFilme(this.getPfadFilme());
					trai.setPfadThumbnails(this.getPfadThumbnails());

					this.setTrailerLoop(trai);
					this.videoIDLoop = -1;
					continue;
				}
				if (strName == "UEBERGANGCLIP") {
					var trai:VideoImpl = new VideoImpl();
					trai.DeserializeXML(aNode);

					trai.setPfadFilme(this.getPfadFilme());
					trai.setPfadThumbnails(this.getPfadThumbnails());

					this.setUebergang(trai);

					this.videoIDUebergang = -1;
					continue;
				}
				if (strName == "WARTECLIPLOOP") {
					var trai:VideoImpl = new VideoImpl();
					trai.DeserializeXML(aNode);

					trai.setPfadFilme(this.getPfadFilme());
					trai.setPfadThumbnails(this.getPfadThumbnails());

					this.setWarteLoop(trai);
					this.videoIDWarteLoop = -1;
					continue;
				}


				// Baue die Chapterliste zusammen
				if (strName == "CHAPTER") {
					var chapt:ChapterImpl = new ChapterImpl();
					chapt.setRepository(this);

					chapt.DeserializeXML(aNode);
					this.addChapters(chapt);

					continue;
				}


			}
		}
	}

	public function traceXML () : Void {
		var trailRep 		= getTrailer();
		var trailLoopRep 	= getTrailerLoop();
		var warteRep 		= getWarteLoop();
		var uebergangRep 	= getUebergang();

		ssDebug.trace(debugTrace());
		ssDebug.trace(trailRep.debugTrace());
		ssDebug.trace(trailLoopRep.debugTrace());
		ssDebug.trace(warteRep.debugTrace());
		ssDebug.trace(uebergangRep.debugTrace());

		var chapters:Array = toChaptersArray();
		for (var i:Number = 0;i < chapters.length;i++) {
			var cTemp:ChapterImpl 	= chapters[i];
			traceChapter (cTemp,"> ");
		}
	}

	private function traceChapter (chap:ChapterImpl,prefix:String) : Void {
		var mTemp 		= chap.getMetainfo();

		ssDebug.trace(prefix + chap.debugTrace());
		ssDebug.trace(prefix + " > " + mTemp.debugTrace());

		var trail 		= chap.getTrailer();
		var trailLoop 	= chap.getTrailerLoop();
		var uebergang 	= chap.getUebergang();

		ssDebug.trace(prefix + " > " + trail.debugTrace());
		ssDebug.trace(prefix + " > " + trailLoop.debugTrace());
		ssDebug.trace(prefix + " > " + uebergang.debugTrace());

		var videos:Array = chap.toVideosArray();

		for (var ii:Number = 0;ii < videos.length;ii++) {
			var vTemp:VideoImpl = videos[ii];
			ssDebug.trace(prefix + " >> " + vTemp.debugTrace());

			var x2:XMLNode = vTemp.SerializeXML("VIDEO");
			ssDebug.trace (prefix + " >> " + x2.toString());
		}

		// Noch ein Chapter im Feld
		var chaptersIn:Array = chap.toChaptersArray();

		for (var iii:Number = 0;iii < chaptersIn.length;iii++) {
			var cTempIn:ChapterImpl = chaptersIn[iii];
			traceChapter (cTempIn,prefix + " >>> ");
		}
	}

}