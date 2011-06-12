import mx.utils.Delegate;

import com.adgamewonderland.agw.util.Mask;
import com.adgamewonderland.agw.util.ScrollbarUI;
import com.adgamewonderland.ea.nextlevel.controllers.ChapterController;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.RepositoryImpl;
import com.adgamewonderland.ea.nextlevel.ui.editor.ChapterUI;
import com.adgamewonderland.ea.nextlevel.ui.editor.TabUI;
import com.adgamewonderland.ea.nextlevel.controllers.RepositoryController;

class com.adgamewonderland.ea.nextlevel.ui.editor.RepositoryUI extends MovieClip implements IChapterControllerListener
{
	private static var LISTX:Number = 0;
	private static var LISTY:Number = 21;
	private static var MASKWIDTH:Number = 0;
	private static var MASKHEIGHT:Number = 0;
	private var _tabcount:Number;
	private var repository:RepositoryImpl;
	private var tabuis:Array;
	private var chapteruis:Array;
	private var tabs_mc:MovieClip;
	private var chapters_mc:MovieClip;
	private var scrollbar_mc:ScrollbarUI;
	private var mask_mc:MovieClip;
	private var tabright_btn:Button;
	private var tableft_btn:Button;

	public function RepositoryUI()
	{
		// repository
		this.repository = new RepositoryImpl();
		// array mit tabs auf buehne
		this.tabuis = new Array();
		// array mit chaptern auf buehne
		this.chapteruis = new Array();
	}

	public function onLoad():Void
	{
		// als listener fuer chapter registrieren
		ChapterController.getInstance().addListener(this);
		// inititialisieren
		init();
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ChapterController.getInstance().removeListener(this);
	}

	public function init():Void
	{
		// repository
		this.repository = RepositoryController.getInstance().getRepository();
		ssDebug.trace(RepositoryController.getInstance().getRepository().debugTrace());

		// liste mit chaptern auf buehne
		chapters_mc = this.createEmptyMovieClip("chapters_mc", getNextHighestDepth());
		// positionieren
		chapters_mc._x = LISTX;
		chapters_mc._y = LISTY;
		// array mit chaptern auf buehne
		this.chapteruis = new Array();

		// liste mit tabs auf buehne
		tabs_mc = this.createEmptyMovieClip("tabs_mc", getNextHighestDepth());
		// array mit tabs auf buehne
		this.tabuis = new Array();

		// alle chapter aus repository
		var chapters:Array = getRepository().toChaptersArray();
		// aktuelles chapter
		var chapter:ChapterImpl;
		// chapter auf buehne
		var ui:ChapterUI;
		// schleife ueber alle chapter
		for (var i:String in chapters) {
			// chapter
			chapter = chapters[i];
			// tab auf buehne bringen
			addTab(chapter);
			// chapter auf buehne bringen
			addChapter(chapter);
		}

		// breite eines tabs
		var tabwidth = TabUI(this.tabuis[this.tabuis.length - 1])._width;
		// hoehe eines tabs
		var tabheight = TabUI(this.tabuis[this.tabuis.length - 1])._height;
		// maske fuer liste mit tabs auf buehne
		var mask:Mask = new Mask(this, tabs_mc, new com.adgamewonderland.agw.math.Rectangle(tabs_mc._x, tabs_mc._y, tabwidth * _tabcount + 1, tabheight + 1));
		// maskieren
		mask.drawMask();

		// button nach rechts scrollen
		tabright_btn.onRelease = Delegate.create(this, onTabRight);
		// button nach links scrollen
		tableft_btn.onRelease = Delegate.create(this, onTabLeft);

		// interval
		var interval:Number;
		// nach pause erstes chapter auswaehlen
		var doSelect:Function = function(chapter:ChapterImpl ):Void {
			// auswaehlen
			ChapterController.getInstance().selectChapter(chapter);
			// interval loeschen
			clearInterval(interval);
		};
		// nach pause auswaehlen
		interval = setInterval(doSelect, 25, getRepository().toChaptersArray()[0]);
	}

