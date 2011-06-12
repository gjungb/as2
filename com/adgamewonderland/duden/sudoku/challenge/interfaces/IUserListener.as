import com.adgamewonderland.duden.sudoku.challenge.beans.User;

interface com.adgamewonderland.duden.sudoku.challenge.interfaces.IUserListener {

	public function onUserLogin(user:User ):Void;

	public function onUserLogout(user:User ):Void;

	public function onUserUpdate(user:User ):Void;
}