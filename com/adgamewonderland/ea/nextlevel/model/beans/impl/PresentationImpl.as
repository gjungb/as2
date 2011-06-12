import com.adgamewonderland.ea.nextlevel.model.beans.impl.PlaylistImpl;
import com.adgamewonderland.ea.nextlevel.model.beans.Playlist;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistChapterItem;
import com.adgamewonderland.ea.nextlevel.model.beans.PlaylistVideoItem;
import com.adgamewonderland.ea.nextlevel.model.beans.Presentation;

/**
 * @author Harry
 */
class com.adgamewonderland.ea.nextlevel.model.beans.impl.PresentationImpl extends Presentation {

	public function PresentationImpl() {
		super();
	}

	/**
	 * Erstellt alle inneren Werte
	 */
	public function create(item) : Void {
		if (item instanceof Playlist || item instanceof PlaylistImpl) {
			var pList:Playlist = item;

			// Wenn es eine abgespeckte (individuelle) Playlist ist dann
			// wird hier alles erledigt.

			// Bei einer kompletten Presentation wird nur das Hauptmenü
			// erstellt

			setWarteLoop 	(pList.getWarteLoop());
			setTrailer		(pList.getTrailer());
			setTrailerLoop	(pList.getTrailerLoop());
			setUebergang	(pList.getUebergang());
			setMetainfo		(pList.getMetainfo());
			this.setWallpaper(
				pList.getPfadWallpaper() + pList.getWallpaper()
			);

			var items:Array = pList.toItemsArray();

			menue 		= new Array();
			videos 		= new Array();
			chapters	= new Array();

			for (var i:Number = 0;i < items.length;i++) {
				if (items[i] instanceof PlaylistChapterItem) {
					// Es werden nur Menüpunkte eingehängt
					var tCI:PlaylistChapterItem = items[i];
					menue.push(tCI.getMetainfo().getTitle());

					// Ein chapter wird gesondert erstellt
					var prChapt:PresentationImpl = new PresentationImpl();
					prChapt.create	(tCI);
					chapters.push	(prChapt);

					continue;
				}
				if (items[i] instanceof PlaylistVideoItem) {
					// Es werden Videos + Menüpunkte eingehängt
					var tCV:PlaylistVideoItem = items[i];
					addVideo(tCV);
					continue;
				}
			}
			return;
		}
		/**
		 * Chapter wird gesondert behandelt
		 */
		if (item instanceof PlaylistChapterItem) {
			menue 		= new Array();
			videos 		= new Array();
			chapters	= new Array();
			createItem (item);

			return;
		}
	}

	private function createItem(item) : Void {
		if (item instanceof PlaylistChapterItem) {
			addChapter (item);
			return;
		}

		if (item instanceof PlaylistVideoItem) {
			addVideo (item);
			return;
		}
	}

	private function addChapter (chapter:PlaylistChapterItem) : Void {
		setWarteLoop	(null);						// Kein Warteloop

		setTrailer		(chapter.getTrailer());		// evtl. ein Trailer
		setTrailerLoop	(chapter.getTrailerLoop());	// ein Loop
		setUebergang	(chapter.getUebergang());	// ein Übergang
		setMetainfo		(chapter.getMetainfo());
		setWallpaper	(chapter.getWallpaper());

		// Menü und items
		var videos:Array = chapter.toVideosArray();

		for (var i:Number = 0;i < videos.length;i++) {
			var temp:PlaylistVideoItem = videos[i];
			addVideo (temp);
		}
	}

	private function addVideo (item:PlaylistVideoItem) : Void {
		// Es werden Videos + Menüpunkte eingehängt
		if (item.getVideo().isActive() == true) {
			menue.push	(item.getVideo().getMetainfo().getTitle());
		}
		videos.push	(item);
	}
}