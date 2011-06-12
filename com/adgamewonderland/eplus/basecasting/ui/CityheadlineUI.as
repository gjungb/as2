﻿import com.adgamewonderland.eplus.basecasting.interfaces.ICityControllerListener;import com.adgamewonderland.eplus.basecasting.controllers.CityController;import com.adgamewonderland.eplus.basecasting.ui.HeadlineUI;import com.adgamewonderland.eplus.basecasting.beans.impl.CityImpl;import com.adgamewonderland.eplus.basecasting.controllers.CitiesController;import com.adgamewonderland.eplus.basecasting.beans.Casting;import com.adgamewonderland.agw.util.TimeFormater;/** * @author gerd */class com.adgamewonderland.eplus.basecasting.ui.CityheadlineUI extends MovieClip implements ICityControllerListener {	private var headline_mc:HeadlineUI;	private var headline_txt:TextField;	private var copy_txt:TextField;	private var line_mc:MovieClip;	function CityheadlineUI() {		// headline linksbuendig		headline_txt.autoSize = "left";	}	public function onLoad():Void	{		// als listener registrieren		CityController.getInstance().addListener(this);	}	public function onUnload():Void	{		// als listener deregistrieren		CityController.getInstance().removeListener(this);	}	public function onCityStateChanged(aState:String, aNewstate:String ):Void	{		// resetten		reset();		// aktuelle stadt		var city:CityImpl = CitiesController.getInstance().getCurrentcity();		// datum, bis zu dem gevotet werden darf		var lastdate:Date = city.getLastVotingdate();		// als ausgeschriebenes datum		var datestr:String = lastdate.getDate() + ". " + TimeFormater.getNameofMonth(lastdate);		// headline		var headline:String = "";		// copy-text		var copy:String = "";		// je nach state unterschiedliche texte		switch (aNewstate) {			case CityController.STATE_LATEST :				headline = "Redefreiheit für deine Stadt - Die neusten Stimmen der BASE Casting-Tour";				copy = "Schau dir hier die zehn neusten Clips der Casting-Tour an. Wie findest du sie? Jetzt gleich bewerten – nur noch bis zum 30. Oktober!";				break;			case CityController.STATE_HIGHSCORE :				headline = "Redefreiheit für deine Stadt - Die besten Beiträge";				copy = "Hier siehst du alle Clips, die eine Wertung erhalten haben. Ganz vorne: der beste. Dahinter: alle, die es noch werden können.\rWer wird der Gewinner der Casting-Tour sein? Gib noch bis zum 30. Oktober deine Stimme ab!";				break;			case CityController.STATE_SCHEDULE :				headline = "Redefreiheit für deine Stadt - Alle Termine in " + city.getName();				copy = "Alle deine Möglichkeiten, an der BASE Casting-Tour teilzunehmen. Einer nach dem anderen. Sag nicht, du hast keine Zeit ...";				break;			case CityController.STATE_ARCHIVE :				headline = "Redefreiheit für deine Stadt - Alle Stimmen der BASE Casting-Tour";				copy = "Hier sind sie: alle Stimmen der Stadt. Jeder, der etwas zu sagen hatte. In voller Länge mit Bild und Ton. Ist die Stimme der Stadt darunter? Wer ist dein Favorit?";				break;			default :				// alte headline				headline_mc.showHeadline(city.getID());		}		// anzeigen		showText(headline, copy);	}	private function reset():Void	{		// keine alte headline		headline_mc.showHeadline(0);		// kein text		showText("", "");	}	private function showText(aHeadline:String, aCopy:String ):Void	{		// headline		headline_txt.text = aHeadline;		// copy-text		copy_txt.text = aCopy;		// linie		if (aHeadline.length > 0) {			// einblenden			line_mc._visible = true;			// linie anzeigen			line_mc._x = headline_txt._x;			line_mc._width = headline_txt._width;		} else {			// ausblenden			line_mc._visible = false;		}	}	public function onCastingSelected(aCasting : Casting) : Void {	}}