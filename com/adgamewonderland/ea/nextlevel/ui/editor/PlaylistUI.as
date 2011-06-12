import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.agw.util.ScrollbarUI;
import com.adgamewonderland.ea.nextlevel.controllers.DragController;
import com.adgamewonderland.ea.nextlevel.controllers.PlaylistController;
import com.adgamewonderland.ea.nextlevel.controllers.VideoController;
import com.adgamewonderland.ea.nextlevel.interfaces.IDraggable;
import com.adgamewonderland.ea.nextlevel.interfaces.IDroppable;
import com.adgamewonderland.ea.nextlevel.interfaces.IMenuControllerListener;
import com.adgamewonderland.ea.nextlevel.interfaces.IPlaylistControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.Metainfo;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Video;
import com.adgamewonderland.ea.nextlevel.ui.editor.DurationUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.PlaylistVideoUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.VideoUI;

import flash.geom.Point;
import flash.geom.Rectangle;
import com.adgamewonderland.ea.nextlevel.controllers.MenuController;
import com.adgamewonderland.agw.util.NewScrollbarUI;
import com.adgamewonderland.agw.util.interfaces.INewScrollbarListener;

class com.adgamewonderland.ea.nextlevel.ui.editor.PlaylistUI extends MovieClip implements IPlaylistControllerListener, IMenuControllerListener, IDroppable, INewScrollbarListener
{
	private static var LISTX:Number = 3;
	private static var LISTY:Number = 23;
	private static var VIDEOXDIFF:Number = 6;
	private static var VIDEOYDIFF:Number = 0;
	private static var COLOR_UNSAVED:Number = 0xFF0000;
	private static var COLOR_SAVED:Number = 0xEEEEEE;

	private var videouis	:Array;
	private var list_mc		:MovieClip;
	private var list_mc_offset_x : Number = 0;
	private var initial_width: Number;
	private var duration_mc	:DurationUI;
	private var pointer_mc	:MovieClip;
	private var playlist_hscroll_mc:NewScrollbarUI;


	private var title_txt:TextField;

	public function PlaylistUI()
	{
		// array mit videos auf buehne
		this.videouis = new Array();
		// als listener fuer playlist registrieren
		PlaylistController.getInstance().addListener(this);
		// als listener fuer menu registrieren
		MenuController.getInstance().addListener(this);
		// als ziel fuer draggen registrieren
		DragController.getInstance().addTarget(this);
	}

	public function onLoad():Void
	{
		// liste mit videos auf buehne
		list_mc = this.createEmptyMovieClip("list_mc", getNextHighestDepth());

		// positionieren
		list_mc._x = LISTX + list_mc_offset_x;
		list_mc._y = LISTY;

		// maske fuer liste der videos auf buehne
		var mask:Mask = new Mask(
			this,
			list_mc,
			new com.adgamewonderland.agw.math.Rectangle(
				LISTX, LISTY, this._width, this._height
			)
		);

		// maskieren
		mask.drawMask();

		// title linksbuendig
		title_txt.autoSize = "left";
		// zeiger ausblenden
		pointer_mc._visible = false;

		// Grundeinstellung für Scrollbar
		playlist_hscroll_mc.setMode(1);
		playlist_hscroll_mc.addListener(this);

		playlist_hscroll_mc.setParameter (0,1,1);
		playlist_hscroll_mc.calculateScrollPara();
		playlist_hscroll_mc.scrollPos1();
		playlist_hscroll_mc.updateThumb();
		playlist_hscroll_mc._visible = false;
		initial_width = this._width;
	}

	public function onUnload():Void
	{
		// playlist loeschen
		clearPlaylist();
		// als listener deregistrieren
		PlaylistController.getInstance().removeListener(this);
		// als listener deregistrieren
		MenuController.getInstance().removeListener(this);
		// als ziel fuer draggen deregistrieren
		DragController.getInstance().removeTarget(this);

		//
		playlist_hscroll_mc.removeListener(this);
	}

	public function onPlaylistChanged(playlist:PlaylistImpl):Void
	{
		// liste von buehne loeschen
		clearPlaylist();
		// liste neu erzeugen und positionieren
		showPlaylist(playlist);
		// im title als veraendert markieren
		title_txt.textColor = COLOR_UNSAVED;
	}

	public function onPlaylistitemAdded(item:PlaylistItem, itemcount:Number):Void
	{
		// Not yet implemented
	}

