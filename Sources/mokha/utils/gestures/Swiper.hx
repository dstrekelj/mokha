package mokha.utils.gestures;

import mokha.managers.input.MouseInputManager;

import kha.math.FastVector2;

class Swiper {
	public var swipe(get, null) : FastVector2;

	var mouse : MouseInputManager;
	var first : FastVector2;
	var last : FastVector2;

	public function new(mouse : MouseInputManager) : Void {
		this.mouse = mouse;

		swipe = new FastVector2(0, 0);
		first = new FastVector2(0, 0);
		last = new FastVector2(0, 0);
	}

	public function update() : Void {
		if (mouse.justPressed) {
			set(first, mouse.x, mouse.y);
			set(swipe, 0, 0);
		}

		if (mouse.isPressed) {
			set(last, mouse.x, mouse.y);
			calc();
		}

		if (mouse.justReleased) {
			set(last, mouse.x, mouse.y);
			calc();
		}
	}

	public function destroy() : Void {
		mouse = null;
		swipe = null;
		first = null;
		last = null;
	}

	@:noCompletion inline function get_swipe() return swipe;

	inline function set(v : FastVector2, x : Float, y : Float) : Void {
		v.x = x;
		v.y = y;
	}

	inline function calc() : Void {
		swipe = last.sub(first);
	}
}
