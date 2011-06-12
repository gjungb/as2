/* Grid
** Generated from ArgoUML Model 
** ActionScript 2 generator module provided by www.codealloy.com */

/*
klasse:			Flipper
autor: 			gerd jungbluth, adgame-wonderland
email:			gerd.jungbluth@adgame-wonderland.de
kunde:			agw
erstellung: 		05.02.2004
zuletzt bearbeitet:	29.03.2004
durch			gj
status:			in bearbeitung
*/

import com.adgamewonderland.collision.*

import com.adgamewonderland.pinball.*

class com.adgamewonderland.pinball.Grid{

	// Attributes

	public var myDimensions:Object;

	public var myCellnums:Object;

	public var myCellsizes:Object;

	public var myCells:Array;

	// Operations

	public  function Grid(width:Number , height:Number , rows:Number , columns:Number )
	{
		// dimensionen ueber alles
		myDimensions = {width : width, height : height};
		// anzahl der zellen
		myCellnums = {rows : rows, columns : columns};
		// groessen der einzelnen zellen
		myCellsizes = {};
		// berechnen aus dimensionen und anzahlen
		setCellsizes(width / columns, height / rows);

		// zellinhalte
		myCells = new Array();
		// alle zellen mit leerem array fuellen
		for (var i = 1; i <= rows; i ++) {
			// schleife ueber alle spalten
			for (var j = 1; j <= columns; j ++) {
				// nummer der zelle
				var cellnum:Number = getCellNum(i, j); // (i - 1) * myCellnums.columns + j;
				// fuellen
				myCells[cellnum] = {lines : new Array(), circles : new Array(), flippers : new Array(), obstacles : new Array()};
			}
		}
		
		// hilflinien zeichnen
// 		drawGrid();
	}

	private  function setCellsizes(width:Number , height:Number )
	{
		// groessen der einzelnen zellen
		myCellsizes.width = width;
		myCellsizes.height = height;
	}
	
	private  function drawGrid()
	{
		// hilflinie zeichnen
		var mc = _root.grid_mc;
		// schleife ueber alle zeilen
		for (var i = 1; i <= myCellnums.rows; i ++) {
			// stil
			mc.lineStyle(1, 0x33CCCC, 50);
			// zum anfang
			mc.moveTo(0, (i - 1) * myCellsizes.height);
			// linie bis zum ende zeichnen
			mc.lineTo(myDimensions.width, (i - 1) * myCellsizes.height);
			// schleife ueber alle spalten
			for (var j = 1; j <= myCellnums.columns; j ++) {
				// zum anfang
				mc.moveTo((j - 1) * myCellsizes.width, 0);
				// linie bis zum ende zeichnen
				mc.lineTo((j - 1) * myCellsizes.width, myDimensions.height);
			}
		}
	}

	private  function addCellContent(row:Number , column:Number , content )
	{
		// art des contents
		var ctype:String;
		// linie?
		if (content instanceof Line) ctype = "lines";
		// kreis?
		if (content instanceof Circle) ctype = "circles";
		// flipper?
		if (content instanceof Flipper) ctype = "flippers";
		// hindernis?
		if (content instanceof Obstacle) ctype = "obstacles";
		
		// nummer der zelle
		var cellnum:Number = getCellNum(row, column);
		// bisheriger content in dieser zelle
		var ccurr:Array = getCellContent({row : row, column : column}, ctype);
		// schleife ueber bisherigen content
		for (var i in ccurr) {
			// abbrechen, wenn dieser content bereits in der zelle vorhanden
			if (content == ccurr[i]) return;
		}
		// anhaenegen
		myCells[cellnum][ctype].push(content);
	}

	public  function addCellContentByPoint(point:Point , content )
	{
		// zelle
		var cell:Object = getCellByPoint(point);
		// hinzufuegen
		addCellContent(cell.row, cell.column, content);
	}

	public  function addLine(line:Line )
	{
		// linienenden
		var ends:Object = line.getEnds();
		// startzelle
		var cellstart:Object = getCellByPoint(ends["start"]);
		// zielzelle
		var cellend:Object = getCellByPoint(ends["end"]);

		// wenn startzeile groesser zielzeile, tauschen
		if (cellstart.row > cellend.row) {
			var tmp:Number = cellstart.row;
			cellstart.row = cellend.row;
			cellend.row = tmp;
		}
		// wenn startspalte groesser zielspalte, tauschen
		if (cellstart.column > cellend.column) {
			var tmp:Number = cellstart.column;
			cellstart.column = cellend.column;
			cellend.column = tmp;
		}

		// schleife ueber alle zeilen
		for (var i = cellstart.row; i <= cellend.row; i ++) {
			// schleife ueber alle spalten
			for (var j = cellstart.column; j <= cellend.column; j ++) {
				// linie speichern
				addCellContent(i, j, line);
			}
		}
	}
	
