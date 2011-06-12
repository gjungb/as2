/*klasse:			XMLConfigLoaderautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			skandiaerstellung: 		03.12.2004zuletzt bearbeitet:	03.12.2004durch			gjstatus:			final*/import com.adgamewonderland.agw.*;import com.adgamewonderland.skandia.akademietool.interfaces.*;import com.adgamewonderland.skandia.akademietool.loaders.*;class com.adgamewonderland.skandia.akademietool.loaders.XMLConfigLoader extends GenericLoader implements IConfigLoader {	// Attributes		private var myXMLConnector:XMLConnector;		// Operations		// konstruktor	public function XMLConfigLoader()	{		// eigenschaften des GenericLoader		super();		// configdatei		var xmlfile:String = "skandia_akademietool_quiz_config.xml";		// xml connector		myXMLConnector = new XMLConnector(this, xmlfile);	}		public function addConsumer(con:IConfigConsumer ):Void	{		// neuer consumer		myConsumers.push(con);	}		public function loadConfig():Void	{		// config laden		myXMLConnector.loadXML("onConfigLoaded");	}		public function onConfigLoaded(xmlobj:XML ):Void	{		// xml in object umformen		var infos:Object = myXMLConnector.parseXMLNode(xmlobj.firstChild);		// quiz konfiguration		var config:QuizConfig = new QuizConfig(infos["numtasks"], infos["difficulties"].split(","), infos["time"], infos["topic"]);		// consumer informieren		for (var i:String in myConsumers) myConsumers[i].setConfig(config);	}	} /* end class XMLConfigLoader */