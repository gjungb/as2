/* Rectangle
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Rectangle
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			ksta
erstellung: 		15.09.2004
zuletzt bearbeitet:	15.09.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

class com.adgamewonderland.ksta.photoclick.Rectangle {

	// Attributes
	
	private var myPos:Point; // linke obere ecke
	
	private var myDims:Object; // dimensionen (width, height)
	
	private var myCorners:Array; // ecken (punkte)
	
	private var myFactors:Object = {x : [0, 1, 1, 0], y : [0, 0, 1, 1]}; // faktoren zur bestimmung der vier ecken
	
	private var myBorders:Array; // raender (linien)
	
	private var myCrossings:Object; // schnittlinien (x, y)
	
	private var myIntersections:Array; // zweidimensionales array der punkte, die die ecken der vierecke markieren, in die das rechteck segmentiert wird
	
	// Operations
	
	// rechteck mit linker oberer ecke, breite und hoehe
	public  function Rectangle(xpos:Number, ypos:Number, width:Number , height:Number )
	{
		// linke obere ecke
		myPos = new Point(xpos, ypos);
		// dimensionen
		myDims = {width : width, height : height};
		// ecken
		myCorners = [];
		// raender
		myBorders = [];
		// schnittlinien
		myCrossings = {x : [], y : []};
		// punkte, die die ecken der vierecke markieren, in die das rechteck segmentiert wird
		myIntersections = [[]];
		// schleife zur bestimmung der vier ecken
		for (var i:Number = 0; i < 4; i ++) {
			// aktuelle ecke
			var corner:Point = new Point(xpos + myFactors.x[i] * width, ypos + myFactors.y[i] * height);
			// speichern
			myCorners.push(corner);
		}
		// schleife zur erzeugung der vier raender
		for (var i:Number = 0; i < 4; i ++) {
			// ecke, an der randlinie startet
			var cstart:Point = myCorners[i];
			// ecke, an der randlinie endet
			var cend:Point = myCorners[(i + 1 < 4 ? i + 1 : 0)];
			// randlinie 
			var line:Line = addLine(cstart, cend);
			// hinzufuegen
			myBorders.push(line);
		}
	}
	
	// rechteck in vierecke unterteilen
	public function segmentRectangle(xseg:Number, yseg:Number, variance:Number)
	{
		// schnittpunkte leer initialisieren (erst zeilen, dann spalten)
		for (var i:Number = 0; i <= yseg; i ++) {
			// neue zeile
			myIntersections[i] = [];
			// spalten
			for (var j:Number = 0; j <= xseg; j ++) {
				// fuellen
				myIntersections[i][j] = null;
			}
		}
		// ecken als schnittpunkte aufnehmen
		addIntersection(0, 0, myCorners[0]);
		addIntersection(0, xseg, myCorners[1]);
		addIntersection(yseg, xseg, myCorners[2]);
		addIntersection(yseg, 0, myCorners[3]);
		// dimensionen
		var dims:Array = ["y", "x"];
		// linien, die die teilungspunkte verbinden
		var lines:Object = {x : [], y : []};
		// schleife ueber beide dimensionen
		for (var i:String in dims) {
			// aktuelle dimension
			var dim:String = dims[i];
			// in aktueller dimension teilen
			var coords:Array = segmentBorder(dim, eval(dim + "seg"), variance);
			// schleife ueber die teilungspunkte, um sie miteinander zu verbinden
			for (var k:Number = 0; k < coords.length / 2; k ++) {
				// erster punkt
				var cstart:Point = coords[k];
				// zweiter punkt
				var cend:Point = coords[k + coords.length / 2];
				// dimension, in der geteilt werden sollen
				switch (dim) {
					// horizontale raender
					case "x" :
						// teilungspunkte als schnittpunkte aufnehmen
						addIntersection(0, k + 1, cstart);
						addIntersection(yseg, k + 1, cend);
						
						break;
					// vertikale raender
					case "y" :
						// teilungspunkte als schnittpunkte aufnehmen
						addIntersection(k + 1, 0, cstart);
						addIntersection(k + 1, xseg, cend);
						
						break;
				}
				// verbindungslinie 
				var line:Line = addLine(cstart, cend);
				// speichern
				lines[dim].push(line);
			}
		}
		// schleife ueber horizontale verbindungslinien
		for (var l:Number = 0; l < lines.y.length; l ++) {
			// horizontale linie
			var hline:Line = lines.y[l];
			// schleife ueber vertikale linien
			for (var m:Number = 0; m < lines.x.length; m ++) {
				// vertikale linie
				var vline:Line = lines.x[m];
				// schnittpunkt der beiden linien
				var intersection:Point = Detector.getLineLineIntersection(hline, vline);
				// als schnittpunkt aufnehmen
				addIntersection(l + 1, m + 1, intersection);
			}
		}
	}
	
	// einzelne vierecke des rechtecks als movieclips bauen
	public function buildSegments(mc:MovieClip, name:String ):Array
	{
		// movieclips der vierecke
		var segments:Array = [];
		// aktuelle anzahl vierecke
		var numseg:Number = 0;
		// schleife ueber zeilen der schnittpunkte
		for (var i:Number = 0; i < myIntersections.length - 1; i ++) {
			// schleife ueber spalten der schnittpunkte
			for (var j:Number = 0; j < myIntersections[i].length - 1; j ++) {
				// hochzaehlen
				numseg ++;
				// neues viereck
				var segment:MovieClip = mc.createEmptyMovieClip(name + numseg + "_mc", numseg);
				// in array schreiben
				segments.push(segment);
				// linke obere ecke
				var cstart:Point = myIntersections[i][j];
				// zeichnen beginnen
				segment.moveTo(cstart.x, cstart.y);
				// fuellung
				segment.beginFill(0x000000, 30);
				// schleife zur bestimmung der vier ecken
				for (var k:Number = 0; k < 4; k ++) {
					// aktuelle ecke
					var corner:Point = myIntersections[i + myFactors.y[k]][j + myFactors.x[k]];
					// linie zeichnen
					segment.lineTo(corner.x, corner.y);
				}
				// viereck schliessen
				segment.lineTo(cstart.x, cstart.y);
				// fuellung schliessen
				segment.endFill();
			}
		}
		// movieclips der vierecke zurueck geben
		return (segments);
	}
	
	// linie hinzufuegen
	private function addLine(pstart:Point, pend:Point ):Line
	{
		// steigung
		var slope:Number = (pend.y - pstart.y) / (pend.x - pstart.x);
		// neue linie
		var line:Line = new Line(0, slope);
		// parallel verschieben, so dass sie am startpunkt beginnt
		line.moveToPoint(pstart);
		// in strecke teilen
// 		line.segmentLine(pstart.x, pend.x);
		// zeichnen
// 		line.drawLine(_root, 2, 0xCCDDDD, 100);
		// typ setzen
		line.setType("line");
		// zurueck geben
		return (line);
	}
	
	// randlinien in segmente teilen
	private function segmentBorder(dim:String, segments:Number, variance:Number ):Array
	{
		// minimaler und maximaler wert, zwischen dem geteilt wird
		var vmin:Object = {x : myPos.x, y : myPos.y}
		var vmax:Object = {x : myPos.x + myDims.width, y : myPos.y + myDims.height};
		// koordinaten der dimension, die nicht berechnet wird
		var vpos:Object = {x : [myPos.y, myPos.y + myDims.height], y : [myPos.x, myPos.x + myDims.width]};
		// aktueller wert beim teilen
		var vact:Number;
		// teilungspunkt
		var spos:Point;
		// koordinaten fuer die teilungspunkte
		var scoords:Array = [];
		// schleife ueber beide betroffenen raender
		for (var i:Number = 0; i < 2; i ++) {
			// schleife ueber anzahl an segmenten
			for (var j:Number = 1; j < segments; j ++) {
				// segmentieren
				vact = (vmax[dim] - vmin[dim]) / segments * j;
				// zufaellige verteilung
				vact *= 1 + (Math.random() - .5) * variance / 100;
				// dimension, in der geteilt werden sollen
				switch (dim) {
					// horizontale raender
					case "x" :
						// neuer punkt
						spos = new Point(vmin.x + Math.round(vact), vpos.x[i]);
						
						break;
					// vertikale raender
					case "y" :
						// neuer punkt
						spos = new Point(vpos.y[i], vmin.y + Math.round(vact));
						
						break;
				}
				// teilungspunkt speichern
				scoords.push(spos);
			}
		}
		// koordinaten zurueck geben
		return (scoords);
	}
	
	// schnittpunkt speichern
	private function addIntersection(row:Number, column:Number, pos:Point ):Void
	{
		// punkt aufnehmen
		myIntersections[row][column] = pos;
	}
	
} /* end class Rectangle */
