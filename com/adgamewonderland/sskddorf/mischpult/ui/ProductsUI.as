/**
 * @author gerd
 */

import com.adgamewonderland.sskddorf.mischpult.beans.*;

import com.adgamewonderland.sskddorf.mischpult.data.*;

import com.adgamewonderland.sskddorf.mischpult.ui.*;

class com.adgamewonderland.sskddorf.mischpult.ui.ProductsUI extends MovieClip {
	
	private var list1_mc:ProductListUI;
	
	private var list2_mc:ProductListUI;
	
	private var list3_mc:ProductListUI;
	
	public function ProductsUI() {
		
	}
	
	public function onProductsChanged():Void
	{
		// eingaben des users
		var userinput:UserInput = DataProvider.getInstance().getUserinput();
		// schleife ueber produktkategorien
		for (var i:Number = 1; i <= DataProvider.getInstance().getNumProduktkategorien(); i++) {
			// aktuelle produktkategorie
			var produktkategorie:Produktkategorie = DataProvider.getInstance().getProduktkategorieByID(i);
			// summe
			var summe:Number = DataProvider.getInstance().getWeighting().getSummeByProduktkategorie(produktkategorie);
			// entsprechende produktempfehlungen
			var produkte:Array = DataCalculator.getInstance().getProduktemfehlungen(userinput, produktkategorie, summe);
			// entsprechende liste
			var list:ProductListUI = this["list" + i + "_mc"];
			// produkte oder defaulttext anzeigen lassen
			if (produkte.length > 0) {
				// produkte anzeigen lassen
				list.showProducts(produkte);
			} else {
				// defaulttext anzeigen lassen
				list.showDefaulttext(produktkategorie.getDefaulttext());
			}
		}
	}
}