	public function reset():Void
	{
		// alle tabs von buehne loeschen
		for (var i:String in this.tabuis) {
			// loeschen
			TabUI(this.tabuis[i]).removeMovieClip();
		}
		// array mit tabs leeren
		this.tabuis.splice();
		// alle chapter von buehne loeschen
		for (var i:String in this.chapteruis) {
			// loeschen
			ChapterUI(this.chapteruis[i]).removeMovieClip();
		}
		// array mit chaptern leeren
		this.chapteruis.splice();
	}

	public function onChapterSelected(chapter:ChapterImpl):Void
	{
		// ganz nach vorne
		ChapterUI(this.chapteruis[chapter.getID()]).swapDepths(this.chapteruis.length + 1);
	}

	public function setRepository(repository:RepositoryImpl):Void
	{
		this.repository = repository;
	}

	public function getRepository():RepositoryImpl
	{
		return this.repository;
	}

	/**
	 * tab auf buehne verschieben
	 * @param xdiff verschiebung in x-richtung
	 * @param ydiff verschiebung in y-richtung
	 */
	public function moveTab(ui:TabUI, xdiff:Number, ydiff:Number):Void
	{
		// tab verschieben
		ui._x += xdiff;
		ui._y += ydiff;
	}

	/**
	 * fuegt ein movieclip fuer ein tab hinzu
	 * @param chapter chapter, fuer das der tab auf der buehne angezeigt werden soll
	 */
	private function addTab(chapter:ChapterImpl ):TabUI
	{
		// movieclip
		var ui:TabUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = 0;
		constructor._y = 0;
		// chapter
		constructor._chapter = chapter;
		// auf buehne
		ui = TabUI(tabs_mc.attachMovie("TabUI", "tab" + chapter.getID() + "_mc", tabs_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit tabs auf buehne
		this.tabuis[chapter.getID()] = ui;
		// tab des angezeigten chapters entsprechend positionieren
		moveTab(ui, (chapter.getID() - 1) * ui._width, 0);
		// zurueck geben
		return ui;
	}

	/**
	 * fuegt ein movieclip fuer ein chapter hinzu
	 * @param chapter chapter, das auf der buehne angezeigt werden soll
	 */
	private function addChapter(chapter:ChapterImpl ):ChapterUI
	{
		// movieclip
		var ui:ChapterUI;
		// konstruktor
		var constructor:Object = new Object();
		// position
		constructor._x = 0;
		constructor._y = 0;
		// chapter
		constructor._chapter = chapter;
		// auf buehne
		ui = ChapterUI(chapters_mc.attachMovie("ChapterUI", "chapter" + chapter.getID() + "_mc", chapters_mc.getNextHighestDepth(), constructor));
		// hinzufuegen zu array mit chaptern auf buehne
		this.chapteruis[chapter.getID()] = ui;
		// zurueck geben
		return ui;
	}

	private function onTabRight():Void
	{
		// anzahl tabs (chapter)
		var numtabs:Number = getRepository().toChaptersArray().length;
		// erster tab
		var ui:TabUI = TabUI(this.tabuis[1]);
		// tabs duerfen nach links bewegt werden, wenn erster tab noch nicht am linken anschlag
		if ((_tabcount - numtabs) * ui._width < ui._x) {
			// tabs nach links bewegen
			for (var i:String in tabuis) {
				moveTab(TabUI(this.tabuis[i]), -ui._width, 0);
			}
			// entgegengesetzen button aktivieren
			tableft_btn.enabled = true;

		} else {
			// button deaktivieren
			tabright_btn.enabled = false;
		}
	}

	private function onTabLeft():Void
	{
		// anzahl tabs (chapter)
		var numtabs:Number = getRepository().toChaptersArray().length;
		// erster tab
		var ui:TabUI = TabUI(this.tabuis[1]);
		// tabs duerfen nach rechts bewegt werden, wenn erster tab noch nicht am rechten anschlag
		if (ui._x < 0) {
			// tabs nach rechts bewegen
			for (var i:String in tabuis) {
				moveTab(TabUI(this.tabuis[i]), ui._width, 0);
			}
			// entgegengesetzen button aktivieren
			tabright_btn.enabled = true;

		} else {
			// button deaktivieren
			tableft_btn.enabled = false;
		}

	}

}