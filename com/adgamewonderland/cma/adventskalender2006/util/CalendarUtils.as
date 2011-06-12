import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.util.*;

class com.adgamewonderland.cma.adventskalender2006.util.CalendarUtils 
{
	private static var LSO:String = "cma_adventskalender";

	/**
	 * übernimmt alle property-values in die übergebene Instanz
	 * @param instance Instanz, in die die Werte geschrieben werden sollen
	 * @param values property-values, die übernommen werden sollen
	 * @return Instanz	 */
	public static function getCastedInstance(instance:Object, values:Object):Object
	{
		// schleife ueber alle property-values
		for (var index:String in values) {
			// aktueller wert
			var value = values[index];
			// index mit grossbuchstaben beginnen
			index = index.charAt(0).toUpperCase() + index.substr(1);
			// function
			var func:Function = instance["set" + index];
			// wert uebergeben
			func.apply(instance, [value]);
		}
		// zurueck geben
		return instance;
	}

	/**
	 * Formt die vom Gewinnspiel-Backend gelieferte Frage mit Antworten in Beans um
	 * @param fid ID der Frage
	 * @param csv vom Gewinnspiel-Backend gelieferte Frage mit Antworten als CSV	 */
	public static function parseQuestion(fid:Number, csv:String):com.adgamewonderland.cma.adventskalender2006.beans.Question
	{
		// je zeile eine information
		var parsed1:Array = csv.split(String.fromCharCode(10));
		// neue frage
		var question:Question = new Question(fid, parsed1[0]);
		// drei antworten
		for (var i:Number = 1; i < parsed1.length; i++) {
			// csv auftrennen
			var parsed2:Array = parsed1[i].split(";");
			// neue antwort
			question.addAnswers(new Answer(parsed2[0], parsed2[1], parsed2[2] == "1"));
		}
		// zurueck geben
		return question;
	}

	/**
	 * Speichert die Daten des Spielers in einem Flash-Cookie
	 * @param user Spieler	 */
	public static function saveUserLocal(user:com.adgamewonderland.cma.adventskalender2006.beans.User):Void
	{
		// lso zum speichern / laden der userdaten
		var lso:SharedObject = SharedObject.getLocal(LSO);
		// user im lso speichern
		lso.data.user = user;
		// speichern
		lso.flush();
	}

	/**
	 * Lädt die Daten des Spielers aus einem Flash-Cookie
	 * @return user Spieler
	 */
	public static function loadUserLocal():com.adgamewonderland.cma.adventskalender2006.beans.User
	{
		// lso zum speichern / laden der userdaten
		var lso:SharedObject = SharedObject.getLocal(LSO);
		// user aus lso laden
		var userlocal:User = lso.data.user;
		// testen, ob vorhanden
		if (userlocal != null) {
			// casten
			userlocal = User(CalendarUtils.getCastedInstance(new User(), userlocal));
		} else {
			// neuer user
			userlocal = new User();	
		}
		// zurueck geben
		return userlocal;
	}
	
	/**
	 * Erzeugt eine Hitarea an der Position und in der Größe des übergebenen Textfelds oder MovieClips
	 * @param mc MovieClip, in dem die Hitarea erzeugt werden soll
	 * @param tf Textfeld oder MovieClip, an dessen Position die Hitarea erzeugt werden soll
	 * @return Referenz auf die erzeugte Hitarea	 */
	 public static function createHitarea(mc:MovieClip, obj:Object):MovieClip
	 {
	 	// x-position textfeld
	 	var xpos:Number = obj._x;
	 	// y-position textfeld
	 	var ypos:Number = obj._y;
		// breite textfeld
		var width:Number = obj._width;
		// hoehe textfeld
		var height:Number = obj._height;
	 	// neue hitarea
	 	var hitarea_mc:MovieClip = mc.createEmptyMovieClip("hitarea_mc", 2);
		// rechteck mit fuellung
		hitarea_mc.beginFill(0x000000, 0);
		// zeichnen
		hitarea_mc.moveTo(xpos, ypos);
		hitarea_mc.lineTo(xpos + width, ypos);
		hitarea_mc.lineTo(xpos + width, ypos + height);
		hitarea_mc.lineTo(xpos, ypos + height);
		hitarea_mc.lineTo(xpos, ypos);
	 	
	 	// zurueck geben
	 	return hitarea_mc;
	 }
}