	public function onPlaylistitemRemoved(item:PlaylistItem, itemcount:Number):Void
	{
		// Not yet implemented
	}

	public function onVideoStarted(video:Video ):Void
	{
	}

	public function onPlaylistStarted(items:Array):Void
	{
	}

	public function getDropzone():Rectangle
	{
		// flaeche, auf der gedraggte mcs abgelegt werden koennen
		return new Rectangle(_x, _y, _width, _height);
	}

	public function onDoDrag(dragged:IDraggable, pos:Point ):Void
	{
		// abbrechen, wenn kein video am draggen
		if (dragged instanceof VideoUI == false)
			return;
		// pointer ein- / ausblenden
		showPointer(pos);
	}

	public function onStopDrag(dragged:IDraggable, pos:Point):Void
	{
		// abbrechen, wenn kein video abgelegt
		if (dragged instanceof VideoUI == false)
			return;
		// zeiger ausblenden
		pointer_mc._visible = false;

		// video
		var video:Video = VideoUI(dragged).getVideo();

		ssDebug.trace("onStopDrag: " + dragged);

		// position auf buehne relativ zu den anderen
		var index:Number = calculateIndex(pos);

		// video zur playlist hinzufuegen
		PlaylistController.getInstance().addVideo(video, index);
	}

	/**
	 * ermittelt den index, den ein video in der playlist haben soll anhand
	 * der position der bisherigen videos und des gedroppten videos
	 * @param pos punkt auf der buehne, an dem das video gedroppt wurde
	 * @return gibt den index zurueck, den ein video in der playlist haben soll
	 */
	private function calculateIndex(pos:Point ):Number
	{
		// gesuchter index
		var index:Number = 0;
		// aktuelles video
		var ui:VideoUI;
		// mittelpunkt des videos auf buehne
		var center:Point;
		// abstand zwischen dem mittelpunkt und dem punkt, an dem das neue video gedroppt wurde
		var distance:Number;
		// schleife ueber alle videos auf buehne
		for (var i:Number = 0; i < this.videouis.length; i++) {
			// video
			ui = this.videouis[i];
			// mittelpunkt
			center = new Point(
				ui._x + ui._width / 2 + list_mc_offset_x,	// Berücksichtige den Offset der Liste
				ui._y + ui._height / 2
			);
			// abstand
			distance = center.x - pos.x;

			// testen, ob abstand negativ (=> video liegt weiter links)
			if (distance < 0) {
				// index hochzahlen
				index ++;
			} else {
				// abbrechen
				break;
			}
		}
		// zurueck geben
		return index;
	}

	/**
	 * loescht die liste der videos von der buehne
	 */
	private function clearPlaylist():Void
	{
		// aktuelles video
		var ui:PlaylistVideoUI;
		// alle videos von buehne loeschen
		for (var i:String in this.videouis) {
			// aktuelles video
			ui = PlaylistVideoUI(this.videouis[i]);
			// als listener deregistrieren
			VideoController.getInstance().removeListener(ui);
			// loeschen
			ui.removeMovieClip();
		}
		// array mit videos leeren
		this.videouis = new Array();

		// Reset der Scrollbar
		playlist_hscroll_mc.setParameter (
			0,0,1);
		playlist_hscroll_mc.calculateScrollPara();
	}

	/**
	 * stellt die liste der videos auf der buehne dar
	 * @param playlist die anzuzeigende playlist
	 */
	private function showPlaylist(playlist:PlaylistImpl):Void
	{
		// merke die alte Position
		var oldThumb:Number = playlist_hscroll_mc.getCurrPos();

		// item auf buehne
		var ui:PlaylistVideoUI;
		// position des items auf buehne
		var pos:Point = new Point(0, 0);
		// alle items aus repository
		var items:Array = playlist.toItemsArray();
		// aktuelles item
		var item:PlaylistItem;;
		// schleife ueber alle items
		for (var i:Number = 0; i < items.length; i++) {
			// item
			item = items[i];

			// auf buehne bringen
			ui = addPlaylistitem(item, pos);
			pos.offset(PlaylistVideoUI.WIDTH + VIDEOXDIFF, 0);
		}

		// Konfiguriere Scrollbar
		if (this.videouis.length > 1)
			playlist_hscroll_mc.setParameter (0,this.videouis.length - 1,1);
		else
			playlist_hscroll_mc.setParameter (0,1,1);
		playlist_hscroll_mc.calculateScrollPara	();

		var breite:Number = (PlaylistVideoUI.WIDTH + VIDEOXDIFF) * this.videouis.length;
		if (breite > initial_width)
			playlist_hscroll_mc._visible = true;
		else {
			playlist_hscroll_mc._visible = false;
			oldThumb = 0;
		}

		if (oldThumb > playlist_hscroll_mc.getMaxPos())
			oldThumb = playlist_hscroll_mc.getMaxPos();
		playlist_hscroll_mc.setCurrPos	(oldThumb);
		afterScrollPosChanged (
			playlist_hscroll_mc,
			playlist_hscroll_mc.getCurrPos()
		);
		//

		ssDebug.trace(
			"Scrollbar -> " + playlist_hscroll_mc._visible +
			" Breite --> " + breite +
			" -- " + initial_width +
			" -- " + this.toString());

		// gesamtzeit anzeigen
		// title anzeigen

		duration_mc.showDuration(
			playlist.getTotalduration());
		title_txt.text = playlist.getMetainfo().getTitle();
	}

