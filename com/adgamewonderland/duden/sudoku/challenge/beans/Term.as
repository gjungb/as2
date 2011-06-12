/**
 *
 * Lösungswort, das im Sudoku anstelle der Ziffern dargestellt wird. Ein Lösungswort besteht aus genau neun Buchstaben, wobei jeder Buchstabe genau einmal im Lösungswort vorkommt (z.B. denksport)
 */
class com.adgamewonderland.duden.sudoku.challenge.beans.Term
{
	private var ID:Number;
	/**
	 * neunstelliges Lösungswort in Kleinbuchstaben
	 */
	private var text:String;

	public function Term()
	{
//		this.ID = 0;
//		this.text = "Abdeckung";
		// fuer remoting registrieren
		Object.registerClass("com.adgamewonderland.duden.sudoku.challenge.beans.Term", Term);
	}

	public function setID(ID:Number):Void
	{
		this.ID = ID;
	}

	public function getID():Number
	{
		return this.ID;
	}

	public function setText(text:String):Void
	{
		this.text = text;
	}

	public function getText():String
	{
		return this.text.toUpperCase();
	}

	public function toString() : String {
		var str:String = "com.adgamewonderland.duden.sudoku.challenge.beans.Term\r";

		for (var i : String in this) {
			str += i + ": " + this[i] + "\r";
		}

		return str;
	}
}