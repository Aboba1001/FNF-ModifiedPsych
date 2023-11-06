package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import ColorblindFilters;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hide Watermark',
		        "If checked, hides a watermark during a song.",
			'watermark',
		        'bool',
                        false);
                addOption(option);

		var option:Option = new Option('Colorblind Filter:',
			"You can set colorblind filter (makes the game more playable for colorblind people)",
		        'colorblindMode',
			'string',
		        'None',
			['None', 'Deuteranopia', 'Protanopia', 'Tritanopia']);
		option.onChange = ColorblindFilters.applyFiltersOnGame;
		addOption(option);

		var option:Option = new Option('Hide Judgement Counter',
			'If checked, hides judgement during a song.',
			'hideJudgements',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hide Striped Health Bar',
		       "Like in OS Engine, health bar has stripes on it.",
	 	       'stripedBar',
		       'bool',
		       false);
		addOption(option);

		var option:Option = new Option('Show Timing Counter',
			'If checked, a offset (in ms) will appear near notes',
			'showMsText',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Longer Time Bar',
			' ',
		        'longTimeBar',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Rainbow FPS',
		        'If checked, makes the Info Display cycle between a rainbow of colors.',
		        'rainbowFPS',
			'bool',
			false);
                addOption(option);

		var option:Option = new Option('Show Framerate',
			'If unchecked, the framerate will be in Info Display.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;

		var option:Option = new Option('Show Total Framerate',
			'If checked, shows Total FPS in Info Display.',
			'showTotalFPS',
			'bool',
			false);
		addOption(option);
		

		var option:Option = new Option('Show Memory Usage',
			'If checked, current memory usage in MB will be in the Info Display.',
			'showMemory',
			'bool',
			false);
                addOption(option);
		option.onChange = onChangeFPSCounter;

		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Show RT Engine Watermark',
		        "If checked, the RT Engine watermark and version number will be in the Info Display.",
                        'showVersion',
			'bool',
			false);
	        addOption(option);

		var option:Option = new Option('Debug Info',
			" ",
			'debugInfo',
			'bool',
			false);
		addOption(option);
			
		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.8;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool',
			true);
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
}
