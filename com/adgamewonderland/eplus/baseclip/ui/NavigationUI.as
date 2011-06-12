import com.adgamewonderland.eplus.baseclip.ui.MenuItemMainUI;
import com.adgamewonderland.eplus.baseclip.ui.ContentUI;
import com.adgamewonderland.eplus.baseclip.descriptors.NavigationDescriptor;
/*
klasse:			NavigationUI
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			eplus
erstellung: 		28.02.2005
zuletzt bearbeitet:	09.03.2005
durch			gj
status:			final
*/

class com.adgamewonderland.eplus.baseclip.ui.NavigationUI {

	private var myMainMenuItems:Object;

	private var myNumItems:Number;

	private var isDeepLink:Boolean;

	private var submenu_mc:MovieClip;

	public function NavigationUI()
	{
		// global ansprechbar
//		_global.Navigation = this;
		// hauptmenupunkte als assoziatives array
		myMainMenuItems = {};
		// anzahl registrierter hauptmenupunkte (registrieren sich, wenn sie an startposition angekommen sind)
		myNumItems = 0;
		// aktueller link ist deep-link
		isDeepLink = false;
	}

	/**
	 * gibt globale referenz auf dieses movieclip zurueck
	 */
	public static function getMovieClip():NavigationUI
	{
		return NavigationUI(_root.navigation_mc);
	}

	public function set deeplink(bool:Boolean ):Void
	{
		// aktueller link ist deep-link
		isDeepLink = bool;
	}

	public function get deeplink():Boolean
	{
		// aktueller link ist deep-link
		return isDeepLink;
	}

	public function registerMainMenuItem(path:Array, item:MenuItemMainUI ):Void
	{
		// speichern
		myMainMenuItems[path.join("")] = item;
	}

	public function onItemStart():Void
	{
		// content einblenden, wenn alle an startposition
		if (++myNumItems == NavigationDescriptor.NUMMENUMAIN) ContentUI.getMovieClip().initContent(true);
	}

	public function swapMenu(path:Array ):Void
	{
		// menuitem an uebergebenem pfad
		var item:MenuItemMainUI = myMainMenuItems[path[0]];
		// ggf. submenuitem fuer deep-linking
		if (path.length > 1) {
			// deep-link
			deeplink = true;
			// pfad an menuitem uebergeben
			item.subpath = path;
		} else {
			// kein deep-link
			deeplink = false;
		}
		// alle anderen menupunkte an einklappposition
		resetMenu(item);
		// an ausklappposition
		item.moveToActivated(true);
	}

	public function resetMenu(exclitem:MenuItemMainUI ):Void
	{
		// schleife ueber alle hauptmenupunkte
		for (var i:String in myMainMenuItems) {
			// aktuelles item
			var item:MenuItemMainUI = myMainMenuItems[i];
			// ueberspringen, wenn an uebergebenem pfad
			if (item === exclitem) continue;
			// an einklapposition
			item.moveToActivated(false);
		}
	}

	public function getSubmenu(item:MenuItemMainUI ):MovieClip
	{
		// numerische id fuer uebergebenes item
		var id:Number = 0;
		// schleife ueber alle bisher registrierten hauptmenupunkte
		for (var i:String in myMainMenuItems) {
			// id hochzaehlen
			id ++;
		}
		// neues movieclip fuer submenue erzeugen und zurueck geben
		return submenu_mc.createEmptyMovieClip("submenu" + id + "_mc", id);
	}

	public function showSitemap():Void
	{
		// content ausblenden
		ContentUI.getMovieClip().closeContent(false, false);
		// schleife ueber alle hauptmenupunkte
		for (var i:String in myMainMenuItems) {
			// aktuelles item
			var item:MenuItemMainUI = myMainMenuItems[i];
			// an sitemapposition
			item.moveToSitemap();
		}
	}
}