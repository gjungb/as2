import com.adgamewonderland.cma.adventskalender2006.beans.*;
import com.adgamewonderland.cma.adventskalender2006.util.*;

/**
 * Darstellung eines Rezepts mit Link zu weiterführenden Informationen auf der Bühne
 */
class com.adgamewonderland.cma.adventskalender2006.ui.RecipeUI extends MovieClip
{
	private var recipe:com.adgamewonderland.cma.adventskalender2006.beans.Recipe;
	private var recipe_txt:TextField;
	private var hitarea_mc:MovieClip;

	public function RecipeUI()
	{
	}

	/**
	 * Rezept anzeigen
	 * @param recipe Rezept gekapselt in entsprechendem Bean
	 */
	public function showRecipe(recipe:com.adgamewonderland.cma.adventskalender2006.beans.Recipe):Void
	{
		// rezept speichern
		setRecipe(recipe);
		// rezept anzeigen
		recipe_txt.text = getRecipe().getName();
	}

	public function onLoad():Void
	{
		// hitarea erzeugen
		hitarea_mc = CalendarUtils.createHitarea(this, recipe_txt);
		// als hitarea
		this.hitArea = hitarea_mc;
		// workaround, da bei jedem schluesselbild der maske onLoad aufgerufen wird
		showRecipe(Adventcalendar.getInstance().getRecipelist().getRecipeByDay(_parent.getQuiz().getDay()));
	}

	/**
	 * Link aufrufen
	 */
	public function onRelease():Void
	{
		// link zu rezept aufrufen
		getURL(getRecipe().getUrl(), "_blank");
	}

	public function setRecipe(recipe:com.adgamewonderland.cma.adventskalender2006.beans.Recipe):Void
	{
		this.recipe = recipe;
	}

	public function getRecipe():com.adgamewonderland.cma.adventskalender2006.beans.Recipe
	{
		return this.recipe;
	}
}