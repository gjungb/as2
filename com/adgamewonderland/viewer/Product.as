/* Product
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */ 

/*
klasse:			Product
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

class com.adgamewonderland.viewer.Product{

  // Attributes

  public var myId:String;

  public var myPos:Object;

  public var myPage:Page;

  // Operations

  public  function Product(page:Page , id:String , pos:Object ) {
	// referenz auf seite
	myPage = page;
	// produkt id
	myId = id;
	// position auf seite (in prozent)
	myPos = pos;
  }

  public  function getId():String {
	// zurueck geben
	return(myId);
  }

  public  function getPos():Object {
	// zurueck geben
	return(myPos);
  }

} /* end class Product */
