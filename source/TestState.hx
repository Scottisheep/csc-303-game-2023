package;

import flixel.FlxState;
import flixel.util.FlxColor;
import tank.Tank;
import tank.controller.move.HorizontalMoveController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;
		var tank = new Tank(300, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
