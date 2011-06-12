import com.adgamewonderland.agw.util.ArrayUtil;
import com.adgamewonderland.ea.bat.data.*;
import com.adgamewonderland.ea.bat.logic.*;

class com.adgamewonderland.ea.bat.logic.Predictor
{
	private var _publisherList:Array;

	function calculateMonthlyValues(distribution:Array,c:ComputedValues,avgTurn:Number) : Array
	{
		var anualValue:Number = (12 * c.realRevenue) * 12 / c.stockTurn;

		var monthly = [];

		for (var i:Number=0; i<12; i++)
		{
			var p:Number = distribution[i];
			monthly.push(p * anualValue);
		}

		return monthly;
	}
	
	function calculateDailyUnits(revenue:Number, percentage:Number ):Number
	{	
		// Täglich zu bewegende Stückzahl = (Umsatzziel * %Anteil Games * 2 +  
		//	Umsatzziel * %Anteil Games * 0,3) / Durchschnittspreis / Arbeitstage
		return Math.round((revenue * percentage * 2.3) / getAvgPrice() / 260);
	}

	function compute(revenue:Number, stockTurns:Array, avgTurn:Number) : Array
	{
		avgTurn = Math.round(avgTurn*100)/100;

		// Basiswerte
		var computeBaseValues:Function = function(p:PublisherData) : ComputedValues
		{
			var c:ComputedValues = new ComputedValues(); 

			c.targetRevenue = revenue*p.share;	// Umsatzziel Jahr
			c.targetRevenueByMonth = c.targetRevenue / 12.0;		// Umsatzziel monatl.
			c.inStoreValue = c.targetRevenue / avgTurn;				// Lagerwert / Monat
			c.stock = c.inStoreValue / p.avgPrice;					// Lagerwert / Durchschnittspreis

			return c;
		};

		// -----------------------------------------------------------------------

		var values:Array = ArrayUtil.map( _publisherList, computeBaseValues );

		// Berechne "�nderung Lager/St�ck"

		var hasStockDiff:Boolean = false;	// �nderungen vorhanden
		var stockDiffTotal:Number = 0;		// Summe �nderungen

		var turn:Number;					

		for (var i:Number=0; i<_publisherList.length; i++)
		{
			var c:ComputedValues = values[i];
			var p:PublisherData = _publisherList[i];

			turn = Math.round(stockTurns[i]*100)/100;
			c.stockTurn = turn;
			
			var equalTurn:Boolean = Math.round(turn*100)==Math.round(avgTurn*100);
			if (!equalTurn)	// ver�nderte Lagerdrehung
			{
				hasStockDiff = true;

				// Jahresumsatz / (Durchschnittszahl * Lagerdrehung)
				var n:Number = c.targetRevenue / ( p.avgPrice * turn ); 
				c.stockDiff = n - c.stock;

				stockDiffTotal += c.stockDiff;
			} 
			else // keine �nderung 
			{
				c.stockDiff = 0;
			}
		}

		// --------------------------------------------------------------

		// Berechne Umsatz
		for (var i:Number=0; i<_publisherList.length; i++)
		{
			var p:PublisherData = _publisherList[i];
			var c:ComputedValues = values[i];

			// "Neue St�ck/Lager/Monat (Hilfswert in Spalte J)"
			var inStock:Number;
			turn = stockTurns[i];

			if (hasStockDiff) // �nderung vorhanden
			{
				if (turn!=avgTurn)
				{
					inStock = c.stock + c.stockDiff;
					c.reach = 52 / turn; // Lagerreichweite
				} 
				else 
				{
					inStock = c.stock - stockDiffTotal * p.share; 
					c.reach = 52 / avgTurn; // Lagerreichweite
				}
			} 
			else 
			{
				inStock = c.stock;
				c.reach = 52 / avgTurn; // Lagerreichweite
			}

			if (inStock < c.stock)
			{
				c.realRevenue = inStock * p.avgPrice * (avgTurn / 12);		
			} 
			else 
			{
				c.realRevenue = c.targetRevenueByMonth;
			}
		}

		return values;
	}

	// Konstruktor
	function Predictor(publisherList:Array)
	{
		_publisherList = publisherList;
	}
	
	private function getAvgPrice():Number
	{
		var total:Number = 0;
		for (var i:String in _publisherList) {
			var p:PublisherData = _publisherList[i];
			total += p.avgPrice;
		}
		return (total / _publisherList.length);
	}
};
