import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.MetainfoImpl;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.VideoImpl extends Video {

	// Dsa sind Sachen die im normalen Bean nicht da sind
	// weil dafür die entsprechenden Klassen eigehängt
	// werden.

	private var metainfoID:Number;
	private var chapterID:Number;
	private var repositoryID:Number;

	public function VideoImpl() {
		super();

		metainfoID 		= -1;
		chapterID 		= -1;
		repositoryID 	= -1;
	}

	// ReadOnly (nur für Ersteller)
	public function get_pMetainfoID():Number
	{
		return this.metainfoID;
	}
	public function get_pChapterID():Number
	{
		return this.chapterID;
	}
	public function get_pRepositoryID():Number
	{
		return this.repositoryID;
	}

	public function SerializeXML4Playlist (name:String) : XMLNode {
		var node:XMLNode = new XMLNode(1,name);

		var nodeChild:XMLNode 	= new XMLNode(1,"ITEMID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PAUSE");
		nodeChild.appendChild(
			new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"LOOPS");
		nodeChild.appendChild(
			new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"STOPMARKS");
		nodeChild.appendChild(
			new XMLNode(3, String(this.isActive() ? this.getDuration() - 1 : ""))); // TODO: stopmark eine sekunde vor ende
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INSTANCE");
		nodeChild.appendChild(
			new XMLNode(3,"VIDEO"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= SerializeXML("VIDEO");
		node.appendChild(nodeChild);

		return node;
	}

	/**
	 * Liefert ein Node was einem Videobean
	 * entspricht.
	 */
	public function SerializeXML (name:String) : XMLNode {
		var node:XMLNode = new XMLNode(1,name);

		var nodeChild:XMLNode 	= new XMLNode(1,"VIDEOID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERID");
		nodeChild.appendChild(
			new XMLNode(3,this.getChapter().getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"REPOSITORYID");
		nodeChild.appendChild(
			new XMLNode(3,this.getChapter().getRepository().getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"ACTIVE");
		if (this.isActive())
			nodeChild.appendChild(
				new XMLNode(3,"1"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"FILENAME");
		nodeChild.appendChild(
			new XMLNode(3,this.getFilename()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PFADVIDEO");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadFilme()));
		node.appendChild(nodeChild);
		var nodeChild:XMLNode 	= new XMLNode(1,"PFADTHUMBNAIL");
		nodeChild.appendChild(
			new XMLNode(3,this.getPfadThumbnails()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"THUMBNAIL");
		nodeChild.appendChild(
			new XMLNode(3,this.getThumbnail()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"TRAILER");
		if (this.isTrailer())
			nodeChild.appendChild(
				new XMLNode(3,"1"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"CHAPTERINDEX");
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"DURATION");
		nodeChild.appendChild(
			new XMLNode(3,this.getDuration().toString()));
		node.appendChild(nodeChild);

		// Metainfo direkt rein (mal sehen obs klappt)
		var meta = this.getMetainfo();
		var nodeChild:XMLNode 	= meta.SerializeXML();
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");

		nodeChild.appendChild(
			new XMLNode(3,this.getMetainfo().getID().toString()));
		node.appendChild(nodeChild);

		return node;
	}

	public function DeserializeXML (node:XMLNode) : Void {
		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				// Das Value ist als Textnode hinetrlegt im eigentlichen Node
				// VideoID;ChapterID;RepositoryID;active;filename;thumbnail;trailer;ChapterIndex;MetaInfoID

				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "VIDEOID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "CHAPTERID") {
					chapterID = strValue;
					continue;
				}
				if (strName == "REPOSITORYID") {
					repositoryID = strValue;
					continue;
				}
				if (strName == "ACTIVE") {
					if (strValue == "0")
						this.setActive(false);
					else
						this.setActive(true);
					continue;
				}
				if (strName == "FILENAME") {
					this.setFilename(strValue);
					continue;
				}

				if (strName == "PFADVIDEO") {
					this.setPfadFilme(strValue);
					continue;
				}
				if (strName == "PFADTHUMBNAIL") {
					this.setPfadThumbnails(strValue);
					continue;
				}

				if (strName == "THUMBNAIL") {
					this.setThumbnail(strValue);
					continue;
				}
				if (strName == "TRAILER") {
					if (strValue == "0")
						this.setTrailer(false);
					else
						this.setTrailer(true);
					continue;
				}
				if (strName == "CHAPTERINDEX") {
					continue;
				}
				if (strName == "DURATION") {
					this.setDuration(strValue);
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
					continue;
				}
			}
		}
	}

}