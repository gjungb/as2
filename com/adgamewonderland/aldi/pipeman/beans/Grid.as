/**
 * @author gerd
 */

import com.adgamewonderland.aldi.pipeman.beans.Cell;
import com.adgamewonderland.aldi.pipeman.beans.Exit;
import com.adgamewonderland.aldi.pipeman.beans.Level;
import com.adgamewonderland.aldi.pipeman.beans.Pipe;
import com.adgamewonderland.aldi.pipeman.beans.Supply;

import de.kruesch.event.EventBroadcaster;

class com.adgamewonderland.aldi.pipeman.beans.Grid {

//	private static var CELLSTART:Object = {row : 13, column : 20, entry : Exit.TYPE_RIGHT, id : 1};
//
//	private static var CELLEND:Object = {row : 4, column : -1, entry : Exit.TYPE_RIGHT, id : 1};

	private static var CELLSTART:Object = {row : 11, column : 16, entry : Exit.TYPE_RIGHT, id : 1}; // KSTA

	private static var CELLEND:Object = {row : 7, column : -1, entry : Exit.TYPE_RIGHT, id : 1}; // KSTA

	private static var CELLINTERVAL:Number = 400;

	private static var _instance:Grid;

	private var rows:Number;

	private var columns:Number;

	private var cells:Array;

	private var pipes:Array;

	private var flowcell:Cell;

	private var interval:Number;

	private var cellstart:Cell;

	private var cellend:Cell;

	private var _event:EventBroadcaster;

	public static function getInstance():Grid {
		if (_instance == null)
			_instance = new Grid();
		return _instance;
	}

	public function initGrid(level:Level ):Void
	{
		// anzahl zeilen
		setRows(level.getRows());
		// anzahl spalten
		setColumns(level.getColumns());
		// zelle
		var cell:Cell;
		// schleife ueber zeilen
		for (var i:Number = 0; i < getRows(); i++) {
			// array zur aufnahme der spalten einer zeile
			var row:Array = new Array();
			// schleife ueber spalten
			for (var j:Number = 0; j < getColumns(); j++) {
				// neue zelle
				cell = new Cell();
				// fortlaufende id
				cell.setId(i * level.getColumns() + j);
				// zeile
				cell.setRow(i);
				// spalte
				cell.setColumn(j);
				// in zeile speichern
				row.push(cell);
			}
			// zeile speichern
			this.cells.push(row);
		}
		// startzelle
		this.cellstart.setRow(CELLSTART.row);
		this.cellstart.setColumn(CELLSTART.column);
		this.cellstart.setPipe(new Pipe(CELLSTART.id, Pipe.TYPE_PIPE));
		this.cellstart.getPipe().setExits(Supply.getInstance().getPipe(CELLSTART.id).getExits());
		this.cellstart.getPipe().setEntry(Exit.getExit(CELLSTART.entry));
		// zielzelle
		this.cellend.setRow(CELLEND.row);
		this.cellend.setColumn(CELLEND.column);
		this.cellend.setPipe(new Pipe(CELLEND.id, Pipe.TYPE_PIPE));
		this.cellend.getPipe().setExits(Supply.getInstance().getPipe(CELLEND.id).getExits());
		this.cellend.getPipe().setEntry(Exit.getExit(CELLEND.entry));

		// event
		_event.send("onInitGrid", this);

		// blockierte zellen
		if (level.getCellsblocked() > 0) initBlocked(level.getCellsblocked());
	}

	public function addListener(l ):Void
	{
		_event.addListener(l);
	}

	public function removeListener(l ):Void
	{
		_event.removeListener(l);
	}

	public function getCell(row:Number, column:Number ):Cell
	{
		// zelle
		var cell:Cell;
		// pruefen, ob zielzelle
		if (row == CELLEND.row && column == CELLEND.column) return cellend;
		// pruefen ob innerhalb grenzen
		if (row < 0 || row >= getRows()) return null;
		if (column < 0 || column >= getColumns()) return null;
		// entsprechende zelle
		cell = this.cells[row][column];
		// zurueck geben
		return cell;
	}

	public function addPipeToCell(cell:Cell ):Void
	{
		// aktuell zur verfuegung stehende pipe
		var pipe:Pipe = Supply.getInstance().getFirst();
		// pipe oder bomb
		if (pipe.getType() != Pipe.TYPE_BOMB) {
			// pipe speichern
			cell.setPipe(pipe);
			// nicht mehr editierbar
			cell.setEditable(false);
			// sound
			_root.mcSound.setSound("pipe", 1);

		} else {
			// pipe loeschen
			cell.removePipe();
			// editierbar
			cell.setEditable(true);
			// sound
			_root.mcSound.setSound("bomb", 1);
		}
		// supply updaten
		Supply.getInstance().removeFirst();

		// event
		_event.send("onUpdateGrid", cell);
	}

	public function startFlow():Void
	{
		// startzelle
		setFlowcell(this.cellstart);
		// event
		_event.send("onFlowStarted");
		// nach pause naechste pruefen
		this.interval = setInterval(this, "updateFlow", CELLINTERVAL);
	}

	public function updateFlow():Void
	{
		// aktuelle zelle
		var cell:Cell = getFlowcell();
		// testen, ob fliessen moeglich
		if (checkFlow(cell)) {
			// speichern, dass durchflossen
			cell.setFlow(true);
			// naechste zelle
			setFlowcell(getNextCell(cell));
			// pruefen, on zielzelle erreicht
			if(getFlowcell() == cellend) {
				// flow mit erfolg beenden
				stopFlow(true);
			}
			// sound
			_root.mcSound.setSound("flow", 1);

		} else {
			// flow ohne erfolg beenden
			stopFlow(false);
		}
		// event
		_event.send("onFlowUpdated", cell);
	}

