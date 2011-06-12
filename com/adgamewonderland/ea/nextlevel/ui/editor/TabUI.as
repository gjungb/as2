import com.adgamewonderland.ea.nextlevel.controllers.ChapterController;
import com.adgamewonderland.ea.nextlevel.interfaces.IChapterControllerListener;
import com.adgamewonderland.ea.nextlevel.model.beans.impl.ChapterImpl;

class com.adgamewonderland.ea.nextlevel.ui.editor.TabUI extends MovieClip implements IChapterControllerListener
{
	public static var TITLE_NORMAL:Number = 0xFFFFFF;

	public static var TITLE_SELECTED:Number = 0xCC0000;

	private var _chapter:ChapterImpl;

	private var title_txt:TextField;

	public function TabUI()
	{
		// als listener fuer chapter registrieren
		ChapterController.getInstance().addListener(this);
		// title in tab anzeigen
		if (_chapter.getMetainfo().getTitle().length > 0)
			showTitle(_chapter.getMetainfo().getTitle());
		else
			showTitle("Bereich " + _chapter.getID());
	}

	public function onUnload():Void
	{
		// als listener deregistrieren
		ChapterController.getInstance().removeListener(this);
	}

	public function showTitle(title:String ):Void
	{
		// title anzeigen
		title_txt.text = title;
	}

	public function setTitleColor(color:Number ):Void
	{
		// title einfaerben
		title_txt.textColor = color;
	}

	public function onRelease():Void
	{
		// kapitel auswaehlen
		ChapterController.getInstance().selectChapter(_chapter);
	}

	public function onChapterSelected(chapter:ChapterImpl):Void
	{
		// title ein- / ausfaerben
		setTitleColor(_chapter.getID() == chapter.getID() ? TITLE_SELECTED : TITLE_NORMAL);
	}

}