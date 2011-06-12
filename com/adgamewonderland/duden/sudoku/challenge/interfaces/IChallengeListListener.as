import com.adgamewonderland.duden.sudoku.challenge.ui.ChallengeListItemUI;
/**
 * @author gerd
 */
interface com.adgamewonderland.duden.sudoku.challenge.interfaces.IChallengeListListener {

	public function onSelectItem(mc:ChallengeListItemUI ):Void;

	public function onRejectItem(mc:ChallengeListItemUI ):Void;

}