	public function stopFlow(success:Boolean ):Void
	{
		// interval loeschen
		clearInterval(this.interval);

		// nach pause event
		var pause:Number;
		// funktion
		var doStop:Function = function(_event:EventBroadcaster ):Void {
			// event
			_event.send("onFlowStopped", success);
			// interval loeschen
			clearInterval(pause);
		};
		// umschalten
		pause = setInterval(doStop, CELLINTERVAL, _event);
	}

	public function getNumUnusedPipes():Number
	{
		// anzahl pipes, die nicht durchflossen wurden (DEBUG: -1, weil event onFlowStopped zu frueh)
		var numpipes:Number = -1;
		// aktuelle zelle
		var cell:Cell;
		// schleife ueber zeilen
		for (var i:Number = 0; i < getRows(); i++) {
			// schleife ueber spalten
			for (var j:Number = 0; j < getColumns(); j++) {
				// aktuelle zelle
				cell = getCell(i, j);
				// testen, ob durchflossen
				if (cell.hasPipe()) {
					// zaehlen
					numpipes += (cell.getFlow() ? 0 : 1);
				}
			}
		}
		// zurueck geben
		return numpipes;
	}

	public function resetGrid():Void
	{
		this.rows = 0;
		this.columns = 0;
		this.cells = new Array();
		this.pipes = new Array();
		this.flowcell = null;
		this.interval = 0;
		this.cellstart = new Cell();
		this.cellend = new Cell();
		// event
		_event.send("onResetGrid", this);
	}

	private function Grid() {
		this.rows = 0;
		this.columns = 0;
		this.cells = new Array();
		this.pipes = new Array();
		this.flowcell = null;
		this.interval = 0;
		this.cellstart = new Cell();
		this.cellend = new Cell();
		_event = new EventBroadcaster();
	}

	private function initBlocked(numblocked:Number ):Void
	{
		// konnte block positioniert werden
		var positioned:Boolean;
		// zeile
		var row:Number;
		// spalte
		var column:Number;
		// zelle
		var cell:Cell;
		// pipe
		var pipe:Pipe;
		// schleife ueber zu blockierende
		for (var i:Number = 0; i < numblocked; i++) {
			// konnte block positioniert werden
			positioned = false;
			// versuchen zu positioneren
			do {
				// zeile
				row = getRows() / 4 + Math.floor(Math.random() * getRows() / 2);
				// spalte
				column = getColumns() / 4 + Math.floor(Math.random() * getColumns() / 2);
				// zelle
				cell = getCell(row, column);
				// testen, ob noch frei
				if (!cell.hasPipe() && !cell.getBlocked()) {
					// neue pipe
					pipe = new Pipe(Pipe.ID_BLOCKED, Pipe.TYPE_PIPE);
					// pipe speichern
					cell.setPipe(pipe);
					// nicht mehr editierbar
					cell.setEditable(false);
					// blockiert
					cell.setBlocked(true);
					// erfolgreich
					positioned = true;
					// event
					_event.send("onUpdateGrid", cell);
				}

			} while (positioned = false);
		}
	}

	private function checkFlow(cell:Cell ):Boolean
	{
		// fliessen moeglich oder nicht
		var possible:Boolean = false;
		// naechste zelle in fliessrichtung
		var nextcell:Cell = getNextCell(cell);
		// pipe der naechsten zelle
		var pipe:Pipe;
		// exit der uebergebenen zelle
		var exit:Exit = cell.getPipe().getExit();
		// entry der naechsten zelle
		var entry:Exit = Exit.getOppositeExit(exit);
		// testen, ob naechste zelle in fliessrichtung vorhanden
		if (nextcell != null) {
			// testen, ob pipe vorhanden
			if (nextcell.hasPipe()) {
				// pipe der naechsten zelle
				pipe = nextcell.getPipe();
				// testen, ob entry vorhanden
				if (pipe.hasExit(entry.getType())) {
					// entry speichern
					pipe.setEntry(entry);
					// fliessen moeglich
					possible = true;
				}
			}
		}
		// zurueck geben
		return possible;
	}

	private function getNextCell(cell:Cell ):Cell
	{
		// zelle, die in richtung des exits der uebergebenen zelle liegt
		var nextcell:Cell = null;
		// pruefen, ob pipe
		if (cell.hasPipe()) {
			// exit der pipe der uebergebenen zelle
			var exit:Exit = cell.getPipe().getExit();
			// zeile der naechsten zelle
			var nextrow:Number = cell.getRow() + exit.getRow();
			// spalte der naechsten zelle
			var nextcolumn:Number = cell.getColumn() + exit.getColumn();
			// entsprechende zelle
			nextcell = getCell(nextrow, nextcolumn);
		}
		// zurueck geben
		return nextcell;
	}

	public function getCells():Array {
		return cells;
	}

	public function setCells(cells:Array):Void {
		this.cells = cells;
	}

	public function getPipes():Array {
		return pipes;
	}

	public function setPipes(pipes:Array):Void {
		this.pipes = pipes;
	}

	public function getRows():Number {
		return rows;
	}

	public function setRows(rows:Number):Void {
		this.rows = rows;
	}

	public function getColumns():Number {
		return columns;
	}

	public function setColumns(columns:Number):Void {
		this.columns = columns;
	}

	public function getFlowcell():Cell {
		return flowcell;
	}

	public function setFlowcell(flowcell:Cell):Void {
		this.flowcell = flowcell;
	}

}