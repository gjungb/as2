import com.adgamewonderland.ea.nextlevel.model.beans.impl.VideoImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistVideoItemImpl extends PlaylistVideoItem {

	function PlaylistVideoItemImpl() {

		super();
		setVideo	(new VideoImpl());
	}

	/**
	 * utility methode, die ein video in ein PlaylistVideoItem wrapped
	 * @param pause
	 * @param loops
	 * @param stopmarks
	 * @param fullscreen
	 * @param video das zu wrappende video
	 * @return das gewrappte PlaylistVideoItem
	 */
	public static function wrapVideo(pause:Number, loops:Number, stopmarks:String, fullscreen:Boolean, video:Video ):PlaylistVideoItemImpl
	{
		// das item
		var item:PlaylistVideoItemImpl = new PlaylistVideoItemImpl();
		// setter durchgehen
		item.setPause(pause);
		item.setLoops(loops);
		item.setStopmarks(stopmarks);
		item.setFullScreen(fullscreen);
		item.setVideo(video);
		// zurueck geben
		return item;
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
				new XMLNode(3,"1"));
		else
			nodeChild.appendChild(
				new XMLNode(3,"0"));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"INSTANCE");
		nodeChild.appendChild(
			new XMLNode(3,"VIDEO"));
		node.appendChild(nodeChild);

		var vidTemp = this.getVideo();
		var nodeChild:XMLNode 	= vidTemp.SerializeXML("VIDEO");
		node.appendChild(nodeChild);

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
				if (strName == "FULLSCREEN") {
					if (strValue == "1")
						this.setFullScreen(true);
					else
						this.setFullScreen(false);
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
				if (strName == "VIDEO") {
					var vi:VideoImpl = new VideoImpl();
					vi.DeserializeXML(aNode);

					this.setVideo(vi);
					continue;
				}
			}
		}
	}


}