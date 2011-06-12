import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistItemImpl extends PlaylistItem {

	function PlaylistItemImpl() {
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

		return node;
	}

	/**
	 */
	public function DeserializeXML (node:XMLNode) : Void {
	}

}