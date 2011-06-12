/* Page
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Page
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		01.12.2003
zuletzt bearbeitet:	01.12.2003
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.agw.*;
import com.adgamewonderland.viewer.*;

class com.adgamewonderland.viewer.Page {

  // Attributes

  public var myProspectus:Prospectus;

  public var myNum:Number;

  public var myPics:String;

  public var myPicl:String;

  public var myPdf:String;

  public var myProducts:Array;

  // Operations

  public  function Page(prospectus:Prospectus , num:Number , pics:String , picl:String , pdf:String , products:Array ) {
	// referenz auf prospekt
	myProspectus = prospectus;
	// seitennummer
	myNum = num;
	// kleines bild
	myPics = pics;
	// grosses bild
	myPicl = picl;
	// pdf
	myPdf = pdf;
	// produkte
	myProducts = products;
  }

} /* end class Page */
