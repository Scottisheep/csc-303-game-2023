package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Json;
import openfl.Assets;

class HUD extends FlxTypedGroup<FlxSprite> {
	static inline var HUD_HEIGHT:Int = 24;
	static inline var HUD_COLOR = FlxColor.GRAY;
	static inline var HUD_SIDE_SPACING:Float = 8;
	static inline var HUD_ELEMENT_SIZE:Int = 16;
	static inline var HUD_TEXT_COLOR = FlxColor.BLACK;
	static inline var HUD_TEXT_BORDER_COLOR = FlxColor.WHITE;
	static inline var HUD_TEXT_BORDER_STYLE = OUTLINE;

	var background:FlxSprite;
	var tanksDestroyedIcon:FlxSprite;
	var tanksDestroyedCounter:FlxText;

	public function new(NumberEnemyTanksStart:Int) {
		super();

		setupBackground();
		setupTanksDestroyed();
		setupLevelInformation();
		setupLevelTanksInformation(NumberEnemyTanksStart);
	}

	function setupBackground() {
		background = new FlxSprite(0, FlxG.height - HUD_HEIGHT);
		background.makeGraphic(FlxG.width, HUD_HEIGHT, HUD_COLOR);
		add(background);
	}

	function setupTanksDestroyed() {
		tanksDestroyedIcon = new FlxSprite(0, 0, AssetPaths.place__png);
		tanksDestroyedIcon.x = HUD_SIDE_SPACING;
		tanksDestroyedIcon.y = background.y
			+ (background.height / 2)
			- (tanksDestroyedIcon.height / 2);

		tanksDestroyedCounter = new FlxText();
		tanksDestroyedCounter.text = "0";
		tanksDestroyedCounter.size = HUD_ELEMENT_SIZE;
		tanksDestroyedCounter.x = tanksDestroyedIcon.x
			+ tanksDestroyedIcon.width
			+ HUD_SIDE_SPACING;
		tanksDestroyedCounter.y = tanksDestroyedIcon.getGraphicMidpoint().y
			- (tanksDestroyedCounter.height / 2);
		tanksDestroyedCounter.color = HUD_TEXT_COLOR;
		tanksDestroyedCounter.borderColor = HUD_TEXT_BORDER_COLOR;
		tanksDestroyedCounter.borderStyle = HUD_TEXT_BORDER_STYLE;

		add(tanksDestroyedIcon);
		add(tanksDestroyedCounter);
	}

	function setupLevelInformation() {
		var levelNumber:Int = 1;
		var levelName:String = generateLevelName();
		var levelInformation = new FlxText();

		levelInformation.text = "LEVEL " + levelNumber + ": " + levelName;
		levelInformation.size = HUD_ELEMENT_SIZE;
		levelInformation.x = background.getGraphicMidpoint().x - (levelInformation.width / 2);
		levelInformation.y = tanksDestroyedCounter.y;
		levelInformation.color = HUD_TEXT_COLOR;
		levelInformation.borderColor = HUD_TEXT_BORDER_COLOR;
		levelInformation.borderStyle = HUD_TEXT_BORDER_STYLE;

		add(levelInformation);
	}

	function generateLevelName() {
		var levelNamesText = Assets.getText(AssetPaths.levelNameList__json);
		var levelNamesObj = Json.parse(levelNamesText);
		var levelNamesObjPrefix:Array<String> = levelNamesObj.levelNamePrefixList;
		var levelNamesObjSuffix:Array<String> = levelNamesObj.levelNameSuffixList;

		var levelName = "OPERATION "
			+ levelNamesObjPrefix[FlxG.random.int(0, levelNamesObjPrefix.length - 1)]
			+ " "
			+ levelNamesObjSuffix[FlxG.random.int(0, levelNamesObjSuffix.length - 1)];

		return levelName;
	}

	function setupLevelTanksInformation(levelTanksStart:Int) {
		var levelTanksRemain:Int = levelTanksStart;
		var levelTanksIcon = new FlxSprite(0, 0, AssetPaths.place__png);
		var levelTanksInformation = new FlxText();

		levelTanksInformation.text = levelTanksRemain + " / " + levelTanksStart;
		levelTanksInformation.size = HUD_ELEMENT_SIZE;
		levelTanksInformation.x = FlxG.width - levelTanksInformation.width - HUD_SIDE_SPACING;
		levelTanksInformation.y = tanksDestroyedCounter.y;
		levelTanksInformation.color = HUD_TEXT_COLOR;
		levelTanksInformation.borderColor = HUD_TEXT_BORDER_COLOR;
		levelTanksInformation.borderStyle = HUD_TEXT_BORDER_STYLE;

		levelTanksIcon.x = levelTanksInformation.x - levelTanksIcon.width - HUD_SIDE_SPACING;
		levelTanksIcon.y = tanksDestroyedIcon.y;

		add(levelTanksIcon);
		add(levelTanksInformation);
	}
}
/**	
	TODO: Create update Level Number function.	
	TODO: Create update Tanks Destroyed function (both remaining and overall).
	TODO: Replace placeholder images. Not sure on artistic abilities.
**/
