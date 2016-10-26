package mokha.utils.tween;

import mokha.Mokha;

/**
    A basic implementation of a tweening engine. Tweens are
    cleared as soon as they're finished - they are not
    reusable.
**/
class Tweener {
    /**
        The total number of tweens handled by the tweener.
    **/
    var tweenCount : Int;

    /**
        A map of all active tweens.
    **/
    var tweens : Map<Int, Tween>;

    /**
        A reference to the currently updated tween, kept
        separate for the sake of performance.
    **/
    var tween : Tween;

    /**
        Total running time of tweener.
    **/
    var runningTime : Float;

    /**
        Creates new tweener.
    **/
    public function new() : Void {
        tweenCount = 0;
        tweens = new Map<Int, Tween>();
        tween = null;
        runningTime = 0;
    }

    /**
        Updates running time and tweens. Ensures tweens
        which are not active any more get destroyed and
        removed from the map.
    **/
    public function update() : Void {
        runningTime += Mokha.delta;

        for(key in tweens.keys()) {
            tween = tweens.get(key);
            if (tween.endTime >= runningTime) {
                tween.update((runningTime - tween.startTime) / tween.duration);
            } else {
                tween.destroy();
                tweens.remove(key);
            }
        }
    }

    /**
        Starts a tween, adding it to the tweener's map of
        tweens. Tweens are mapped to an integer key unique
        to the current tweener.
        @param	from		Value to tween from
        @param	to			Value to tween to
        @param	duration	Tween duration
        @param	callback	Function to execute with every tween
    **/
    public function start(from : Float, to : Float, duration : Float, callback : Float->Void) : Void {
        tweens.set(tweenCount, new Tween(runningTime, from, to, duration, callback));
        tweenCount += 1;
    }

    /**
        Destroys tweener, nulling references.
    **/
    public function destroy() : Void {
        tweens = null;
        tween = null;
    }
}

/**
    A basic tween object. A tween specifies a `from` and
    `to` value which is interpolated according to a
    tweening function. A tween also has a start time,
    duration, and end time, all of which are used to
    determine whether a tween should still be handled by the
    tweener (tweening engine).
**/
private class Tween {
    /**
        Time when tween was created.
    **/
    public var startTime(get, null) : Float;

    /**
        Time when tween will end.
    **/
    public var endTime(get, null) : Float;

    /**
        Time it takes for tween to finish.
    **/
    public var duration(get, null) : Float;
    
    /**
        Value from which to interpolate.
    **/
    var from : Float;

    /**
        Value to which to interpolate.
    **/
    var to : Float;

    /**
        Callback function which is called with the interpolated
        value.
    **/
    var callback : Float->Void;

    /**
        Creates a new tween.
        @param	startTime	Time at which tween was created
        @param	from		Value from which to interpolate
        @param	to			Value to which to interpolate
        @param	duration	Time until tween completion
        @param	callback	Function which is called with the interpolated value
    **/
    public function new(startTime : Float, from : Float, to : Float, duration : Float, callback : Float->Void) {
        this.startTime = startTime;
        this.duration = duration;

        this.from = from;
        this.to = to;
        this.callback = callback;

        endTime = startTime + duration;
    }

    /**
        Updates tween according to a tweening function
        (currently, linear interpolation).
        @param	t	Ratio of time passed and tween end time.
    **/
    public function update(t : Float) : Void {
        callback((1 - t) * from + t * to);
    }

    /**
        Destroys tween, nulling references.
    **/
    public function destroy() : Void {
        callback = null;
    }

    @:noCompletion inline function get_startTime() return startTime;

    @:noCompletion inline function get_endTime() return endTime;

    @:noCompletion inline function get_duration() return duration;
}
