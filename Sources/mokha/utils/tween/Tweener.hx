package mokha.utils.tween;

import mokha.Mokha;

class Tweener {
	var ids : Int;
	var tweens : Map<Int, Tween>;
	var tween : Tween;
	var startTime : Float;
	var runningTime : Float;

	public function new() : Void {
		tweens = new Map<Int, Tween>();
		startTime = 0;
		runningTime = 0;
		ids = 0;
		tween = null;
	}

	public function update() : Void {
		runningTime += Mokha.delta;

		for (tween in tweens) {
			if (tween.endTime >= runningTime) {
				tween.update((runningTime - tween.startTime) / tween.duration);
			}
		}
	}

	public function add(from : Float, to : Float, duration : Float, callback : Float->Void) : Int {
		tweens.set(ids, new Tween(from, to, duration, callback));
		ids += 1;
		return ids - 1;
	}

	public function remove(tweenId : Int) : Void {
		if (tweens.exists(tweenId)) {
			tweens.get(tweenId).destroy();
			tweens.remove(tweenId);
		}
	}

	public function start(tweenId : Int) : Void {
		if (tweens.exists(tweenId)) {
			tweens.get(tweenId).start(runningTime);
		}
	}

	public function destroy() : Void {
		ids = null;
		tweens = null;
		tween = null;
		startTime = null;
		runningTime = null;
	}
}

private class Tween {
	public var startTime : Float;
	public var endTime : Float;
	public var duration : Float;
	
	var from : Float;
	var to : Float;
	var callback : Float->Void;

	public function new(from : Float, to : Float, duration : Float, callback : Float->Void) {
		this.duration = duration;

		this.from = from;
		this.to = to;
		this.callback = callback;
	}

	public function update(t : Float) : Void {
		callback((1 - t) * from + t * to);
	}

	public function start(startTime : Float) : Void {
		this.startTime = startTime;
		
		endTime = startTime + duration;
	}

	public function destroy() : Void {
		startTime = null;
		endTime = null;
		duration = null;
		callback = null;
	}
}
