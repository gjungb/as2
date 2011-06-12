import mx.utils.Collection;
import mx.utils.CollectionImpl;
import mx.utils.Iterator;

import com.adgamewonderland.agw.net.RemotingBeanCaster;
import com.adgamewonderland.eplus.basecasting.beans.Casting;
import com.adgamewonderland.eplus.basecasting.beans.City;
import com.adgamewonderland.eplus.basecasting.beans.impl.CastingImpl;
import com.adgamewonderland.eplus.basecasting.beans.VotableClip;
import com.adgamewonderland.eplus.basecasting.controllers.ApplicationController;

/**
 * @author gerd
 */
class com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl extends City {

	private var topclip:VotableClip;

	public function CityImpl() {
		super();
	}

	public static function parse(aObj:Object ):CityImpl
	{
		return CityImpl(RemotingBeanCaster.getCastedInstance(new CityImpl(), aObj));
	}

	public function parseCastings(aCastings:Collection ):Void
	{
		// aktuelles casting
		var casting:CastingImpl;
		// schleife ueber castings
		var iterator:Iterator = aCastings.getIterator();
		while (iterator.hasNext()) {
			// aktuelles casting
			casting = CastingImpl(iterator.next());
			// stadt des castings
			casting.setCity(this);
			// casting zur stadt
			addCasting(casting);
		}
	}

	public function getCastingTicker(showcity:Boolean ):String {
		// ticker text der stadt
		var ticker:String = "";
		// aktuelles casting
		var casting:CastingImpl;
		// aktuelles datum
		var date:Date = ApplicationController.getInstance().getDate();
		// schleife ueber castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// aktuelles casting
			casting = this.castings[i];
			// nur zukuenftige inkl. heute
			if (casting.getDate().getTime() < date.getTime() - 24 * 60 * 60 * 1000)
				continue;
			// ticker text des castings
			ticker += casting.getLocationTicker(showcity);
		}
		// zurueck geben
		return ticker;
	}

	public function getCountdown():Number
	{
		// tage bis zum ersten casting
		var days:Number = 0;
		// erstes casting
		var casting:CastingImpl = toCastingsArray()[0];
		// datum des castings
		var firstday:Date = casting.getDate();
		// aktuelles datum
		var today:Date = ApplicationController.getInstance().getDate();
		// differenz
		days = Math.floor((firstday.getTime() - today.getTime()) / 1000 / 60 / 60 / 24) + 1;
		// zurueck geben
		return days;
	}

	public function getCastingById(aId:Number ):CastingImpl
	{
		// gesuchtes casting
		var casting:CastingImpl = new CastingImpl();
		// schleife ueber castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// aktuelles casting
			casting = this.castings[i];
			// beenden, wenn id gefunden
			if (casting.getID() == aId)
				break;
		}
		// zurueck geben
		return casting;
	}

	public function getCastingsByDate(aDate:Date ):Collection
	{
		// liste der castings eines datums
		var castings:Collection = new CollectionImpl();
		// aktuelles casting
		var casting:CastingImpl;
		// schleife ueber castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// aktuelles casting
			casting = this.castings[i];
			// speichern, wenn datum korrekt
			if (casting.getDate() == aDate)
				castings.addItem(casting);
		}
		// zurueck geben
		return castings;
	}

	public function getCastingsFromLatestCasting():Array
	{
		// gesuchte castings (alle castings ab dem hoechstem datum, an dem es aktive castings gibt)
		var castings:Array = new Array();
		// aktuelles casting
		var casting:CastingImpl;
		// datum des castings
		var date:Date = new Date();
		// rueckwaertsschleife ueber castings
		for (var i : String in this.castings) {
			// aktuelles casting
			casting = this.castings[i];
			// datum des castings
			date = casting.getDate();
			// wenn inaktiv, in liste aufnehmen
			if (casting.isActive() == false)
				castings.push(casting);
			// wenn aktiv
			if (casting.isActive() == true) {
				// castings dieses tages
				var newest:Collection = getCastingsByDate(date);
				// hinzufuegen
				for (var j : Number = 0; j < newest.getLength(); j++) {
					castings.push(newest.getItemAt(j));
				}
				// beenden
				break;
			}
		}
		// nach datum aufsteigend
		castings.reverse();
		// zurueck geben
		return castings;
	}

	public function getLatestCasting(aDate:Date ):CastingImpl
	{
		// gesuchtes casting
		var casting:CastingImpl = new CastingImpl();
		// aktuelles casting
		var casting:CastingImpl;
		// rueckwaertsschleife ueber castings
		for (var i : String in this.castings) {
			// aktuelles casting
			casting = this.castings[i];
			// das zeitlich naechstliegende casting in der vergangenheit
			if (casting.getDate().getTime() < aDate.getTime())
				break;
		}
		// zurueck geben
		return casting;
	}

	public function hasActiveCastings():Boolean
	{
		// gibt es aktive castings
		var found:Boolean = false;
		// aktuelles casting
		var casting:CastingImpl;
		// schleife ueber castings
		for (var i:Number = 0; i < this.castings.length; i++) {
			// aktuelles casting
			casting = this.castings[i];
			// gefunden, wenn casting aktiv
			if (casting.isActive()) {
				// es gibt aktive castings
				found = true;
				// beenden
				break;
			}
		}
		// zurueck geben
		return found;
	}

	public function getCastingDates(aActive:Boolean ):Collection
	{
		// liste des datums
		var dates:Collection = new CollectionImpl();
		// aktuelles casting
		var casting:CastingImpl;
		// datum des castings
		var date:Date = new Date();
		// rueckwaerts-schleife ueber castings (=> neuestes datum zuerst)
		for (var i:String in this.castings) {
			// aktuelles casting
			casting = this.castings[i];
			// ueberspringen, wenn nur aktive gewuenscht aber nicht aktiv
			if (aActive && casting.isActive() == false)
				continue;
			// pruefen, ob neues datum
			if (casting.getDate().getTime() != date.getTime()) {
				// datum des castings
				date = casting.getDate();
				// datum speichern
				dates.addItem(date);
			}
		}
		// zurueck geben
		return dates;
	}

	public function getLastVotingdate():Date
	{
		// letztes aller castings dieser stadt
		var lastcasting:Casting = toCastingsArray()[toCastingsArray().length - 1];
		// datum des letzten aller castings dieser stadt
		var lastdate:Date = new Date(lastcasting.getDate().getTime());
		// tage bis zum folgenden freitag
		var days:Number = 5 - lastdate.getDay();
		// entsprechend verlaengern
		lastdate.setTime(lastdate.getTime() + days * 24 * 60 * 60 * 1000);
		// zurueck geben
		return lastdate;
	}

	public function equals(aCity:City ):Boolean
	{
		return this.getID() == aCity.getID();
	}

	public function setTopclip(aTopclip:VotableClip ):Void
	{
		this.topclip = aTopclip;
	}

	public function getTopclip():VotableClip
	{
		return this.topclip;
	}

	private function addCasting(aCasting:Casting ):Void
	{
		this.castings.push(aCasting);
	}

}