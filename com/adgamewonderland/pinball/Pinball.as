/* Pinball
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Pinball
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		02.02.2004
zuletzt bearbeitet:	25.04.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Pinball extends MovieClip{

	// Attributes

	static public var myLines:Array = [];

	static public var myCircles:Array = [];

	static public var myBall:Mover;

	static public var myPlayground:MovieClip;

	static public var myShooter:MovieClip;

	static public var myDisplay:Display;

	static public var myPlayers:Array;

	static public var myPlayer:Player;

	static public var myPlayerNum:Number;

	static public var myExtraBallsNum:Number;

	static public var myFlippers:Array = [];
	
	static public var myObstacles:Array = [];
	
	static public var myColliders:Array = [];
	
	static public var myContacters:Array = [];

	static public var myGrid:Grid;
	
	static public var myBallCell:Object;
	
	static public var myLevel:Number;

	// Operations

	// registrierung des mcs, auf dem die action stattfindet
	static public  function registerPlayground(mc:MovieClip )
	{
		// registrieren
		myPlayground = mc;
	}

	// spiel mit uebergebenen spielernamen starten
	static public  function startPinball(name1:String , name2:String )
	{
		// level initialisieren
		initLevel();
		// shooter
		myShooter = null;
		// anzahl baelle je spieler
		var balls:Number = 5;
		// spieler
		myPlayers = new Array();
		// neuen user fuer spieler 1 anlegen (name, punkte, baelle)
		myPlayers.push(new Player(name1, 0, balls));
		// ggf. neuen user fuer spieler 2 anlegen (name, punkte, baelle)
		if (name2 != "") myPlayers.push(new Player(name2, 0, balls));
		// nummer des aktuellen spielers
		myPlayerNum = 0;
		// aktueller spieler
		myPlayer = myPlayers[0];
		// zahl der extra-baelle
		myExtraBallsNum = 0;

		// zum spiel
		gotoAndStop("fr_game");
	}
	
	// spiel beenden
	static public  function stopPinball()
	{
		// spieler uebergeben
		_root.gameover_mc.showGameover(myPlayers);
	}
	
	// level reinigen (raster, linien, kreise, flipper, hindernisse)
	static public  function initLevel()
	{
		// raster
		myGrid = new Grid (420 , 350 , 3, 3);
		// flipper
		myFlippers = [];
	}

	// registrierung eines linien-mcs entgegennehmen und als Line-objekt speichern
	static public  function registerLine(mc:MovieClip, dir:Number )
	{
		// grenzen auf der buehne
		var bounds:Object = mc.getBounds(myPlayground);
		// steigung
		var slope:Number = (bounds.yMax - bounds.yMin) / (bounds.xMax - bounds.xMin) * dir;
		// wenn 1 pixel hoch, steigung auf 0
// 		if (Math.abs(bounds.yMax - bounds.yMin) == 0) slope = 0;
		// neue linie
		var line:Line = new Line(0, slope);
		// position
		var pos:Point = new Point(mc._x, mc._y);
		// parallel verschieben, so dass sie deckungsgleich mit dem mc ist
		line.moveToPoint(pos);
		// in strecke teilen
		line.segmentLine(bounds.xMin, bounds.xMax);
		// zeichnen
// 		line.drawLine(myPlayground, 2, 0xFFFFFF, 100);
		// typ setzen
		line.setType("line");
		// in raster schreiben
		myGrid.addLine(line);
		// mc loeschen
		mc.unloadMovie();
	}

	// registrierung eines circle-mcs entgegennehmen und als Circle-objekt speichern
	static public  function registerCircle(mc:MovieClip )
	{
		// position
		var pos:Object = {x : mc._x, y : mc._y};
		// in globale koordinaten
		mc._parent.localToGlobal(pos);
		// radius
		var radius:Number = mc._width / 2;
		// neuer kreis
		var circle:Circle = new Circle(pos.x, pos.y, radius);
		// in raster schreiben
		myGrid.addCircle(circle);
		// mc loeschen
		mc.unloadMovie();
	}

	// registrierung eines flipper-mcs entgegennehmen und in array speichern
	static public  function registerFlipper(mc:Flipper )
	{
		// in array schreiben
		myFlippers.push(mc);
		// in raster schreiben
		myGrid.addFlipper(mc);
		// aktivieren
		mc.setActive(true);
	}
	
	// registrierung von obstacle-mcs entgegennehmen  und in array speichern
	static public  function registerObstacle(mc:Obstacle )
	{
		// in raster schreiben
		myGrid.addObstacle(mc);
	}

	// registrierung des display-mcs entgegennehmen und spielerdaten anzeigen lassen
	static public  function registerDisplay(mc:Display )
	{
		// registrieren
		myDisplay = mc;
		// spielerdaten anzeigen lassen
		for (var i in myPlayers) {
			myDisplay.updatePlayer(i, myPlayers[i]);
		}
	}
	
	// registrierung des mcs, von dem der ball abgeschossen wird
	static public  function registerShooter(mc:MovieClip )
	{
		// abbrechen, wenn schon registriert
		if (mc == myShooter) return;
		// registrieren
		myShooter = mc;
		// aktivieren
		myShooter.setActive(true);
	}
	
	// ball an uebergebener position auf buehne bringen und als Circle-objekt speichern
	static public  function initBall(xpos:Number , ypos:Number )
	{
		// auf buehne
		var mc = myPlayground.attachMovie("ball", "ball_mc", 100);
		// positionieren
		mc._x = xpos;
		mc._y = ypos;
		// radius
		var radius:Number = mc._width / 2;
		// neuer circle
		myBall = new Mover(xpos, ypos, radius); // Circle
		// movieclip registrieren
		myBall.registerMovieclip(mc);
		// geschwindigkeit zunaechst 0
		myBall.setVelocity(0, 0);
		// beschleunigung zunaechst 0
		myBall.setAcceleration(new Vector(0, 0));
	}
	
	// spieler wechseln
	static public  function swapPlayer()
	{
		// sound abspielen
		_root.sound_mc.setSound("sballout", 1);
		// ball abziehen
		myPlayer.addBalls(-1);
		// display updaten
		myDisplay.updatePlayer(myPlayerNum, myPlayer);
		// je nach anzahl der spieler
		switch (myPlayers.length) {
			// ein spieler
			case 1:
				// testen, ob spieler alle baelle verspielt hat
				if (myPlayer.balls == 0) {
					// beenden
					stopPinball();
				} else {
					// shooter aktivieren
					myShooter.setActive(true);
				}
			
				break;
			// zwei spieler
			case 2:
				// testen, ob zweiter spieler alle baelle verspielt hat
				if (myPlayerNum == myPlayers.length - 1 && myPlayer.balls == 0) {
					// beenden
					stopPinball();
				} else {
					// shooter aktivieren
					myShooter.setActive(true);
					// nur wechseln, wenn keine extra baelle
					if (myExtraBallsNum == 0) {
						// spielernummer hochzaehlen
						if (++myPlayerNum == myPlayers.length) myPlayerNum = 0;
						// aktueller spieler
						myPlayer = myPlayers[myPlayerNum];
					} else {
						// extra-baelle runterzaehlen
						myExtraBallsNum--;
					}
				}
			
				break;
		}
		// display updaten
		myDisplay.updatePlayer(myPlayerNum, myPlayer);
	}
	
	// punkte fuer aktuellen spieler zaehlen
	static public  function countScore(score:Number)
	{
		// punkte ball geben
		myPlayer.addScore(score);
		// display updaten
		myDisplay.updatePlayer(myPlayerNum, myPlayer);
	}
	
	// extra ball an aktuellen spieler geben
	static public  function extraBall()
	{
		// zusaetzlichen ball geben
		myPlayer.addBalls(1);
		// display updaten
		myDisplay.updatePlayer(myPlayerNum, myPlayer);
		// extra-baelle hochzaehlen
		myExtraBallsNum++;
	}
	
	// level der uebergebenen nummer starten (wird vom shooter aufgerufen)
	static public  function startLevel(level:Number )
	{
		// level speichern
		myLevel = level;
		// anfangsgeschwindigkeit (je nach level)
		var startspeed = (level == 1 ? {x : -6 - 4 * Math.random(), y : 1 + Math.random()} : {x : 4 + 3 * Math.random(), y : -6 - 4 * Math.random()});
// 		var startspeed = {x : -1, y : 1};
		// anfangsbeschleunigung
		var startacc = {x : 0, y : 0};
		// ball starten
		startBall(startspeed.x, startacc.x, startspeed.y, startacc.y);
		// flipper aktivieren
		startFlippers();
		// regelmaessig updaten
		myPlayground.onEnterFrame = function () {
			updatePinball();
		}
	}
	
	// level stoppen
	static public  function stopLevel()
	{
		// ball stoppen
		stopBall();
		// ball von buehne loeschen
		myBall.unregisterMovieclip();
		// nicht weiter machen
		delete(myPlayground.onEnterFrame);
		// flipper nach unten
		stopFlippers();
	}
	
	// flipper aktivieren
	static public  function startFlippers()
	{
		// schleife ueber flipper
		for (var i in myFlippers) {
			// aktivieren
			myFlippers[i].setActive(true);
		}
	}
	
	// flipper nach unten stellen und deaktivieren
	static public  function stopFlippers()
	{
		// schleife ueber flipper
		for (var i in myFlippers) {
			// nach unten stellen
			myFlippers[i].setAngle(myFlippers[i].getNextAngle(false));
			// deaktivieren
			myFlippers[i].setActive(false);
		}
	}
	
	// level wechseln
	static public  function swapLevel()
	{
		// level reinigen
		initLevel();
		// je nach bisherigem level
		switch (myLevel) {
			// level 1 (von unten nach oben)
			case 1:
				// layout wechseln
				myPlayground.gotoAndStop(2);

				break;
			// level 2 (von oben nach unten)
			case 2:
				// layout wechseln
				myPlayground.gotoAndStop(1);
				// aktuelle position des balls
				var pos:Point = myBall.getPosition();
				// initialisieren
				initBall(pos.x, 35);
				// starten
				startLevel(1);
				
				break;
		}
	}

	// ball mit uebergebener geschwindigkeit und beschleunigung starten
	static public  function startBall(vx:Number , ax:Number , vy:Number , ay:Number )
	{
		// geschwindigkeit
		myBall.setVelocity(vx, vy);
		// beschleunigung
		myBall.setAcceleration(new Vector(ax, ay));
	}

	// ball stoppen
	static public  function stopBall()
	{
		// geschwindigkeit
		myBall.setVelocity(0, 0);
		// beschleunigung
		myBall.setAcceleration(new Vector(0, 0));
// 		delete(myPlayground.onEnterFrame);
	}

	static public  function updatePinball()
	{
		// hat der ball aktuell kontakt zu einer linie?
		var hasContact = (myBall.getContactNum() != 0);
		// falls kein kontakt
		if (!hasContact) {
			// beschleunigung durch gravitation
			myBall.setAcceleration(new Vector(0, 0.3));
		}
		// ball beschleunigen
		myBall.updateVelocity();

		// naechste position des balles
		var nextpos:Point = myBall.getNextPosition(1);
		// zelle, linien, kreise wg. bewegung auf neuesten stand bringen
		updateCell(nextpos);
		// flipper bewegen (abbrechen, wenn ball von flipper reflektiert)
		if (myFlippers[0].updateAngle(myBall, myPlayground) || myFlippers[1].updateAngle(myBall, myPlayground)) {
			return;
		}
		
		// flipper in zelle des balles
		var flippers:Array = myGrid.getFlippers(myBall.getCell());
		// linien und kreise der flipper beruecksichtigen
		if (flippers.length > 0) {
			// linien in flippern
			var flipperlines:Array = [];
			// kreise in flippern
			var flippercircles:Array = [];
			// schleife ueber alle flipper
			for (var i in flippers) {
				// linien im flipper holen
				flipperlines = flipperlines.concat(flippers[i].getLines(myPlayground, true));
				// kreise im flipper holen
				flippercircles = flippercircles.concat(flippers[i].getCircles(myPlayground));
			}
			// linien in flippern an linien anhaengen
			myLines = myLines.concat(flipperlines);
			// kreise in flippern an kreise anhaengen
			myCircles = myCircles.concat(flippercircles);
		}
		// kreise in obstacles
		var obstaclecircles:Array = [];
		// schleife ueber alle obstacles
		for (var i in myObstacles) {
			// kreise im obstacle holen
			obstaclecircles = obstaclecircles.concat(myObstacles[i].getCircles());
		}
		// kreise in obstacles an kreise anhaengen
		myCircles = myCircles.concat(obstaclecircles);
		// schleife ueber alle kreise
		for (var i in myCircles) {
			// tangenten beim zusammenstoss mit kreis
			var tangent:Line = Detector.getCircleCircleTangent(myBall,  myCircles[i]);
			// an linien anhaengen
			myLines.push(tangent);
			// kreis der linie bekannt machen
			tangent.setParent(myCircles[i]);
			
			// beruehrung von ball und kreis
			var inside:Boolean = Detector.checkCircleInCircle(myBall, myCircles[i]);
			// linie speichern
			if (inside) myContacters.push(tangent);
		}
		// schleife ueber alle linien
		for (var i in myLines) {
			// aktuelle linie
			var line:Line = myLines[i];
			// zeit bis zur kollision zwischen ball und linie
			var time:Number = Detector.timeToCircleLineCollision(myBall, line);
			// zusammenstoss zwischen ball und linie
			if ((time >= 0 && time < 1.1)) {
				// linie und deren zeit speichern
				myColliders.push({line : line, time : time, num : i});
			}
			// wird der ball die linie beruehren
			if (line.getType() != "circle") {
				// beruehrung von ball und linie
				var contact:Boolean = Detector.checkCircleLineContact(myBall, line);
				// linie speichern
				if (contact) myContacters.push(line);
				
			// wird der ball einen kreis beruehren
			} 
			/*else {
				// aktueller kreis
				var circle:Circle = line.getParent();
				// beruehrung von ball und kreis
				var inside:Boolean = Detector.checkCircleInCircle(myBall, circle);
				// linie speichern
				if (inside) myContacters.push(line);
			}*/
		}
		// tangenten loeschen
		if (myCircles.length > 0) myLines.splice(-myCircles.length);
		// kreise in obstacles wieder loeschen
		if (obstaclecircles.length > 0) myCircles.splice(-obstaclecircles.length);
		// kreise in flippern wieder loeschen
		if (flippercircles.length > 0) myCircles.splice(-flippercircles.length);
		// linien in flippern wieder loeschen
		if (flipperlines.length > 0) myLines.splice(-flipperlines.length);

		// linien, die weniger als 1 zeiteinheit entfernt liegen, nach zeit sortieren
		myColliders.sort(sortColliders);
		// ball ist kollidiert
		if (myColliders.length > 0) { 
// 			trace("kollisionen: " + myColliders.length);
			// schleife ueber alle linien
			for (var j = 0; j < 1; j ++) { // colliders.length
				// aktuelle linie
				var line:Line = myColliders[j].line;
				// position des zusammenstosses
				var collision:Point = Detector.getCircleLineIntersection(myBall, line);
				// position des balles
				var nextpos:Point = collision; 
				// ball positionieren
				myBall.setPosition(nextpos.x, nextpos.y);
				// ausfallswinkel setzen
				myBall.changeAngleOnCollision(line);

				// bei kollision mit flipper
				if (line.getType() == "flipper") {
					// beschleunigen
					myBall.changeSpeedOnCollision(0.9);
				} else if (line.getType() == "circle") {
					// beschleunigen
					myBall.changeSpeedOnCollision(0.70);
				} else {
					// verlangsamen
					myBall.changeSpeedOnCollision(0.70); // 0.80
				}
			}
			// array leeren
			myColliders.splice(0, myColliders.length);
		}
		// ball beruehrt linie
		else if (myContacters.length > 0) {
// 			trace("berührungen: " + myContacters.length);
// 			trace(Detector.getPointLineRelation(nextpos, myContacters[0]));
			// anzahl der kontakte hochzaehlen
			myBall.setContactNum(myBall.getContactNum() + 1);
			// winkel zwischen den beiden linien (bei nur einer: winkel mit sich selbst (=0))
			var angle:Number = Math.abs(Detector.getLineLineAngle(myContacters[0], myContacters[myContacters.length - 1])) / Math.PI * 180;
			// flacher winkel und ball oberhalb linie
			if ((angle < 30 || angle > 110)) { //  && Detector.getPointLineRelation(nextpos, myContacters[0]) == -1
// 				myBall.changeAngleOnContact(myContacters[0], myBall.getContactNum() == 1);
// 				trace(angle);
				// beim ersten kontakt
				if (myBall.getContactNum() == 1) {
					// ball parallel zur linie bewegen
					myBall.changeAngleOnContact(myContacters[0], true);
					// naechste position des balles
// 					var nextpos:Point = Detector.getCircleLineContact(myBall, myContacters[0]);
				}
				// naechste position des balles
				var nextpos:Point = Detector.getCircleLineContact(myBall, myContacters[0]);
			} else {
// 				trace(angle);
// 				myContacters[0].segmentLine(0, 300);
// 				myContacters[0].drawLine(_root.grid_mc, 2, 0xccccff, 20);
// 				myContacters[1].segmentLine(0, 300);
// 				myContacters[1].drawLine(_root.grid_mc, 2, 0xccccff, 20);
				// ball nicht weiter bewegen
				var nextpos:Point = myBall.getNextPosition(0);
				// ball stoppen
				stopBall();
				// kein kontakt mehr
				myBall.setContactNum(0);
			}
			// array leeren
			myContacters.splice(0, myContacters.length);

		} else {
			// kein kontakt mehr
			myBall.setContactNum(0);
		}

		// ball positionieren
		myBall.setPosition(nextpos.x, nextpos.y);
		//raster zelle des balles updaten
		myBall.setCell(myGrid.getCellByPoint(nextpos));
		// und auf buehne darstellen
		myBall.updateStage();
		// schleife ueber alle hindernisse
		for (var i in myObstacles) {
			// aktuelles hindernis
			var obstacle:Obstacle = myObstacles[i];
// 			trace(obstacle);
			// testen, ob kollision mit ball
			if (Detector.checkCircleObstacleCollision(myBall, obstacle)) {
				// callback aufrufen
				obstacle.onCollision(myBall);
			}
		}

		// testen, ob ball spielfeld verlassen hat
		if (nextpos.x < 0 || nextpos.x > myGrid.getDimensions().width || nextpos.y < 0 || nextpos.y > myGrid.getDimensions().height) {
			// ball stoppen
			stopLevel();
			// je nach level
			switch (myLevel) {
				// level 1 (unten raus)
				case 1:
					// spieler wechseln
					swapPlayer();

					break;
				// level 2 (von oben nach unten)
				case 2:
					// level wechseln
					swapLevel();

					break;
			}
		}
	}
	
	// zelle, linien, kreise wg. bewegung auf neuesten stand bringen
	static private  function updateCell(nextpos:Point )
	{
		// aktuelle raster zelle des balles
		var cellold:Object = myBall.getCell();
		// neue raster zelle des balles
		var cellnew:Object = myGrid.getCellByPoint(nextpos);
		// testen, ob seit dem letzen update die zelle gewechselt wurde
		var cellchanged:Boolean = (cellold.row != cellnew.row || cellold.column != cellnew.column);
		// zelle wurde gewechselt
		if (cellchanged) {
// 			trace("updateCell: " + cellold.row + " # " + cellnew.row + " # " + cellold.column+ " # " + cellnew.column);
			// neue zelle speichern
			myBall.setCell(cellnew);
			// linien in dieser zelle
			myLines = myGrid.getLines(cellnew);
			// kreise in dieser zelle
			myCircles = myGrid.getCircles(cellnew);
			// hindernisse in dieser zelle
			myObstacles = myGrid.getObstacles(cellnew);
		}
	}

	// sortierfunktion fuer linien, die weniger als 1 zeiteinheit entfernt liegen
	static private  function sortColliders(collider1:Object , collider2:Object ):Number
	{
		if (collider1.time < collider2.time) {
			return -1;
		} else if (collider1.time > collider2.time) {
			return 1;
		} else {
			return 0;
		}
	}

} /* end class Pinball */
