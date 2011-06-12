import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.MetainfoImpl extends Metainfo {

	public function MetainfoImpl() {
		super();
	}

	/**
	 * Serialisiert das Bean zu einem XML Knoten
	 * Der Name des Knotens METAINFO
	 */
	public function SerializeXML () : XMLNode {
		var node:XMLNode = new XMLNode(1,"METAINFO");

		var nodeChild:XMLNode 	= new XMLNode(1,"METAINFOID");
		nodeChild.appendChild(
			new XMLNode(3,this.getID().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"TITLE");
		nodeChild.appendChild(
			new XMLNode(3,this.getTitle()));
		node.appendChild(nodeChild);

		if (this.getSubtitle() != "") {
			var nodeChild:XMLNode 	= new XMLNode(1,"SUBTITLE");
			nodeChild.appendChild(
				new XMLNode(3,this.getSubtitle()));
			node.appendChild(nodeChild);
		}
		if (this.getPresenter() != "") {
			var nodeChild:XMLNode 	= new XMLNode(1,"PRESENTER");
			nodeChild.appendChild(
				new XMLNode(3,this.getPresenter()));
			node.appendChild(nodeChild);
		}
		if (this.getCity() != "") {
			var nodeChild:XMLNode 	= new XMLNode(1,"CITY");
			nodeChild.appendChild(
				new XMLNode(3,this.getCity()));
			node.appendChild(nodeChild);
		}
		if (this.getPresentationdate() != "") {
			var nodeChild:XMLNode 	= new XMLNode(1,"PRESENTATIONDATE");
			nodeChild.appendChild(
				new XMLNode(3,this.getPresentationdate()));
			node.appendChild(nodeChild);
		}
		if (this.getDescription() != "") {
			var nodeChild:XMLNode 	= new XMLNode(1,"DESCRIPTION");
			nodeChild.appendChild(
				new XMLNode(3,this.getDescription()));
			node.appendChild(nodeChild);
		}
		var nodeChild:XMLNode 	= new XMLNode(1,"CREATIONDATE");
		nodeChild.appendChild(
			new XMLNode(3,this.getCreationdate().toString()));
		node.appendChild(nodeChild);

		var nodeChild:XMLNode 	= new XMLNode(1,"LASTMODIFIED");
		nodeChild.appendChild(
			new XMLNode(3,this.getLastmodified().toString()));
		node.appendChild(nodeChild);

		// Neue Values

		return node;
	}

	/**
	 * erzeugt aus dem übergebenen XML Node die inneren
	 * Werte des Beans
	 */
	public function DeserializeXML (node:XMLNode) : Void {
		if (node != null) {
			for (var aNode:XMLNode = node.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var strName:String = aNode.nodeName.toUpperCase();
				var strValue = "";

				// Das Value ist als Textnode hinterlegt im eigentlichen Node
				// MetaInfoID;title;description;create;lastmodified
				if (aNode.firstChild.nodeType == 3)
					strValue = aNode.firstChild.nodeValue;

				if (strName == "METAINFOID") {
					this.setID(strValue);
					continue;
				}
				if (strName == "TITLE") {
					this.setTitle(strValue);
					continue;
				}
				if (strName == "DESCRIPTION") {
					this.setDescription(strValue);
					continue;
				}
				if (strName == "CREATIONDATE") {
					this.setCreationdate(strValue);
					continue;
				}
				if (strName == "LASTMODIFIED") {
					this.setLastmodified(strValue);
					continue;
				}
				if (strName == "SUBTITLE") {
					this.setSubtitle(strValue);
					continue;
				}
				if (strName == "CITY") {
					this.setCity(strValue);
					continue;
				}
				if (strName == "PRESENTER") {
					this.setPresenter(strValue);
					continue;
				}
				if (strName == "PRESENTATIONDATE") {
					this.setPresentationdate(strValue);
					continue;
				}
			}
		}
	}
}