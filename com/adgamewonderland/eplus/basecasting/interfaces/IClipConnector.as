import com.adgamewonderland.eplus.basecasting.beans.VotableClip;

interface com.adgamewonderland.eplus.basecasting.interfaces.IClipConnector
{

	/**
	 *
	 *   Lädt den am höchsten bewerteten VotableClip einer Stadt
	 *   @param cityId ID der Stadt
	 *   @returns Gibt den am höchsten bewerteten VotableClip einer Stadt zurück
	 *
	 */
	function loadTopclip(aCityId:Number):Void;

	/**
	 *
	 *   Lädt die Highscoreliste der VotableClips für eine Stadt
	 *   @param cityId ID der Stadt
	 *   @param startat Startposition der Voide
	 *   @param count Anzahl der Einträge in der Voide
	 *   @returns Gibt die Highscoreliste der VotableClips für eine Stadt zurück
	 *
	 */
	function loadClipsByRank(aCityId:Number, aStartat:Number, aCount:Number):Void;

	/**
	 *
	 *   Lädt die VotableClips für eine Stadt zu einem Datum
	 *   @param cityId ID der Stadt
	 *   @param date Datum des Castings
	 *   @returns Gibt die VotableClips für eine Stadt zu einem Datum zurück
	 *
	 */
	function loadClipsByDate(aCityId:Number, aDate:Date):Void;

	/**
	 *
	 *   Lädt die VotableClips für ein Casting
	 *   @param castingId ID des Castings
	 *   @returns Gibt die VotableClips für ein Casting zurück
	 *
	 */
	function loadClipsByCasting(aCastingId:Number):Void;
}
