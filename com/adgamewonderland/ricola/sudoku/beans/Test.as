/**
 * @author gerd
 */
class com.adgamewonderland.ricola.sudoku.beans.Test {
	
	private var name:String;
	
	public function Test() {
		this.name = "Test";

		Object.registerClass("com.adgamewonderland.ricola.sudoku.beans.Test", Test);
		
	}
	
}