	public  function addCircle(circle:Circle )
	{
		// mittelpunkt
		var pos:Point = circle.getPosition();
		// radius
		var radius = circle.getRadius();
		
		// anzahl der schritte auf der x-achse
		var steps:Number = radius;
		// schrittweite auf der x-achse (von -1 bis 1)
		var diff:Number = 2 / (steps - 1);
		// schleife von -1 bis 1
		for (var i = -1; i <= 1; i += diff) {
			// x-position
			var xpos:Number = pos.x + i * radius;
			// y-position unterhalb der x-achse
			var ypos1:Number = pos.y + Math.cos(i * Math.PI / 2) * radius;
			// zelle unterhalb der x-achse
			var cell1:Object = getCellByPoint(new Point(xpos, ypos1));
			// kreis speichern
			addCellContent(cell1.row, cell1.column, circle);
			// y-position oberhalb der x-achse
			var ypos2:Number = pos.y - Math.cos(i * Math.PI / 2) * radius;
			// zelle oberhalb der x-achse
			var cell2:Object = getCellByPoint(new Point(xpos, ypos2));
			// kreis speichern
			addCellContent(cell2.row, cell2.column, circle);
		}
	}
	
	public  function addFlipper(mc:Flipper )
	{
		// grenzen auf der buehne
		var bounds:Object = mc.getBounds(_root);
		
		// links oben
		var cell1:Object = getCellByPoint(new Point(bounds.xMin, bounds.yMin));
		// rechts oben
		var cell2:Object = getCellByPoint(new Point(bounds.xMax, bounds.yMin));
		// links unten
		var cell3:Object = getCellByPoint(new Point(bounds.xMin, bounds.yMax));
		// rechts unten
		var cell4:Object = getCellByPoint(new Point(bounds.xMax, bounds.yMax));
		
		// flipper speichern
		addCellContent(cell1.row, cell1.column, mc);
		// flipper speichern, wenn rechts oben in anderer zelle liegt
		if (!(cell2.row == cell1.row && cell2.column == cell1.column)) addCellContent(cell2.row, cell2.column, mc);
		// flipper speichern, wenn links unten in anderer zelle liegt
		if (!(cell3.row == cell1.row && cell3.column == cell1.column) && !(cell3.row == cell2.row && cell3.column == cell2.column)) addCellContent(cell3.row, cell3.column, mc);
		// flipper speichern, wenn rechts unten in anderer zelle liegt
		if (!(cell4.row == cell1.row && cell4.column == cell1.column) && !(cell4.row == cell2.row && cell4.column == cell2.column) && !(cell4.row == cell3.row && cell4.column == cell3.column))  addCellContent(cell4.row, cell4.column, mc);
	
	}
	
	public  function addObstacle(mc:Obstacle )
	{
		// grenzen auf der buehne
		var bounds:Object = mc.getBounds(_root);
		// schritte
		var steps:Number = 4;
		// schleife ueber zeilen
		for (var i = 0; i <= steps; i ++) {
			// y-position
			var ypos = bounds.yMin + i / steps * (bounds.yMax - bounds.yMin);
			// schleife ueber spalten
			for (var j = 0; j <= steps; j ++) {
				// x-position
				var xpos = bounds.xMin + j / steps * (bounds.xMax - bounds.xMin);
				// zelle
				var cell:Object = getCellByPoint(new Point(xpos, ypos));
				// hindernis speichern
				addCellContent(cell.row, cell.column, mc);
			}
		}
	}
	
	private function getCellNum(row:Number, column:Number):Number
	{
		// nummer der zelle
		var cellnum:Number = (row - 1) * myCellnums.columns + column;
		// zurueck geben
		return (cellnum);
	}

	public  function getCellByPoint(point:Point ):Object
	{
		// zeile
		var row:Number = Math.ceil(point.y / myCellsizes.height);
		// spalte
		var column:Number = Math.ceil(point.x / myCellsizes.width);
		// zurueck geben
		return ({row : row, column : column});
	}

	private  function getCellContent(cell:Object , ctype:String ):Array
	{
		// nummer der zelle
		var cellnum:Number = getCellNum(cell.row, cell.column); // (cell.row - 1) * myCellnums.columns + cell.column;
		// zurueck geben
		return (myCells[cellnum][ctype]);
	}

	public  function getCellContentByPoint(point:Point ):Array
	{
		// zelle
		var cell:Object = getCellByPoint(point);
		// zurueck geben
		return (getCellContent(cell));
	}
	
	public  function getLines(cell:Object ):Array
	{
		// zurueck geben
		return (getCellContent(cell, "lines"));
	}
	
	public  function getCircles(cell:Object ):Array
	{
		// zurueck geben
		return (getCellContent(cell, "circles"));
	}
	
	public  function getFlippers(cell:Object ):Array
	{
		// zurueck geben
		return (getCellContent(cell, "flippers"));
	}
	
	public  function getObstacles(cell:Object ):Array
	{
		// zurueck geben
		return (getCellContent(cell, "obstacles"));
	}

	public  function getDimensions():Object
	{
		// zurueck geben
		return (myDimensions);

	}

} /* end class Grid */
