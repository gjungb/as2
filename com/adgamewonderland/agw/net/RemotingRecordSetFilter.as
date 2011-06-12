/**
 * @author gerd
 */

import mx.remoting.RecordSet;

class com.adgamewonderland.agw.net.RemotingRecordSetFilter {
	
	public static var MODE_AND:Number = 1;
	
	public static var MODE_OR:Number = 2;
	
	public static var MODE_LESS:Number = 3;
	
	public static function filterRecordSet(rs:RecordSet, mode:Number, where:Object ):RecordSet
	{
//		for (var field:String in where) {
//			trace(field + ": " + where[field]);
//		}
		
		// filter
		var filter:Function;
		// je nach modus
		switch (mode) {
			case MODE_AND :
				filter = andFilter;
				break;
			case MODE_OR :
				filter = orFilter;
				break;
			case MODE_LESS :
				filter = lessFilter;
				break;
		}
		// filtern und zurueck geben
		return rs.filter(filter, where);
	}
	
	private static function andFilter(item:Object, where:Object ):Boolean
	{
		for (var field:String in where) {
			if (item[field] != where[field]) return false;
		}
		return true;
	}
	
	private static function orFilter(item:Object, where:Object ):Boolean
	{
		for (var field:String in where) {
			if (item[field] == where[field]) return true;
		}
		return false;
	}
	
	private static function lessFilter(item:Object, where:Object ):Boolean
	{
		for (var field:String in where) {
			if (item[field] < where[field]) return true;
		}
		return false;
	}
}