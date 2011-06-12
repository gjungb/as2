/**
 * @author gerd
 */

import de.kruesch.event.*;

import com.adgamewonderland.agw.math.*

import com.adgamewonderland.eplus.ayyildiz.videoplayer.beans.*;

import com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.*;

class com.adgamewonderland.eplus.ayyildiz.videoplayer.ui.SelectorUI extends MovieClip {
	
	private static var XUP:Number = 490;
	
	private static var YUP:Number = 0;
	
	private static var XDOWN:Number = 490;
	
	private static var YDOWN:Number = 425;
	
	private static var HITWIDTH:Number = 137;
	
	private static var HITHEIGHT:Number = 85;
	
	private static var SCROLLYDIFF:Number = 4;
	
	private static var YTARGET:Number = 170;
	
	private static var TSIZE:Number = 11;
	
	private static var TFONT:String = "Frutiger";
	
	private static var TCOLOR:Number = 0xFFFFFF;
	
	private static var TALIGN:String = "right";
	
	private static var TTIMEOUT:Number = 2000;
	
	private var hitup:Rectangle;
	
	private var hitdown:Rectangle;
	
	private var thumbs:Array;
	
	private var thumbs_mc:MovieClip;
	
	private var target:VideoItemUI;
	
	private var description_txt:TextField;
	
	private var interval:Number;
	
	private var active:Boolean;
	
	public function SelectorUI() {
	}
	
	public function onLoad():Void
	{
		// bugfix wg. tweening: nur einmal registrieren
		if (this._name == "selector_mc") VideoPlayer.getInstance().addListener(this);
		// hitarea oben
		this.hitup = new Rectangle(XUP, YUP, HITWIDTH, HITHEIGHT);
		// hitarea unten
		this.hitdown = new Rectangle(XDOWN, YDOWN, HITWIDTH, HITHEIGHT);
		// thumbs
		this.thumbs = new Array();
		// active
		this.active = true;
	}
	
	public function onItemsParsed(videoitems:Array ):Void
	{
		// videoitem
		var item:VideoItem;
		// thumb
		var thumb:VideoItemUI;
		// constructor
		var constructor:Object;
		// schleife ueber items
		for (var i:Number = 0; i < videoitems.length; i++) {
			// aktuelles item
			item = videoitems[i];
			// constructor
			constructor = {_x : 0, _y : i * (VideoItemUI.HEIGHT + VideoItemUI.YDIFF), _item : item};
			// thumb
			thumb = VideoItemUI(thumbs_mc.attachMovie("VideoItemUI", "thumb" + i + "_mc", i + 1, constructor));
			// regisitrieren
			thumb.addListener(this);
			// speichern
			this.thumbs.push(thumb);
		}
		// maske setzen
		showMask();
		// mausbewegung verfolgen fuer scrollen
		onEnterFrame = onEnterFrameMouse;
	}
	
	public function onEnterFrameMouse():Void
	{
		// abbrechen, wenn nicht aktiv
		if (!getActive()) return;
		// mausposition
		var pos:Point = new Point(this._xmouse, this._ymouse);
		// scrollen, wenn ueber hitarea
		if (getHitup().isPointInside(pos)) scrollThumbs(1);
		if (getHitdown().isPointInside(pos)) scrollThumbs(-1);
	}
	
	public function onChangeItem(item:VideoItem ):Void
	{
		// abbrechen, wenn nicht aktiv
		if (!getActive()) return;
		// aktueller thumb
		var thumb:VideoItemUI;
		// schleife ueber thumbs
		for (var i:String in thumbs) {
			// aktueller thumb
			thumb = this.thumbs[i];
			// abbrechen, wenn item uebereinstimmt
			if (item == thumb.getItem()) break;
		}
		// thumb, zu dem gescrollt werden soll
		this.target = thumb;
		// mausbewegung verfolgen fuer scrollen
		onEnterFrame = onEnterFrameScroll;
	}
	
	public function onEnterFrameScroll():Void
	{
		// abbrechen, wenn nicht aktiv
		if (!getActive()) return;
		// abstand zur zielposition
		var ydiff:Number = this.target._y - YTARGET;
		// abbrechen, wenn nah genug
		if (Math.abs(ydiff) <= SCROLLYDIFF) {
			// mausbewegung verfolgen fuer scrollen
			onEnterFrame = onEnterFrameMouse;
		} else {
			// richtung
			var direction:Number = -ydiff / Math.abs(ydiff);
			// scrollen
			scrollThumbs(direction);
		}
	}
	
