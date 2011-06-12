/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.agw.util.TimelineFollower;

class com.adgamewonderland.sskddorf.mischpult.ui.ProductDetailsUI extends MovieClip {
	
	private var product:Produkt;
	
	private var back_btn:Button;
	
	private var details_btn:Button;
	
	private var order_btn:Button;
	
	private var blind_mc:MovieClip;
	
	private var details_mc:MovieClip;
	
	private var nameinfos_txt:TextField;
	
	private var kurzaussagen_txt:TextField;
	
	private var kurzinfos_txt:TextField;
	
	public function ProductDetailsUI() {
		// blind button initialisieren
		initBlind();
	}
	
	public function onProductChanged(product:Produkt ):Void
	{
		// produkt speichern
		setProduct(product);
		// blind button einblenden
		showBlind(true);
		// buttons ausblenden
		details_btn._visible = false;
		order_btn._visible = false;
		// nach pause text anzeigen
		var interval:Number;
		// funktion
		var doShow:Function = function(mc:MovieClip ):Void {
			// text anzeigen
			mc.showDetails();
			// interval loeschen
			clearInterval(interval);
		};
		// umschalten
		interval = setInterval(doShow, 200, this);
		// abspielen verfolgen
		var follower:TimelineFollower = new TimelineFollower(this, "showDetails");
		// abspielen verfolgen
		onEnterFrame = function() {
			follower.followTimeline();
		};
		// abspielen
		gotoAndPlay("frIn");
	}
	
	public function showDetails():Void
	{	
		// produktname
		nameinfos_txt = details_mc.nameinfos_txt;
		nameinfos_txt.autoSize = "left";
		nameinfos_txt.text = getProduct().getNameinfos();
		// kurzaussagen
		var kurzaussagen:String = formatKurzaussagen(getProduct().getKurzaussagen());
		kurzaussagen_txt = details_mc.kurzaussagen_txt;
		kurzaussagen_txt.autoSize = "left";
		kurzaussagen_txt._width = 400;
		kurzaussagen_txt.multiline = true;
		kurzaussagen_txt.html = true;
		kurzaussagen_txt.htmlText = "<b>" + kurzaussagen + "<br></b>";
		// kurzinfos
		kurzinfos_txt = details_mc.kurzinfos_txt;
		kurzinfos_txt._y = kurzaussagen_txt._y + kurzaussagen_txt._height;
		kurzinfos_txt.autoSize = "left";
		kurzinfos_txt._width = 400;
		kurzinfos_txt.multiline = true;
		kurzinfos_txt.text = getProduct().getKurzinfos();
		// button zurueck
		back_btn.onRelease = function():Void {
			this._parent.hideDetails();
		};
		// button details (auf website)
		details_btn.onRelease = function():Void {
			this._parent.openPopup();
		};
		// button abschliessen (auf website)
		order_btn.onRelease = function():Void {
			this._parent.openPopup();
		};
		
		// buttons ein / ausblenden je nach produkt
		details_btn._visible = !getProduct().getOnlineabschliessbar();
		order_btn._visible = getProduct().getOnlineabschliessbar();
	}
	
	public function hideDetails():Void
	{
		// ausblenden
		gotoAndStop(1);
		// blind button ausblenden
		showBlind(false);
	}
	
	public function openLink():Void
	{
		// path
		var path:String = getProduct().getPfad();
		// url
		var url:String = "http://www.sskduesseldorf.de/navigation/nav.php?pfad=" + path;
		// frame
		var frame:String = "navi";
		// oeffnen
		getURL(url, frame);
	}
	
	public function openPopup():Void
	{
		// url
		var url:String = "http://www.sskduesseldorf.de/mp/produkt" + (getProduct().getID() < 10 ? "0" : "") + getProduct().getID() + ".html";
		// javascript
		var js:String = "javascript:var win = window.open('" + url + "', 'details', 'width=558,height=430,left=100,top=100,status=yes');";
		// oeffnen
		getURL(js, "");
	}

	public function getProduct():Produkt {
		return product;
	}

	public function setProduct(product:Produkt):Void {
		this.product = product;
	}
	
	public function showBlind(bool:Boolean ):Void
	{
		// blind button ein- / ausblenden
		blind_mc._visible = bool;
	}
	
	private function initBlind():Void
	{
		// deaktivieren
		blind_mc._visible = false;
		// ohne mauszeiger
		blind_mc.useHandCursor = false;
	}
	
	private function formatKurzaussagen(kurzaussagen:String ):String
	{
		// als html liste
		var html:String = "";
		// zeilenumbrueche raus
		var items:Array = kurzaussagen.split("\r\n");
		// als liste
		for (var i : Number = 0; i < items.length; i++) {
			html = html + "<li>" + items[i] + "</li>";
		}
		// zurueck geben
		return html;
	}

}