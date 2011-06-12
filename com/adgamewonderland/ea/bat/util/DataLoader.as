import com.adgamewonderland.ea.bat.data.PublisherData;
import com.adgamewonderland.agw.util.*;
import de.kruesch.event.*;

class com.adgamewonderland.ea.bat.util.DataLoader
{
	private var _event:EventBroadcaster;

	function addListener(o:Object) : Void 
	{
		_event.addListener(o);
	}

	function removeListener(o:Object) : Void 
	{
		_event.removeListener(o);
	}

	// XML geladen
	function onLoadXml(xml:XML) : Void
	{
		var publishers:Array = [];

		var node:XMLNode = XMLHelper.nodeByName("publisherData",xml);
		do
		{
			var name:String = node.attributes["name"];
			var share:Number = parseFloat(node.attributes["share"]) / 100;
			var avgPrice:Number = parseFloat(node.attributes["avgPrice"]);

			publishers.push(new PublisherData(name,share,avgPrice));

			node = node.nextSibling;
		} 
		while (node!=null);
	
		// -------------------------------------------
		var distribution:Array = [];

		node = XMLHelper.nodeByName("anualdistribution",xml).firstChild;
		var sum:Number = 0;
		do
		{
			var weight:Number = parseFloat(node.attributes["weight"])/100.0;
			distribution.push(weight);
			sum += weight;

			node = node.nextSibling;
		}
		while (node!=null);

		if (distribution.length!=12)
		{
			trace("**** WARNING: ****");
			trace("Anzahl Monate in anualdistribution ungleich 12: "+distribution.length);
		}

		for (var i=0; i<12; i++)
		{
			distribution[i] /= sum; 
		}

		_event.send("onPublishersLoaded", this, publishers, distribution );
	}

	// Fehler in XML
	function onError() : Void
	{
	
	}

	function loadPublisherData(path:String) : Void
	{
		var ref = this;

		var _xml:XML = new XML();
		_xml.onLoad = function(success)
		{
			if (success)
			{
				ref.onLoadXml(this);
			} 
			else 
			{
				ref.onError();
			}
		}

		_xml.ignoreWhite = true;
		_xml.load(path);
	}
	
	// -----------
	function DataLoader() 
	{
		_event = new EventBroadcaster();
	}
};
