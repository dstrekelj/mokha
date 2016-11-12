package mokha.math;

import kha.math.Random;

class Random {
    var random : kha.math.Random;

    public function new(?seed : Int = 1) : Void {
        this.random = new kha.math.Random(seed);
    }

    public inline function getInt() : Int {
        return random.Get();
    }

    public inline function getIntIn(min : Int, max : Int) : Int {
        return random.GetIn(min, max);
    }

    public inline function getIntUpTo(max : Int) : Int {
        return random.GetUpTo(max);
    }

    public inline function getFloat() : Float {
        return random.GetFloat();
    }

    public inline function getFloatIn(min : Float, max : Float) : Float {
        return random.GetFloatIn(min, max);
    }

    public inline function getFloatUpTo(max : Float) : Float {
        return getFloatIn(0, max);
    }

    public inline function bool(probability : Float = 0.5) : Bool {
        return probability > getFloatIn(0, 1);
    }

    public inline function sign(probability : Float = 0.5) : Int {
        return bool(probability) ? -1 : 1;
    }
}
