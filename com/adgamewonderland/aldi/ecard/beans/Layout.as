/* 
 * Generated by ASDT 
*/ 

import com.adgamewonderland.aldi.ecard.beans.Item;
import com.adgamewonderland.aldi.ecard.beans.ItemGraphics;
import com.adgamewonderland.aldi.ecard.beans.ItemText;

class com.adgamewonderland.aldi.ecard.beans.Layout {
	
	private var background:Number;
	
	private var foreground:Number;
	
	private var items:Array;
	
	public function Layout() {
		this.background = 0;
		this.foreground = 0;
		this.items = [];
	}
	
	public function getAsXml():XML {
		// xml
		var layout:XML = new XML("<layout />");
		// background
		layout.firstChild.attributes["background"] = getBackground();
		// foreground
		layout.firstChild.attributes["foreground"] = getForeground();
		// schleife ueber alle items
		for (var i:Number = 0; i < items.length; i++) {
			// aktuelles item
			var item:Item = items[i];
			// einhaengen
			layout.firstChild.appendChild(item.getAsXml().firstChild);		
		}
		// zurueck geben
		return layout;
	}
	
	public function parseFromXml(desc:XML):Void {
		// layout
		var layout:XMLNode = desc.firstChild;
		// background
		setBackground(layout.attributes["background"]);
		// foreground
		setForeground(layout.attributes["foreground"]);
		// items
		var items:Array = layout.childNodes;
		// schleife ueber items
		for (var i:Number = 0; i < items.length; i++) {
			// aktuelles item
			var item:XMLNode = items[i];
			// type
			var type:String = item.attributes["type"];
			// hinzufuegen
			addItem(type, item);
		}
	}
	
	public function getBackground():Number {
		return background;
	}

	public function setBackground(background:Number):Void {
		this.background = background;
	}

	public function getItems():Array {
		return items;
	}

	public function setItems(items:Array):Void {
		this.items = items;
	}

	public function getForeground():Number {
		return foreground;
	}

	public function setForeground(foreground:Number):Void {
		this.foreground = foreground;
	}
	
	private function addItem(type:String, desc:XMLNode ):Void {
		// aktuelle id
		var id:Number = getItems().length;
		
		var item;
		// je nach type
		switch (type) {
			// graphics
			case "graphics" :
				// neues item
				item = new ItemGraphics(id);
				// motif
				item.setMotif(Number(desc.attributes["motif"]));
				
				break;	
			// text
			case "text" :
				// neues item
				item = new ItemText(id);
				// color
				item.setColor(Number(desc.attributes["color"]));
				// font
				item.setFont(desc.attributes["font"]);
				// text
				item.setText(unescape(desc.firstChild.nodeValue));
			
				break;
			// unbekannt
			default :
				// item
				item = new Item(id);
		}
		// x
		item.setX(Number(desc.attributes["x"]));
		// y
		item.setY(Number(desc.attributes["y"]));
		// scale
		item.setScale(Number(desc.attributes["scale"]));
		// speichern
		getItems().push(item);
	}

}