	public function onThumbMouseMove(thumb:VideoItemUI ):Void
	{
		// abbrechen, wenn nicht aktiv
		if (!getActive()) return;
		// interval loeschen
		clearInterval(this.interval);
		// description
		var description:String = thumb.getItem().getDescriptionByLanguage(VideoPlayer.getInstance().getLanguage());
		// abbrechen, wenn leer
		if (description == "") {
			// textfeld loeschen
			hideDescription();
		} else {
			// textfeld erzeugen
			if (description_txt instanceof TextField == false) {
				// erzeugen
				_root.createTextField("description_txt", getNextHighestDepth(), 0, 0, 0, 0);
				
				description_txt = _root.description_txt;
				// auto breite
				description_txt.autoSize = TALIGN;
				// nicht auswaehlbar
				description_txt.selectable = false;
				// schriften einbetten
				description_txt.embedFonts = true;
				// rand
				description_txt.border = true;
				// hintergrund
				description_txt.background = true;
				// hintergrundfarbe
				description_txt.backgroundColor = TCOLOR;
			}
			// anzeigen
			description_txt.text = description;
			// formatierung
			var tf:TextFormat = new TextFormat();
			tf.size = TSIZE;
			tf.font = TFONT;
			tf.align = TALIGN;
			description_txt.setTextFormat(tf);
			// textfeld positionieren
			description_txt._x = _root._xmouse - description_txt._width;
			description_txt._y = _root._ymouse - description_txt._height / 2;
			
			// nach pause textfeld loeschen
			this.interval = setInterval(this, "hideDescription", TTIMEOUT);
		} 
	}
	
	public function onDownloadVideo(bool:Boolean ):Void
	{
		// de- / aktivieren	
		setActive(!bool);
	}
	
	private function hideDescription():Void
	{
		// interval loeschen
		clearInterval(this.interval);
		// textfeld loeschen
		description_txt.removeTextField();
	}
	
	private function scrollThumbs(direction:Number ):Void
	{
		// aktueller thumb
		var thumb:VideoItemUI;
		// schleife ueber thumbs
		for (var i:String in thumbs) {
			// aktueller thumb
			thumb = this.thumbs[i];
			// testen, ob unten raus
			if (thumb._y > (this.thumbs.length - 1) * (VideoItemUI.HEIGHT + VideoItemUI.YDIFF)) {
				// nach oben verschieben
				thumb._y -= ((VideoItemUI.HEIGHT + VideoItemUI.YDIFF) * this.thumbs.length);
			}
			// testen, ob oben raus
			if (thumb._y < -(VideoItemUI.HEIGHT + VideoItemUI.YDIFF)) {
				// nach unten verschieben
				thumb._y += ((VideoItemUI.HEIGHT + VideoItemUI.YDIFF) * this.thumbs.length);
			}
			// bewegen
			thumb._y += direction * SCROLLYDIFF;
		}
	}
	
	private function showMask():Void
	{
		// neues mc
		var mc:MovieClip = this.createEmptyMovieClip("mask_mc", getNextHighestDepth());
		// als maske setzen
		this.thumbs_mc.setMask(mc);
		// an startpunkt
		mc.moveTo(this.thumbs_mc._x, this.thumbs_mc._y);
		// fuellung
		mc.beginFill(0xCCCCCC, 50);
		// nach rechts
		mc.lineTo(this.thumbs_mc._x - 5 + VideoItemUI.WIDTH, this.thumbs_mc._y);
		// nach unten
		mc.lineTo(this.thumbs_mc._x - 5 + VideoItemUI.WIDTH, (VideoItemUI.HEIGHT + VideoItemUI.YDIFF) * this.thumbs.length);
		// nach links
		mc.lineTo(this.thumbs_mc._x - 5, (VideoItemUI.HEIGHT + VideoItemUI.YDIFF) * this.thumbs.length);
		// nach oben
		mc.lineTo(this.thumbs_mc._x - 5, this.thumbs_mc._y);
	}
	
	public function getHitup():Rectangle {
		return hitup;
	}

	public function setHitup(hitup:Rectangle):Void {
		this.hitup = hitup;
	}

	public function getHitdown():Rectangle {
		return hitdown;
	}

	public function setHitdown(hitdown:Rectangle):Void {
		this.hitdown = hitdown;
	}

	public function getActive():Boolean {
		return active;
	}

	public function setActive(active:Boolean):Void {
		this.active = active;
	}

}