	/**
	 * fuegt ein movieclip fuer ein item hinzu
	 * @param item item, das auf der buehne angezeigt werden soll
	 */
	private function addPlaylistitem(item:PlaylistItem, pos:Point ):PlaylistVideoUI
	{
		// movieclip
		var ui:PlaylistVideoUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = pos.x;
		constructor._y = pos.y;
		// item
		constructor._item = item;
		// video
		constructor._video = PlaylistVideoItem(item).getVideo();

		// auf buehne
		ui = PlaylistVideoUI(list_mc.attachMovie(
				"PlaylistVideoUI",
				"video" + item.getID() + "_mc",
				list_mc.getNextHighestDepth(),
				constructor
			)
		);

		// hinzufuegen zu array mit videos auf buehne
		this.videouis.push(ui);
		return ui;
	}

	/**
	 * blendet den zeiger, an welcher position ein video eingefuegt wuerde ein / aus
	 * @param pos mausposition
	 */
	private function showPointer(pos:Point ):Void
	{
		// testen, ob innerhalb der erlaubten flaeche
		if (getDropzone().containsPoint(pos)) {

			// position auf buehne relativ zu den anderen
			var index:Number 		= calculateIndex(pos);
			pointer_mc._visible 	= true;
			pointer_mc.swapDepths(
				list_mc.getDepth() + 1);

			// zeiger positionieren
			pointer_mc._x = list_mc._x + index * (PlaylistVideoUI.WIDTH + VIDEOXDIFF) - (VIDEOXDIFF  / 2);

		} else {
			// zeiger ausblenden
			pointer_mc._visible = false;
		}
	}

	public function onPlaylistCreated() : Void {
	}

	public function onPlaylistOpened() : Void {
		// erstes item in der playlist
		var item:PlaylistVideoItem = PlaylistController.getInstance().getPlaylist().toItemsArray()[0];
		// zum abspielen mit pause beim ersten item uebergeben
		PlaylistController.getInstance().startPlaylist(item, -1);
	}

	public function onPlaylistSaved() : Void {
		// im title als gespeichert markieren
		title_txt.textColor = COLOR_SAVED;
	}

	public function onPlaylistSavedAs() : Void {
		// im title als gespeichert markieren
		title_txt.textColor = COLOR_SAVED;
	}

	public function onMetainfoEdit(metainfo : Metainfo, allowcancel : Boolean) : Void {
	}

	public function onMetainfoClosed() : Void {
	}

	public function onPresentationCompleteOpened() : Void {
	}

	public function onPresentationIndividualOpened() : Void {
	}

	public function onFireMenue() : Void {
	}

	// Scrollbar
	public function beforeScrollPosChanged(scroll : NewScrollbarUI, currPos : Number) : Void {
	}

	public function afterScrollPosChanged(scroll : NewScrollbarUI, currPos : Number) : Void {
		if (scroll._visible) {
			// positionieren der Liste
			list_mc_offset_x 	= scroll.getCurrPos() * (PlaylistVideoUI.WIDTH + VIDEOXDIFF) * -1;
			list_mc._x 			= LISTX + list_mc_offset_x;

			scroll.updateThumb();
		}
		else {
			list_mc_offset_x 	= 0;
			list_mc._x 			= LISTX + list_mc_offset_x;

			scroll.updateThumb();
		}
	}

}