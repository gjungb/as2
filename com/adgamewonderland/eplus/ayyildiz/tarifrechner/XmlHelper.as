class com.adgamewonderland.eplus.ayyildiz.tarifrechner.XmlHelper
{
	static function nodeByName(name:String,node:XMLNode) : XMLNode
	{
		do 
		{
			if (node.nodeName==name) return node;
			if (node.firstChild!=null) 
			{
				var n:XMLNode = nodeByName(name,node.firstChild);
				if (n!=null) return n;
			}
			node = node.nextSibling;
		} 
		while (node!=null);
		
		return null;
	}

	// --
	private function XmlHelper() {}
};