/* Playground** Generated from ArgoUML Model ** ActionScript 2 generator module provided by www.codealloy.com */ /*klasse:			Playgroundautor: 			gerd jungbluth, adgame-wonderlandemail:			gerd.jungbluth@adgame-wonderland.dekunde:			tomorrow-focuserstellung: 		24.07.2004zuletzt bearbeitet:	24.07.2004durch			gjstatus:			in bearbeitung*/import com.adgamewonderland.tomorrowfocus.olympia.*;class com.adgamewonderland.tomorrowfocus.olympia.Playground extends MovieClip {	// Attributes		private var myUser:User;		private var myInterval:Number;		// Operations		public  function Playground()	{		// user (mit leerer email)		myUser = new User("");				myInterval = Math.random();	}		public  function get interval():Number	{		return (myInterval);	}} /* end class Playground */