import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistChapterItem;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistChapterItemImpl extends PlaylistChapterItem {

	public function PlaylistChapterItemImpl() {
		super();
	}

	/**
	 * Das Bean serialisiert seinen kompletten Inhalt in einen
	 * XML Knoten der entsprechend gespeichert werden sollte damit
	 * das ding wiedergeladen werden kann.
	 */
	public function SerializeXML (name:String) : XMLNode {
		var node:XMLNode = new XMLNode(1,name);

		var nodeChild:XMLNode 	= new XMLNode(1,"ITEMID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"PAUSE");
		nodeChild.appendChild(
			new XMLNode(3,this.getPause().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"LOOPS");
		nodeChild.appendChild(
			new XMLNode(3,this.getLoops().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"STOPMARKS");
		nodeChild.appendChild(
			new XMLNode(3,this.getStopmarks()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"FULLSCREEN");
		if (this.isFullScreen())
			nodeChild.appendChild(
				new XMLNode(3,"ja"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"nein"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INSTANCE");
		nodeChild.appendChild(
			new XMLNode(3,"CHAPTER"));
		node.appendChild(nodeChild);

		// Die Videos entsprechend verarbeiten

//		var chapTemp = this.getChapter();
//		var nodeChild:XMLNode 	= chapTemp.SerializeXML("CHAPTER");
//		node.appendChild(nodeChild);

		return node;
	}

	/**
	 */
	public function DeserializeXML (node:XMLNode) : Void {

		if (node != null) {

			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "ITEMID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "PAUSE") {
					this.setPause(strValue);
					continue;
				}
				if (strName == "LOOPS") {
					this.setLoops(strValue);
					continue;
				}
				if (strName == "STOPMARKS") {
					this.setStopmarks(strValue);
					continue;
				}
				if (strName == "FULLSCREEN") {
					if (strValue == "ja")
						this.setFullScreen(true);
					else
						this.setFullScreen(false);
					continue;
				}

				// Das wird noch nicht gehen () spezial da in diesem Fall keine Videoitems
				// im chapter sitzen sonder Playlistitems (als Video implementierung)
				if (strName == "CHAPTER") {
					var ch:ChapterImpl = new ChapterImpl();
					ch.DeserializeXML(aNode);

					// Lade alle Infos
					this.setChapter(ch);
					continue;
				}
			}
		}
	}
}