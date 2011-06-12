import com.adgamewonderland.eplus.basecasting.view.beans.Tellafriend;

interface com.adgamewonderland.eplus.basecasting.interfaces.ITellafriendConnector
{

	/**
	 *
	 *   Sendet eine Empfehlungs-E-Mail, in der die gesamte Website empfohlen wird.
	 *   Für diese E-Mail muss ein eigenes Template mit einem allgemeingülitgen Text existieren.
	 *   @returns Gibt zurück, ob die E-Mail erfolgreich versendet wurde
	 *
	 */
	function recommendWebsite(aTellafriend:Tellafriend ):Void;

	/**
	 *
	 *   Sendet eine Empfehlungs-E-Mail, in der eine Stadt empfohlen wird.
	 *   Für diese E-Mail muss für jede Stadt ein eigenes Template mit einem spezifischem Text existieren.
	 *   Die E-Mail muss einen Stadt-spezifischen Deeplink enthalten in der Form http://www.base-casting.de/berlin
	 *   @param cityId ID der Stadt in der Datenbank
	 *   @returns Gibt zurück, ob die E-Mail erfolgreich versendet wurde
	 *
	 */
	function recommendCity(aTellafriend:Tellafriend, aCityId:Number ):Void;

	/**
	 *
	 *   Sendet eine Empfehlungs-E-Mail, in der ein Clip empfohlen wird.
	 *   Für diese E-Mail muss ein eigenes Template mit einem allgemeingültigen Text existieren.
	 *   Die E-Mail muss einen Deeplink enthalten, über den dem Flash-Frontend die ID des Clips übergeben wird.
	 *   @param clipId ID des Clips in der Datenbank
	 *   @returns Gibt zurück, ob die E-Mail erfolgreich versendet wurde
	 *
	 */
	function recommendClip(aTellafriend:Tellafriend, aClipId:Number ):Void;
}
