import com.adgamewonderland.eplus.ayyildiz.tarifrechner.*;

class com.adgamewonderland.eplus.ayyildiz.tarifrechner.TarifConfig
{
	public var baseFee:Number;
	public var minuteD:Number;
	public var minuteTR:Number;
	public var minuteEplus:Number;
	public var minuteMobile:Number;

	public var minuteTR_in:Number;
	public var minuteTR_out:Number;

	public var smsD:Number;
	public var smsTR:Number;
	public var smsEplus:Number;

	// Event Handling
	private var _event:EventBroadcaster;
	
	function addListener(o) : Void { _event.addListener(o); }
	function removeListener(o) : Void { _event.removeListener(o); }

	// Konstruktor
	function TarifConfig()
	{
		_event = new EventBroadcaster();
	}
	
	// XML geladen
	function onLoadXml(xml:XML) : Void
	{
		baseFee = parseFloat(XmlHelper.nodeByName("grundpreis",xml).firstChild.nodeValue);

		minuteD = parseFloat(XmlHelper.nodeByName("festnetz",xml).firstChild.nodeValue);
		minuteTR = parseFloat(XmlHelper.nodeByName("tuerkei",xml).firstChild.nodeValue);
		minuteEplus = parseFloat(XmlHelper.nodeByName("eplus",xml).firstChild.nodeValue);
		minuteMobile = parseFloat(XmlHelper.nodeByName("mobil",xml).firstChild.nodeValue);
		minuteTR_in = parseFloat(XmlHelper.nodeByName("tr_an",xml).firstChild.nodeValue);
		minuteTR_out = parseFloat(XmlHelper.nodeByName("tr_ab",xml).firstChild.nodeValue);

		smsD = parseFloat(XmlHelper.nodeByName("sms_d",xml).firstChild.nodeValue);
		smsTR = parseFloat(XmlHelper.nodeByName("sms_tr",xml).firstChild.nodeValue);
		smsEplus = parseFloat(XmlHelper.nodeByName("sms_eplus",xml).firstChild.nodeValue);

		if (isNaN(minuteD) || isNaN(minuteTR) || isNaN(minuteEplus) || isNaN(minuteMobile)
			|| isNaN(minuteTR_in) || isNaN(minuteTR_out) 
			|| isNaN(smsD) || isNaN(smsTR) || isNaN(smsEplus))
		{
			onError();
		}

		// ok
		_event.send("onTarifConfigLoaded",this);
	}

	// Fehler in XML
	function onError() : Void
	{
		_event.send("onTarifConfigError",this);
	}

	function loadXml(path:String) : Void
	{
		var ref = this;

		var _xml:XML = new XML();
		_xml.ignoreWhite = true;

		_xml.onLoad = function(success)
		{
			trace(this);
			if (success)
			{
				ref.onLoadXml(this);
			} 
			else 
			{
				ref.onError();
			}
		}
		_xml.load(path);
	}
}
